---
layout: post
title: Replacing mew lists with iterators
tags:
- Mew
status: publish
type: post
published: true
meta:
  _edit_last: '1'
---
Disclaimer: The following post is all speculation. None of it will necessarily get implemented

Last time I talked about how to add iterators to mew. However, writing iterators in this way can be a bit of a pain. So how can we make this easier? Generators.

Generators allow us to write a function just as we normally would, but instead of having a single return point, we yield values. Yielding a value suspends the execution of the current function and returns the value. The next time the function is called it continues from where it left off. They are, technically, a specialised form of coroutines which always yield to the caller.

    def one-to-five {
        yield 1;
        yield 2;
        yield 3;
        yield 4;
        yield 5;
    };
        
    print (one-to-five); # prints 1
    print (one-to-five); # prints 2
    print (one-to-five); # prints 3
    print (one-to-five); # prints 4
    print (one-to-five); # prints 5
    
In order to use this concept to help write iterators in mew, we need to change how the yield statement works. Instead of yielding a value, it returns the value and a continuation: the rest of the functions computation (including the environment) wrapped in a thunk. We are effectively returning an iterator cell.

Writing iterators is now a lot simpler and cleaner.

    def to-iterator @{ xs :
        if { list.empty? xs } {
            .end
        } else {
            yield (head xs);
            recurse (tail xs);
        }
    };

    def naturals {
        def x 0;

        while { .true } {
            yield (+ x 1)
        }
    };
    
We can also write some functions, such as map and filter, to help consume the iterators.

The problem is mew is meant to be small, yet we now have two different concepts of what a collection is: an eagerly evaluated list, or a lazily evaluated iterator. Can we re-write lists to be a special form of iterator?

In order to do so we need to replace lists with iterators as the built-in concept of collections. We can't use our current form of iterators, built upon lists, if we're basing lists on iterators.

Let us suppose we've now done that, and all the wrinkles have been ironed out. Because we kept the structure of our iterators close to the existing concept of cons lists, this shouldn't be too difficult.

A list can now be represented as a series of yield statements.

    [1 2 3 4 5] => { yield 1; yield 2; yield 3; yield 4; yield 5; }
    
This does have the disadvantage that lists now incur the overheads of continuations. It is possible, however, to detect and optimised a straight-forward series of yield statements and apply traditional list optimisations. Only the behaviour of the list needs to match that of iterators, not necessarily the compiler/interpreters implementation.

We've now replaced lists with the much more powerful and flexible concept of iterators. There are still many details to sort out: should there be a separation of iterables and iterators? how would current list operators work with iterators? what is the best way to implement continuations with minimal overheads? I do, however, think this is a promising and worthwhile road to go down.
