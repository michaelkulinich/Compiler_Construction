module TypeChecker ( typecheck ) where

import AbsCPP
import ErrM
import PrintCPP

import Data.Map ( Map )
import qualified Data.Map as M
import Data.Set ( Set )
import qualified Data.Set as S
import Data.List ( intercalate, intersperse )
import Control.Monad ( foldM, foldM_, forM_, unless )


newtype Alternative a = Alternative [a]
instance Print a => Print (Alternative a) where
    prt i (Alternative xs) =
        ((foldr (.) id) . (intersperse (doc (showString "/"))) . map (prt i)) xs


typeMismatchError :: (Print e, Print t1, Print t2) => e -> t1 -> t2 -> String
typeMismatchError e tExp tFound =
    "TYPE ERROR\n\n" ++
    "Expected " ++ printTree e ++ " to have type " ++ printTree tExp ++
    " instead found type " ++ printTree tFound ++ "."


ok :: Err ()
ok = Ok ()


type FunctionType = ([Type], Type)
type Sig = Map Id FunctionType
type Context = Map Id Type
type Env = (Sig, [Context])


lookupFun :: Env -> Id -> Err FunctionType
lookupFun (sig,_) id = case M.lookup id sig of
    Just ty -> return ty
    Nothing -> fail $ "TYPE ERROR\n\n" ++ printTree id ++ " was not declared."


insertFun :: Env -> Id -> FunctionType -> Err Env
insertFun (sig,ctxt) i t = do
    case M.lookup i sig of
        Just _  -> fail $
            "TYPE ERROR\n\nFailed to add "
            ++ printTree i ++ "to the symbol table, as it is already defined"
        Nothing -> return (M.insert i t sig, ctxt)


lookupVar :: Id -> Env -> Err Type
lookupVar i (_,[]) = fail $ "TYPE ERROR\n\n" ++ printTree i ++ " was not declared."
lookupVar i (sig,c:ctxt) = case M.lookup i c of
    (Just f) -> return f
    Nothing -> lookupVar i (sig,ctxt)


insertVar :: Env -> Id -> Type -> Err Env
insertVar (_, []) _ _ = fail $ "Internal error, this should not happen."
insertVar (sig, c:ctxt) i t =
    case M.lookup i c of
        Just _  -> fail $
            "TYPE ERROR\n\nFailed to add "
            ++ printTree i ++ "to the context, as it is already defined within this block."
        Nothing ->
            if t == Type_void then
                fail $ "TYPE ERROR\n\nCannot declare variable " ++ printTree i ++ " as void."
            else
                return (sig, (M.insert i t c):ctxt)


newBlock :: Env -> Env
newBlock (sig,ctxt) = (sig, M.empty:ctxt)


emptyEnv :: Env
emptyEnv = (M.fromList
    [
        (Id "printInt",    ([Type_int],    Type_void))
      , (Id "printDouble", ([Type_double], Type_void))
      , (Id "readInt",     ([],            Type_int))
      , (Id "readDouble",  ([],            Type_double))
    ], [M.empty])


buildEnv :: [Def] -> Err Env
buildEnv [] = return emptyEnv
buildEnv (DFun t i arg _:xs) = do
    env <- buildEnv xs
    insertFun env i (map (\(ADecl t _) -> t) arg, t)


typecheck :: Program -> Err ()
typecheck (PDefs []) = fail $ "TYPE ERROR\n\nFile cannot be empty."
typecheck (PDefs defs) = do
    env <- buildEnv defs
    forM_ defs (checkDef env)


checkDef :: Env -> Def -> Err ()
checkDef env (DFun ty (Id n) args stms) = do
    if (n == "main") then checkMain ty args else ok
    env' <- foldM (\e (ADecl ty' i) -> insertVar e i ty') env args
    foldM_ (\e s -> checkStm e s ty) env' stms


checkMain :: Type -> [Arg] -> Err ()
checkMain Type_int [] = ok
checkMain Type_int xs = fail $ "TYPE ERROR\n\nError, main cannot have arguments."
checkMain ty _ = fail $ typeMismatchError (Id "main") Type_int ty

{-
In env' <- checkStm env stm ty we have
    env: the current environment
    stm: the stm to be checked for validity
    ty: the return type of the function in which stm appears (needed for SReturn and SReturnVoid)
    env': the updated environment (stm may be variable declaration)
          or an error message (if stm is not valid)
-}
checkStm :: Env -> Stm -> Type -> Err Env
checkStm env (SExp e) ty = do
    inferTypeExp env e
    return env
checkStm env (SDecls ty' ids) ty =
    foldM (\e i -> insertVar e i ty') env ids
checkStm env (SReturn e) ty = do
    checkExp env e ty
    return env

checkStm env (SInit ty' i e) ty = do
    -- insertVar env i ty'
    env' <- insertVar env i ty'
    checkExp env' e ty'
    return env'

checkStm env SReturnVoid Type_void = return env
-- the next case is only executed in case ty is not Type_void
checkStm env SReturnVoid ty = do
    fail $ typeMismatchError SReturnVoid Type_void ty

checkStm env (SWhile e stm) ty = do
    checkExp env e Type_bool
    foldM(\e stm -> checkStm e stm ty) (newBlock env) [stm]
    return env


checkStm env (SBlock stms) ty = do
    foldM(\e stm -> checkStm e stm ty) (newBlock env) stms
    return env

checkStm env (SIfElse e stm1 stm2) ty = do
    checkExp env e Type_bool
    foldM(\e stm -> checkStm e stm ty) (newBlock env) [stm1]
    foldM(\e stm -> checkStm e stm ty) (newBlock env) [stm2]
    return env

{-
Once you have all cases you can delete the next line which is only needed to catch all cases that are not yet implemented.
-}
-- checkStm _ s _ = fail $ "Missing case in checkStm encountered:\n" ++ printTree s


{-
In ty <- inferTypExp env e we have
    env: the current environment
    e: the expression
    ty: the type of e
        or an error message (if we cannot assign a type to e)
-}
inferTypeExp :: Env -> Exp -> Err Type
inferTypeExp env (EInt _) = return Type_int
inferTypeExp env (EDouble _) = return Type_double
inferTypeExp env (EString _) = return Type_string
inferTypeExp env (ETrue) = return Type_bool
inferTypeExp env (EFalse) = return Type_bool
inferTypeExp env (EId i) = do
    ty <- lookupVar i env
    return ty
inferTypeExp env (EApp i exps) = do
    ty <- lookupFun env i
    if(length (fst ty) /= (length exps)) then fail "wrong number"
    else do forM_ (zip exps (fst ty)) (\p -> checkExp env (fst p) (snd p))
    return (snd ty)
inferTypeExp env (EPIncr e) = inferTypeOverloadedExp env (Alternative[Type_int, Type_double]) e [e]
inferTypeExp env (EPDecr e) = inferTypeOverloadedExp env (Alternative[Type_int, Type_double]) e [e]
inferTypeExp env (EIncr e) = inferTypeOverloadedExp env (Alternative[Type_int, Type_double]) e [e]
inferTypeExp env (EDecr e) = inferTypeOverloadedExp env (Alternative[Type_int, Type_double]) e [e]
inferTypeExp env (ETimes e1 e2) = inferTypeOverloadedExp env (Alternative [Type_int, Type_double]) e1 [e2]
inferTypeExp env (EDiv e1 e2) = inferTypeOverloadedExp env (Alternative [Type_int, Type_double]) e1 [e2]
inferTypeExp env (EPlus e1 e2) = inferTypeOverloadedExp env (Alternative [Type_int, Type_double]) e1 [e2]
inferTypeExp env (EMinus e1 e2) = inferTypeOverloadedExp env (Alternative [Type_int, Type_double]) e1 [e2]
inferTypeExp env (ELt e1 e2) = do
    inferTypeOverloadedExp env (Alternative [Type_int, Type_double]) e1 [e2]
    return Type_bool
inferTypeExp env (EGt e1 e2) = do
    inferTypeOverloadedExp env (Alternative [Type_int, Type_double]) e1 [e2]
    return Type_bool
inferTypeExp env (ELtEq e1 e2) = do
    ty <- inferTypeExp env e1
    checkExp env e2 ty
    return Type_bool
inferTypeExp env (EGtEq e1 e2) = do
    inferTypeOverloadedExp env (Alternative [Type_int, Type_double]) e1 [e2]
    return Type_bool
inferTypeExp env (EEq e1 e2) = do
    inferTypeOverloadedExp env (Alternative [Type_int, Type_double, Type_bool]) e1 [e2]
    return Type_bool
inferTypeExp env (ENEq e1 e2) = do
    ty <- inferTypeExp env e1
    checkExp env e2 ty
    return Type_bool
inferTypeExp env (EAnd e1 e2) = do
    ty <- inferTypeExp env e1
    checkExp env e2 Type_bool
    return Type_bool
inferTypeExp env (EOr e1 e2) = do
    checkExp env e1 Type_bool
    checkExp env e2 Type_bool
    return Type_bool

inferTypeExp env (EAss e1 e2) = do
    ty <- inferTypeExp env e1
    checkExp env e2 ty
    return ty
inferTypeExp env (ETyped e ty) = do
    checkExp env e ty
    return ty



{-
Once you have all cases you can delete the next line which is only needed to catch all cases that are not yet implemented.
-}
inferTypeExp _ e = fail $ "Missing case in inferTypeExp encountered:\n" ++ printTree e


inferTypeOverloadedExp :: Env -> Alternative Type -> Exp -> [Exp] -> Err Type
inferTypeOverloadedExp env (Alternative ts) e es = do
    ty <- inferTypeExp env e
    unless (ty `elem` ts) $
        fail $ typeMismatchError e (Alternative ts) ty
    forM_ es (flip (checkExp env) ty)
    return ty

-- inferTypeOverLoadedExp :: Env -> Exp -> Exp -> Err Type
-- inferTypeOverLoadedExp env a b = do
   -- typ <- inferExp env a

checkExp :: Env -> Exp -> Type -> Err ()
checkExp env e ty = do
    ty' <- inferTypeExp env e
    unless (ty == ty') $
        fail $ typeMismatchError e ty ty'
