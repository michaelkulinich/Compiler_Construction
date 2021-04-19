# README.md

## Introduction

### Testing the Interpreter against all test programs

To compile run `stack build` and to run all tests do 

    stack test 
    
To test a particular `program.cc` do

    stack build
    stack exec CPPInterpreter-exe ./test/good/program.cc
    
### Testing a  particular program

Testing particular programs is important, if the interpreter does not give the right result on a particular `program.cc` (such as, for example, looping infinitely). The way forward then is to

- make  `program.cc` so small that the error does not occur anymore
- make  `program.cc` bigger so that the error comes back
- iterate the above until you found the smallest version of `program.cc` that exhibits the bug
- insert `printInt` statements as needed to track the execution of the program
- guess what could cause the problem and change `Interpreter.hs`
- iterate all of the above

The reason why debugging the interpreter is more difficult than debugging the typechecker is that the interpreter is not purely compositional in the abstract syntax. For example, even if it looks as if a wrong interpretation of `SWhile` might be responsible for an infinite loop, the problem could also lie in any number cof the other cases (eg `Sif`, `SDecl`, `SInit`, `EAss`, etc) as they all change the environment and therefore can change the values of the variables involved in testing the condition responsible for entering the `while`.

If all of this does not help, save this particular program for the end and try to get the interpreter first working on all of the other programs. If you are lucky, this will already solve the problem of `program.cc` as well.

## Assignment Interpreter  

(First deadline April 19, second deadline April 29)

The assignment is detailed [here](http://www.grammaticalframework.org/ipl-book/assignments/assignment3/assignment3.html).

Don't forget the [Haskell Tips](https://github.com/ChapmanCPSC/compiler-assignments/blob/master/Typechecker/Haskell/README.md) from the typechecker assignment. 

To decouple the interpreter from the typechecker, we implement the interpreter independently of the typechecker. (Just don't be surprised if curious things happen if you run the interpreter on "bad" programs.)

To test your interpreter on all the (good) test files, see [here](https://github.com/ChapmanCPSC/compiler-assignments/tree/master/Interpreter/test/good).

### Part 1

- Run `stack build` and then `stack test` (or just `stack test`). Among other output, you should see

      Good programs: passed 10 of 75 tests

  To see which are the good programs run `stack test | grep OK`. Look at these programs in `test/good/` to get an idea of what the interpreter can already do and study the functions `evalStm` and `evalExp` in `src/Interpreter.hs`. Try to understand the grand outlines of how these two functions interpret the 10 passing programs.

- Look at the program `easy_add.cc`. Draw the abstract syntax tree in your mind or using bnfc. Which missing case of the `evalExp` do you need to implement in order for the interpreter to work on this program?

- Extend `Interpreter.hs` so that it interpretes correctly `easy.add`. Hint: Study the case of `ETimes` that is already implemented.

- Commit and push your changes to git and notify me by email.

- Do as many of the other expressions you can.


## Part 2

Finish the interpreter. 