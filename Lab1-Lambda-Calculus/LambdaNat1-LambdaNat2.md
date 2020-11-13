<!--
## Solution: From LambdaNat1 to LambdaNat2 

We deal with the case where we use the grammar

        e ::= \ x. e | e e | x | 0 | S e

and encourage you to explore other possibilities as further exercises.

Adding `0 | S e` to BNFC leads us to add to the following, see [`LambdaNat2.cf`]() for the full grammar.

    ENat0.  Exp3 ::= "0" ;
    ENatS.  Exp3 ::= "S" Exp3 ; 

This means that compared to [`LambdaNat0.cf`](), we have to more rules named `ENat0` and `ENatS`. Accordingly, we need to add to the old interpreter two cases. 

    evalCBN (ENatS e) = ENatS (evalCBN e)
    evalCBN ENat0 = ENat0

These need to be inserted before

    evalCBN x = x

which is a catch-all clause.

Similarly in the code for substitution

    subst id s (ENatS e) = ENatS (subst id s e) 
    subst id s ENat0 = ENat0 

With these changes, and keeping to the steps in the Work Cycle, you should be able to build the interpreter and then run a program like in

    echo "(\ x . S x) S S 0" | stack exec LambdaNat-exe

and obtain

    S S S 0

as output.

## From LambdaNat2 to LambdaNat3 (conditionals)

We go through the Work Cycle to add if-then-else. 

Start at Work Cycle 5b. `LambdaNatOld` is `LambdaNat2`. You can start from [`../Lab1-solutions/LambdaNat2](https://github.com/alexhkurz/programming-languages-2020/tree/master/Lab1-solutions/LambdaNat2).

As abstract syntax we may choose (fill in the dots)

        e ::= \ x. e | e e | x | 0 | S e | ... 

If you want to see my grammar you find it in `LambdaNat3/grammar`. You will need to know the grammar, when are going to write an actual program in the language. 

But to modify the interpreter so that it can deal with if-then-else, we only need to know that in the definition of the abstact syntax in `LambdaNat3/grammar/AbsLambdaNat.hs`, there is one new case now, namely 

        EIf Exp Exp Exp Exp

The trick is to use Haskell's if-then-else in order to implement the interpreter for this case. 

Can you guess how to do this? I will tell you that Haskell's syntax for a conditional is

     "if" Exp "==" Exp "then" Exp "else" Exp

As in the previous section, `subst` may also need modification. And don't forget the other steps in the Work Cycle.

In the end you should be able to run 

## From LambdaNat3 to LambdaNat4 (recursion)

Adding recursion is more tricky. We are doing this in two steps.

### **The `let` construct**

The `let` construct is a good example for syntactic sugar. It makes the code look nicer but that is all. In this case we want to write something like

    let plus_one = \ x. S x in 
      plus_one S 0

What is so nice about this is that we said some time ago that lambda functions are nameless. We also said that this does not matter. Now you can see why this is case:

In the above code the first line `let plus_one = \ x. S x in` acts as a declaration, defining the name `plus_one` that can then be used in the "block" that follows the `in`.

**Activity:** Write down a rule in BNFC for the `let` construct. Name it `ELet.`

To say that the `let` construct is syntactic sugar means that it can easily be implemented in the language we have already. How would that work?

    let f = A in B

is nothing but

    (\ f . B) A

Essentially, we just switch the order of `A` and `B`.

Another aspect of syntactic sugar is that we do not need a new computation rule for the interpreter. We simply let the interpreter translate `let f = A in B` into `(\ f . B) A`. In Haskell

    evalCBN (ELet id e1 e2) = evalCBN (EApp (EAbs id e2) e1)

Now go through the Work Cycle and test with

    echo "let plus_one = \ x. S x in plus_one S 0" | stack exec LambdaNat-exe

which should give the output

    S S 0


### **The `let rec` construct**

In order to implement recursion we use a trick from theoretical computer science, namely the so-called **fixed point combinator**. We write the fixed point combinator as `fix`. It is just a new constant, like `0` or `S`. But we equip it with an interesting computation rule, namely

    fix F -> F(fix F)

The name "fixed point combinator" comes from the fact that `fix F` is indeed a fixed point of `F`: The computation rule says that `F` applied to `fix F` is `fix F` itself. One curious thing about the rule is that it seems to go in the wrong direction as the output of the rule looks more complicated then the input. This is quite mysterious. Can this work at all?

Let us just implement it and see what happens. (We are engineers, so whatever works is fine.) 

First, for the grammar, we just add to the BNFC grammar the line

    EFix.      Exp2 ::= "fix" Exp ; 

The rule 

    fix F -> F(fix F)
    
is easy to translate to Haskell. Just remember that `F(fix F)` is an application of `F` to `fix F` (and that `fix` is represented by `EFix` in the abstract syntax). This gives us:

    evalCBN (EFix e) = evalCBN (EApp e (EFix e))

Now you can build an interpreter that can execute the following program:

    let rec f = \ x. if x = S S S 0 then Hello_World else f (S x) in 
      f 0 

Admittedly, this program is not doing anything interesting. It is just going through a "for loop" from 0 to 3 and outputs a variable named `Hello_World` at the end.

**Activity:** Can you think of a more interesting program we could use for testing.

**Hint:** If you got stuck at writing the interpreter, there is a trick. Recall that `let` is interpreted via

    let f = A in B -> (\ f . B ) A

Similarly, `let rec` is interpreted 

    let rec f = A in B -> (\ f . B ) (fix ( \ f . A)) 
    
The right hand side of the rule for `let rec` can be implemented in much the same as the right hand side of the rule for `let`.

### **Minus One or the Predecessor**

In order to write more interesting programs, we need a way to make expressions smaller as in 

    let rec fact n = if n=0 then 1 else n*f(n-1)

**Exercise:** Write the above using our definition of `let rec`. What do we need to modify? The answer lies in the encoding of `let` as syntactic sugar. But can you also eliminate the `-1`?

There is an easy way out. Surely Haskell can do `-1`, right? So why don't we use this? 

Actually, the reason why `-1` is difficult for us but easy for Haskell, is that Haskell has pattern matching. So we just add a new construct to the language

    EMinusOne. Exp2 ::= "minus_one" Exp ;   

and interpret it as

    evalCBN (EMinusOne e) = case (evalCBN e) of
        ENat0 -> ENat0
        (ENatS e) -> e

You see how elegant pattern matching here is. In fact, if we had pattern matching in our language we could implement the factorial as something like

    let rec fact = case n of
        0 -> 0
        S m -> n * f m

Nice, isn't it? But anyway, `minus_one` works as well. For example we can do `plus` now as

    let rec plus = \x.\y. if x=0 then y 
                          else S (plus (minus_one x) y) in 

    plus S 0 S S 0

**Exercise:** Explain the definition of `plus` above. Can you formulate it as a mathematical equation? The mathematical equation should prove the correctness of the program in the sense that if the program terminates it must give the correct result. Why does `plus` terminate on all inputs?


Putting things together, we can now also define more complicated functions such as fibonacci:

    let rec plus = \x.\y. 
        if x=0 then y 
        else S (plus (minus_one x) y) in 
        
    let rec fib = \n. 
        if n=0 then 0 
        else if n = S 0 then S 0 
             else plus (fib (minus_one n)) 
                        (fib (minus_one (minus_one n))) in

    fib S S S S 0 

These and similar definitions can be found in [test.lc](https://github.com/alexhkurz/programming-languages-2020/blob/master/Lab1-Lambda-Calculus/LambdaNat4/test/test.lc) and [fib.lc](https://github.com/alexhkurz/programming-languages-2020/blob/master/Lab1-Lambda-Calculus/LambdaNat4/test/fib.lc).

**Exercise:** Why is `fib` correct? Why does it terminate?

**Exercise:** Can your interpreter execute these programs? Make your own examples.

## The different programming languages

LambdaNat0: The pure lambda calculus.

LambdaNat1: Natural numbers added as data. 

LambdaNat2: Making plus one work.

LambdaNat3: Adding conditionals.

LambdaNat4: Adding recursion.
-->







1