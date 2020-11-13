# Assignment 1

(instructions adapted for 2021)

The assignment comes in 2 parts. Both parts are exercises in Haskell. This is important since we will use Haskell throughout this course and also next semester in Compiler Construction. (As a footnote, I want to add that Haskell is only a (very good) tool for us, one could use any other programming language for the same purpose in principle, even if it was infeasible in practice. In fact, if you want to compare Haskell to another programming language you already know, this would be a great idea for your blog to implement this assignment also in, say, one of Java, Python, C++, etc and then to compare the two implementations.)

**Proper use of git will be taken into account for grading.**

- make a private repo for this Assignment and invite all group members and myself as a collaborators
- add a `README.md` containing names and emails of all students in the group
- make a subfolder `Calculator`
- do not commit machine generated files (only keep `numbers.cf`, `Calculator.hs`, `Interpreter.hs` in `Calculator`)
- do not change my file names
- build up your version of `fractions.hs` step by step as the template will not compile. Do not change my names of the functions (they are part of the specification). Document at least on test case per function you implement.
- commit each time, with **meaningful messages**, after you implemented and **tested** 
  - a function in `fractions.hs`,
  - a case of `eval` in `numbers3.hs`, 
  - a rule of `numbers.cf`; 
- if you want/need to keep copies of different versions of the same file use branches
- the master branch should only contain the files relevant for grading: all the files that contain code you wrote plus the auxiliary files such as `Calculator.hs` that I need to compile your work;
- expect no points for code that does not compile or does not run;

**Submission is by sending me an email with a link to the repository.**


## Part 1: Recursion (5 points)

In the first part you can show your skills in programming recursively over algebraic data types. 

Download the [template `fraction.hs`](src/templates/fractions.hs).

The overall idea is to explore how to extend our implementation of natural numbers to fractions. To keep the coding shorter, we only consider non-negative fractions (but we could use the same ideas to also deal with negative numbers). 

The main idea is that a fraction is a pair `(numerator,denominator)` of two numbers, the second of which must be positive (to exclude division by zero). So we first define the natural numbers as before

    data NN = O | S NN

then the positive numbers (positive numbers start at 1, not 0)

    data PN = I | T PN

then the fractions as tuples, or pairs, `(numerator, denominator)` of type `(NN,PN)`

    type Frac = (NN,PN)

To program with fractions you need to know that if `pair` is a pair in Haskell, then you can access the components with `fst pair` and `snd pair`. You can test this in the Haskell console as follows.

    Main> pair = (2,3)
    Main> fst pair
    2
    Main> snd pair
    3

The programming techniques follow closely the lectures and the homework. Start from the the [template `fractions.hs`](src/templates/fractions.hs). Here are some remarks:

1. First you develop a library of functions to compute with `NN`s and `PN`s. In this part you will mostly use recursion.
2. Then you implement arithmetic of fractions. For this you need to remember the rules of high-school algebra and implement them using the library functions of item 1. You will not have to directly use `O,S,I,T` in this part.
3. Writing and reading larger successor numbers is tedious. Therefore it is convenient to have functions that convert numbers of type `NN`, `PN`, `Frac` to Haskell numbers and back. Use these functions only for testing, not to implement the arithmetic on `NN`, `PN`, `Frac`.

In the following I collect some hints that grew out of discussions within the class.

- *Hint:* Spend some time on thinking about the logic behind each function. Once you have the idea, the solution will be short. Most of the functions are two-liners.

- *Hint:* Mathematically, each line below represents the same number.

    | `NN` | `PN` | `Int`
    |:---:|:---:|:---:|
    | O | | 0
    | S O | I | 1
    | S (S O) | T I | 2
    | S (S (S O)) | T(T I) | 3
    | ... | ... | ...

    But in Haskell **these data types are disjoint**. For example, if you input an `I` or a `1` to a function that expects data of type `NN`, you will get an error message.

- *Hint:* Separate clearly in your mind syntax from semantics (=meaning=interpretation): Syntactically, `O` and `I` are just symbols. The meaning of these symbols only arises from the operations on these data. For example, if we write a function

        add O n = n

    this is consistent with our interpretation of `O` as $0$, because we know that $0+n=n$. On the other hand, if we simply transferred this idea from `NN` to `PN` writing

        addP I p = p 

    then this would *not* be consistent with `I` meaning $1$, because $1+p=p$ is not a valid  equation of arithmetic.

- *Hint:* The data type `PN` was introduced to make sure that a fraction never has a denominator of $0$. But there are other places where we need to allow run-time errors. You can just leave these errors to the runtime system, in which case your code does not need to account for these error at all. Generally preferable, though, is to proceed as in item 1 of [8 ways to report errors in Haskell](http://www.randomhacks.net/2007/03/10/haskell-8-ways-to-report-errors/).

## Part 2: A Calculator (4 points)

In the first part, we have seen how to define fractions from scratch, and how to implement the mathematical definitions using recursion on algebraic data types. The host language (Haskell) was only used to execute the equational reasoning based on the recursive mathematical equations.

In the second part, we will now allow ourselves to use the built-in arithmetic of the host language. One of the reasons is that this built-in arithmetic uses binary numbers instead of successor numbers and, therefore, is much more efficient (but also much more difficult to implement). Another reason is that using the rich arithmetic of the host language makes it much easier to add features to the calculator.

### An interpreter for abstract syntax (2 points)

Download the [template `numbers3.hs`](src/Haskell/numbers3.hs). It contains the definition of a language for arithmetic expressions and an interpreter evaluating these expressions into the Haskell integers:

    data Exp = Num Integer | Plus Exp Exp | Times Exp Exp 

    eval :: Exp -> Integer
    eval (Num n) = n
    eval (Plus n m) = (eval n) + (eval m)
    eval (Times n m) = (eval n) * (eval m)



**Finding operations in Haskell:**
 
- In ghci you can run `:i Integer` to find information about the data type `Integer`. This leads you to [GHC.Integer](https://hackage.haskell.org/package/integer-gmp-1.0.3.0/docs/GHC-Integer.html) and shows that `Integer` is an instance of various [type classes](http://learnyouahaskell.com/types-and-typeclasses) such as `Num`, `Real`, and `Integral`. To sumarize, run in ghci

        :i Num
        :i Integral
        :i Real

    [*Warning:* That the label `Num` in `Exp` is the same string as the name of the type class `Num` is purely coincidental.]

- This gives `(+)` and `(-)` and `(*)` and some more but not exponentiation. I said that "Haskell has no secrets" when we implemented our own arithmetic on numbers. But if you start to using libraries that is not true anymore. So what can we do? 
    - One is to guess notation and run in ghci a command such as 

            :t (^)

        Then, if you want to see how functions such as `(^)` are implemented you can look them up in [Hoogle](https://hoogle.haskell.org/?hoogle=%5E&scope=set%3Astackage) and follow the links that will lead you to the source code. 
    - Another is to study more closely the documentation of [GHC.Real](https://www.haskell.org/haddock/libraries/GHC.Real.html) and [GHC.Num](https://hackage.haskell.org/package/base-4.14.0.0/docs/GHC-Num.html) and [Integral](https://hackage.haskell.org/package/base-4.14.0.0/docs/Prelude.html#t:Integral).

**Task 1**: Extend the definition of `Exp` and `eval` by 6 other operations on the integers including a binary `-`, a unary `-`, and `/` and `^` for integer division and exponentiation. Use the native Haskell operations on `Integer`.

**Remark**: It is interesting to think about adding Booleans, comparison operators and if-then-else.

### An interpreter for concrete syntax (2 points)

Check out [the lecture notes](https://hackmd.io/@alexhkurz/HJVtVl068#Generating-a-Parser-from-a-Context-Free-Grammar) for the relevant workflow.

Have a look at the [directory `Calculator3`](src/Calculator3). The file `Interpreter.hs` contains the function `eval`. The data type `Exp` will be generated automatically by `bnfc`  (see the lecture) from the grammar in `numbers.cf`:

    Plus. Exp ::= Exp "+" Exp1 ;
    Times. Exp1 ::= Exp1 "*" Exp2 ;
    Num. Exp2 ::= Integer ;

    coercions Exp 2 ;

Compiling `numbers.cf` with `bnfc` generates a number of files, in particular `AbsNumbers.hs`, which contains the definition of `Exp` (check for yourself).

**Task 2**: 
- Extend the grammar with syntax for the 5 operations from the previous task. 
- Compile the grammar with `bnfc`.
- Extend the interpreter as you have done in the previous task.
- Run and test the calculator.




