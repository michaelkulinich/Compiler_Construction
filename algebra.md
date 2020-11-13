# An Excursion on Algebra

We talked about how it is important in research to simplify a problem in the right way; we learned some basic ideas: computation as rewriting to normal form; now let us make things more complicated again and see how far we can go ... there are many ways to do this: negative numbers, binary numbers (or decimals), exponentiation, square roots, calculus, if-then-else, loops and recursion, etc  ... but we will look at something else first, namely how to go from numbers to algebra, or from primary school to secondary school.

How far did we go in our quick tour of school mathematics? Roughly primary school, computing with numbers. 

Algebra induces a radical new big idea: instead of thinking of variables as place holders for terms/numbers: variables as "first class citizens".

## Variables as first-class citizens

If we write 

    x+y = y+x

the variables are merely **place-holders**. We want to express the commutativity of `+` for all numbers. The equation then is just a convenient way of stating infinitely many equations of the form

    1+2 = 2+1

at the same time. `x,y` are mere place-holders that can be replaced by any numbers to yield a valid equation.

But now let us play the following game. I think of a number. Then I add 4, multiply by 3, subtract the number and take the square root and get 4. What is the number?

The solution is easy to find using algebra. We first translate the question into a formula

    ((x+4)*3-x)^{1/2} = 4

and then solve for `x`. To do this we need to have rules of computation that contain variables as "first-class citizens", not only numbers. We need now equations such as

    x+y = y+x

as equations between terms that do actually contain variables. That is the precise point where one has to leave primary school maths and start with high-school algebra.

## A brief look at the history

Historically, this did not come easy. The first time the method of algebra appears fully developed in most of its basic ideas is a turning point in history. Please have a look at [Descartes' Geometry](http://www.gutenberg.org/ebooks/26400), first published in 1637. (It is always worth looking at Wikipedia so read up on [Descartes](https://en.wikipedia.org/wiki/René_Descartes) who led a very interesting live that is full of amusing anecdotes and his books, the [Discourse on the Method](https://en.wikipedia.org/wiki/Discourse_on_the_Method) and its appendix, the [Geometry](https://en.wikipedia.org/wiki/La_Géométrie), are, in (not only) my opinion the most important publications in philosophy and mathematics of all time. 

It is well worth to spend a few minutes and quote the four steps of [Desacrtes' scientific method](https://en.wikipedia.org/wiki/Discourse_on_the_Method#Part_II:_Principal_rules_of_the_Method).

A great resource on  philosophy and logic and some areas of mathematics is the Stanford Encyclopedia of Philosophy which also has an article on [Descartes mathematics](https://plato.stanford.edu/entries/descartes-mathematics/).) Even if you don't read French, just by browsing through the pages, you see that Descartes, who just escaped the middle ages, did write in a style that is still readable today and that looks like modern mathematics. You can also look at a facsimile of the original. Even without trying to understand the maths in detail, I found for example [page 301 of the original](https://fr.wikisource.org/wiki/Page:Descartes_La_Géométrie.djvu/11) worth looking at. We see that he didnt use "=" (which, in fact, was introduced already earlier by [Robert Recorde](https://en.wikipedia.org/wiki/Robert_Recorde) in 1557 but not widely used yet), but that otherwise all the basic ideas of algebra are already there. 

		Little research project: Why did Descartes use a symbol for "=" that is not symmetric? 
		Could there be a connection to the idea of rewriting that we mentioned above?
		
Putting Descartes in historical context can help to appreciate his importance. He was a generation younger then Galileo and a generation older than Newton. Looking at Galileo's [theorems of motion](http://galileoandeinstein.physics.virginia.edu/tns_draft/tns_153to160.html) as formulated by himself in the celebrated [Discourses and Mathematical Demonstrations Relating to Two New Sciences](https://en.wikipedia.org/wiki/Two_New_Sciences), we see that he needs 6 theorems with complicated proofs in order to express the simple equation d=v*t because he does not have the algebra of Descartes. (Thanks to Andrea DiSessa, Changing Minds (2002) for pointing this out.) But just a generation later, Leibniz and Newton were able to extend Descartes' algebra of variables and numbers to an algebra of functions, including operations of differentiation and integration.
	
Ok, after this historic excursion, let us go back to calculating with terms containing variables.

		do we need new equations?
			what, for example, about (x+y)+x = 2x+y ? Get out pen and paper.
		needs commutativity
		write out all equations we have so far (could do this together at the whiteboard)
		innocent but important question: how do we know that we have all equations?

The answer to the last question, leads to the next topic, the title of which contains the four big ideas of syntax, semantics, soundness and completeness.

But first, we could use this opportunity to get used to consult research literature. The problem we have been discussing has an interesting history and drew the attention of some real heavyweights. Read up to (and excluding) Section 1.1 of the [article by Burris and Yeats](https://www.math.uwaterloo.ca/~snburris/htdocs/MYWORKS/PREPRINTS/saga.ps). 

Also read the Wikipedia article on [Tarski's High School Algebra Problem](https://en.wikipedia.org/wiki/Tarski%27s_high_school_algebra_problem).

