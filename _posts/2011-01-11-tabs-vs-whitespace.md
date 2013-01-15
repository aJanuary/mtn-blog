---
layout: post
title: Tabs vs. whitespace
tags:
- Programming
status: publish
type: post
published: true
meta:
  _edit_last: '1'
  _wp_old_slug: ''
---
I was so very tempted to post a response to this [question on tabs vs. spaces](http://stackoverflow.com/questions/4662790/tabs-or-spaces/) on SO today. (I did actually write one, but deleted it and voted to close for being too subjective) I thought it would be better to post my response here instead.

The question is which is better for formatting code indentation, tabs or spaces? My answer? Both.

The advantage of tabs is that it avoids another of the religious programming wars, how big should your tabs be? 4 characters? 8? 2? My personal preference is 4, but why should I get to decide if someone else reads the code better with 8?

The big disadvantage of tabs, which is the problem that spaces solve, is alignment with non whitespace. Take, for example, the following bit of code:

	public void Foo() {
        DoSomething(a, b, c
        	        e, f, g);
	}

In my editor, where the tab width is 4, everything lines up nicely. But what about my team mate who uses, *spits on the ground* 8?

	public void Foo() {
    	DoSomething(a, b, c
                                    e, f, g);
	}

The prettiness is starting to unwind. This is the big reason why many people advocate using spaces. It avoids this exact problem when people assume a certain tab width.

But there is a way of getting the best of both worlds. If indentation is done using tabs, but lining whitespace is done using spaces then people get to choose how much things are indented, but things still line up just fine.

    public void Foo() {
        DoSomething(a, b, c
                    e, f, g);
    }

The big problem with mixing whitespace like this is that it is often very difficult to maintain. Most people forget at least a few times. The easiest way to remember is to turn on the auto indent feature of your editor, then only ever use spaces when you need to indent more (assuming your editor doesn't try to be too clever).
