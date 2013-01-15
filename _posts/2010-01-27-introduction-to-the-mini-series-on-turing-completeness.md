---
layout: post
title: Introduction to the mini-series on Turing Completeness
tags:
- Programming
- Turing Complete
status: publish
type: post
published: true
meta:
  _edit_last: '1'
---
I meant to write this post sometime last year, in response to some things said by some colleagues on my course but never got around to it. It turns out that they still don't seem to full understand, so I guess I'll write it now :)

I decided to split it up a bit, so without further ado, here is my mini-series on Turing Completeness.

So what does it mean for something to be Turing Complete? Something is Turing Complete if it is able to perform any computation. It can add numbers, it can find square roots, it can spellcheck a document, it can simulate airflow over a particular car.

That doesn't mean it can do it well. It might be inefficient, it might be complex, it might be confusing and difficult to follow, but it can do it. Some things will always be better at some computation than others, but if it is Turing Complete it can at least do it.

One way of asserting that something is Turing Complete is to show that it can simulate a Turing Machine. After all, a Turing Machine is Turing Complete, so if it can simulate that it can simulate the Turing Machine performing any computation.

It is enough, though, to simply have conditional branching and the ability to change memory. So pretty much any programming language is Turing Complete.

In the next few posts I'll be showing how, while languages may be Turing Complete, execution rarely is and how being a Turing Complete language doesn't mean it can do everything
