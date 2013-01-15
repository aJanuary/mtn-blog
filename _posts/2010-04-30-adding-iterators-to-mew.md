---
layout: post
title: Adding iterators to mew
tags:
- Mew
status: publish
type: post
published: true
meta:
  _edit_last: '1'
---
Disclaimer: The following post is all speculation. None of it will necessarily get implemented

If you look at lots of the big, modern programming languages (C#, VB.Net, Python, Java, Ruby, Scala, Objective-C and many, many more) one feature they all have in common is some sort of iterator - the ability to iterate over items in a collection without needing to manually index into the collection.

    for item in collection:
      print(item)
        
This has many advantages over traditional for loops, and not just a cleaner syntax. Iterators are implementation independent; it doesn't matter if the elements are stored as a linked list, or as leaf nodes in a tree, you can iterate over them in exactly the same way. This can be seen quite effectively in .NET's LINQ and Python's list comprehensions, which allow you to perform complex and powerful queries over any form of collection, no matter how it's implemented.

The items don't even need to be known when the object is created: the interface to iterators usually supports lazy collections.

    object Current;
    void MoveNext();
    
This means you could have an iterator which fetches items from a database. If you never use the 100th item, it never fetches it. You can also represent infinite sequences without the process locking up when you create them. Consider an iterator which represents an infinite series of positive integers, you could then number every item in another collection by simply zipping them together.

    indexed = zip(positive_integers, collection)
    
Iterators are a very powerful concept, and I thought it would be a shame for mew to miss out. Here are my current ideas about how it might be implemented.

Mew uses the concept of cons lists for its current collections: a list is a series of cells, each containing a value and a tail (itself a list).

<img src="http://www.morethannothing.co.uk/wp-content/uploads/2010/04/conslist.png" alt="" title="A Cons List" width="149" height="26" class="alignnone size-full wp-image-206" />
    
We can use a similar concept to implement our iterator. Each cell would contain a value, and a tail. However, we need the iterator to be lazy, so each cell is wrapped in a thunk which, when evaluated, will generate the actual cell. This way the value of a cell isn't generated until the thunk is evaluated.

<img src="http://www.morethannothing.co.uk/wp-content/uploads/2010/04/iterator.png" alt="" title="An Iterator" width="166" height="36" class="alignnone size-full wp-image-207" />
    
This very simple model allows us to create, process and consume iterators. We can, in fact, achieve all of this in mew today.

    def to-list @{ iterator :
        def unthunked (iterator);
            
        if { = unthunked .end } {
            []
        } else {
            def value (index 0 unthunked);
            def next-iterator (index 1 unthunked);
            [value ~ (recurse next-iterator)]
        }
    };

    def to-iterator @{ xs :
        {
            if { list.empty? xs } {
                .end
            } else {
                [(head xs) (recurse (tail xs))]
            }
        }
    };
        
    def naturals {
        @{ x :
            [(+ x 1) {recurse (+ x 1)}]
        } 0
    };
        
    def empty { .end };
 
This allows us to use lazy, possibly infinite, lists in our code. Where the data comes from is up to the implementer of the iterator, but we have a unified interface for how to consume that data.
    
Next time: Adding generators and replacing lists with iterators.
