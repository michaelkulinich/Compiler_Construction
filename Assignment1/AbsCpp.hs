-- Haskell data types for the abstract syntax.
-- Generated by the BNF converter.

{-# LANGUAGE GeneralizedNewtypeDeriving #-}

module AbsCpp where

import Prelude (Char, Double, Integer, String)
import qualified Prelude as C (Eq, Ord, Show, Read)
import qualified Data.String

newtype Id = Id String
  deriving (C.Eq, C.Ord, C.Show, C.Read, Data.String.IsString)

data Program = PDefs [Def]
  deriving (C.Eq, C.Ord, C.Show, C.Read)

data Def = DFun Type Id [Arg] [Stm]
  deriving (C.Eq, C.Ord, C.Show, C.Read)

data Arg = ADecl Type Id
  deriving (C.Eq, C.Ord, C.Show, C.Read)

data Stm
    = SExp Exp
    | SDecls Type [Id]
    | SInit Type Id Exp
    | SReturn Exp
    | SReturnVoid
    | SWhile Exp Stm
    | SBlock [Stm]
    | SIfElse Exp Stm Stm
  deriving (C.Eq, C.Ord, C.Show, C.Read)

data STM = SDecl Type Id
  deriving (C.Eq, C.Ord, C.Show, C.Read)

data Exp
    = ETrue
    | EFalse
    | EInt Integer
    | EDouble Double
    | EString String
    | EId Id
    | EQConst Exp Exp
    | EApp Id [Exp]
    | EPIncr Exp
    | EPDecr Exp
    | EIncr Exp
    | EDecr Exp
    | ETimes Exp Exp
    | EDiv Exp Exp
    | EPlus Exp Exp
    | EMinus Exp Exp
    | ELShift Exp Exp
    | ELt Exp Exp
    | EGt Exp Exp
    | ELtEq Exp Exp
    | EGtEq Exp Exp
    | EEq Exp Exp
    | ENEq Exp Exp
    | EAnd Exp Exp
    | EOr Exp Exp
    | EAss Exp Exp
    | ETyped Exp Type
  deriving (C.Eq, C.Ord, C.Show, C.Read)

data Type
    = Type_bool | Type_int | Type_double | Type_void | Type_string
  deriving (C.Eq, C.Ord, C.Show, C.Read)

