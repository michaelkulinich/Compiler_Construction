# Haskell projects

I list some Haskell projects that should not be too difficult in themselves, but interesting enough for some programming practice.

## Calculator

Extend [the calculator](https://hackmd.io/@alexhkurz/HJVtVl068) from the lecture with further features:

- Booleans
- if-then-else
- floating points
- fractions
- ...

It would also be interesting to hook the calculator up with a web interface, but I have not done this myself, so I cannot give you specific technical advice on this.

## Roman Numerals

The idea is to implement a simple [string rewriting system](https://hackmd.io/@alexhkurz/BJ23jmpIw#Exercises-String-rewriting-essential-examinable), as discussed in the lectures, in Haskell. My solution has 17 lines of code (rewrite rules, applying a list of rules to a string, normalising) plus some more to convert between roman numerals and integers for testing purposes.

Here is the main idea of how we can add roman numerals using a rewrite system.

Say I want to add `II` and `LI`. Instead of "+" I just concatenate the two strings and then rewrite them to normal form as follows
    
    IILI ->
    ILII ->
    LIII

One thing to think about is how to deal with numerals such as `IV`. But apart from this everything should be  straightforward. So maybe you first want to forbid numerals such as `IV` and then to think about how to extend your solution.

In terms of Haskell, I used `replace` from `Data.Text` to implement one computation step. To avoid 

    Couldn't match type ‘[Char]’ with ‘Data.Text’

error messages, enter `*Main> :set -XOverloadedStrings` in the Haskell console before running your code. Here is an example of how it works on my side.

    >ghci roman_numerals.hs
    *Main> :set -XOverloadedStrings
    *Main> normalise ("II" +++ "LI")
    "LIII"

where `x +++ y` is defined as `Data.Text.concat [x, y]`.

So far so good. Addition is easy. Just concatenation of strings, then rewriting to normal form. What about subtraction and multipliation? 

## Abacus

Addition of roman numerals is easy to program as a string rewriting system. But this is not the way you want to compute. How did Roman merchants do their computations?

As far as I know, they did use a place-value system base 10. They just did not have a symbol to write zero as text. But they could "write" zero on a counting board or an [abacus](https://www.ee.ryerson.ca/~elf/abacus/history.html). 

There are many different versions of abaci. The simplest to understand are those with 10 beads. If you watch a [video](https://www.youtube.com/watch?v=SYRyKYmOJwM) on how to do addition with an abacus, you really see that it is a rewrite system. 

Implement addition of abacus-numbers in Haskell.

(I didn't do this myself, so I don't know how much work there is involved exactly.)

A more sophisticated version of the abacus is the [soroban](https://en.wikipedia.org/wiki/Soroban). It is an interesting mix of a [place-value system](https://en.wikipedia.org/wiki/Positional_notation) with Roman numerals as one has a "digit" for the value $5$. 




