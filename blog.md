# Blog/Tutorial on Haskell      

Learning a new programming language is always a challenge, in particular if it is the first functional programming language you are going to learn.

You only know that you understand something if you can explain it to somebody else.

The minimal way to set up a blog is as follows:

- Create a public github repository.
- Add a `README.md`.
- Make `.md` files for each blog entry. Link them from the README.

To learn markdown, google "markdown cheat sheet" ... it is easy. And it is what I use for this course. Btw, you can use all of html in markdown. It makes the writing more cumbersome, but also gives you additional options. 

Of course, if you want more sophisticated ways of controlling the layout, feel free to explore other possibilities. Github pages is one possibility.

There are currently no fixed deadlines. The expectation is that you write the blog like a diary, as you go on in the course. Write it with beginning Haskeller's in mind. 

**Drop me an email when you made a new entry.**

Here are some things I would like to learn from you:
- How do newcomers learn functional programming?
- Which external sources (videos, blogs, tutorials, etc) do you find most useful?
- How does Haskell compare to your favourite programming language? Give examples of the same algorithm written in your favourite language and in Haskell. What are the respectives strengths and weaknesses of the two programming paradigms?
- What are, in your opinion, the major stumbling blocks in learning Haskell?
- Are there any projects you implemented in Haskell that go beyond what we do in class?

**General Rule:** Do not repeat material that is already in my notes.  Explore on your own. If you write about material we have covered in the lectures, make your own examples and add your own angle. Do not post answers to homework and assignments.

**Some Remarks**

Personally, I am more interested in content than in form. So if you take my github repo for this course as a guideline this is fine. But I don't want to discourage more sophisticated design of a webpage. If you like to design a fancy webpage, that will gain you points as well.

Your blog should 
- approximately/on average has one entry/page per week (10 in total should suffice);
- be organised by time or topic;
- start at the beginning (for example, on what hardware/operating system are you working, how did you install Haskell, ... but what is the right beginning for you depends on what you have to say overall);
- make sense to readers who do not take this course ... don't talk from student to professor but rather from professional to professional;
- make you own examples, observations;
- interleave narrative with code (all code must be tested and run, make sure the reader knows how to run your code);
- finish each blog with list of references and recommendations for further reading;
- ...

***I don't want to limit your creativity, so let me know if you have your own ideas.***

**Marking Guidelines:**

- **D:** Demonstrates basic familiarity with Haskell.  
- **C:** Demonstrates adequate familiarity with Haskell. Develops own examples along the lines of the homework.
- **B:** Demonstrates good understanding of Haskell. Makes interesting observations that do not merely repeat points made in the lectures.  Develops material that goes beyond what has been treated in class. Can be recommended to a beginning Haskeller as a first introduction. Makes connections between the practical and theoretical parts of the course. 
- **A:** Demonstrates a very good understanding of Haskell. Makes interesting observations and contains material that goes significantly beyond what has been treated in class. Will be of great interest to a beginning Haskeller. Makes interesting connections between the practical and theoretical parts of the course. Typically would discuss some of the advanced features of Haskell such as type classes or monads and/or develop their own project.

Again, if you have your own ideas, let me know. I am happy to adapt these guidelines if they do not fit what you have in mind.

**Ideas for the blog:**
- General remark: In did have quite a number of interesting discussions with students, on the discussion forum or via email, about curious observations concerning Haskell, bnfc and the like ... typically these observations would also make interesting points for the blog.
- Write a Haskell tutorial. Make your own examples that you think would help a beginning Haskeller to understand Haskell better.
- Benchmark the same algorithms in Python and Haskell. You can use [gnomon](https://github.com/paypal/gnomon) to measure the time that programs take to run.
- Explain how to use docker to setup Haskell and bnfc. Make a dockerfile that we could use to run Haskell, bnfc and the assignments.
- I collected some ideas for [Haskell projects](haskell-projects.md) you might want to try.
- Haskell and $\lambda$-calculus: Write the same program in both languages and compare.
- Study Church numerals. Make examples. Implement Church numberals and run them in Haskell.
- Haskell is lazy, which is interesting for programming with infinite data structures such as streams.
- Do some of the [exercises](https://hackmd.io/@alexhkurz/BJ23jmpIw) labelled "Optional (but interesting)". (Essential exercises are not suitable for the blog.)
- Multi-paradigm languages:
  - Haskell is close to what one calls "pure functional programming" but there are also multi-paradigm languages such as OCaml and, more recently, Scala and Julia. You can pick Julia or Scala and write one or more blogs about how they integrate FP and OO. What are the benefits (apart from just having both FP and OO)?
  - In case you have an interest in logic programming (eg PROLOG), there is some interesting literature on building multi-paradigm languages that combine functional and logic programming. 

- ... let me know if you have your own ideas ... the blog is a space where you can be creative ...
- ...