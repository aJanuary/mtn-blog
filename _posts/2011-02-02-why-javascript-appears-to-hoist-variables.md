---
layout: post
title: Why Javascript appears to hoist variables
tags:
- programming
status: publish
type: post
published: true
meta:
  _edit_last: '1'
  _wp_old_slug: ''
---
JavaScript can appear to do odd things if you're not familiar with it's scoping rules. Take the following as an example.

{:lang="javascript"}
    var i = 0

    function foo() {
        console.log(i)
        var i = 1
        console.log(i)
    }

If you've not come across this specific example before, you might be surprised by the result:

{:lang="javascript"}
    undefined
    1

Searching on the Internet, you can find plenty of explanations of this *variable hoisting* behaviour. Most liken it to the following example:

{:lang="javascript"}
    var i = 0

    function foo() {
        var i
        console.log(i)
        i = 1
        console.log(i)
    }

This helps describe what is happening, but it doesn't explain *why* JavaScript does this.

To do that, we will need to dive into how scoping works.

Javascript, like most modern languages, is statically scoped. In contrast to dynamic scoping, this makes it a lot easier to reason about and optimise code. Before the code is run, scope analysis is performed. The code is split into different "scope blocks". In JavaScript, each function creates a scope bock. In other languages, such as C or Java, scope blocks are also created by things like loops and branches.

Each variable declaration adds that variable name to it's immediate scope block. In JavaScript, if multiple variable declarations with the same name occur in the same scope, they refer to the same variable within the same scope. In languages that don't allow variable redeclaration, this would generate an error.

Whenever a variable is referenced, it is looked up in the current scope. If it is not found there, it recurses to the parent scope.

If we look at the first example again with our new found knowledge of how scoping works, we can see exactly why the first reference to "i" in "foo" is undefined.

![Static scope]({{ site.mediaurl}}/images/static_scope.png)

Within a given scope, all variable references using the same variable name refer to the same variable.

But why is this such a problem? If you are given a program and told it is semantically correct (it compiles/is able to be executed), can you follow the code linearly as it would run and tell what it will do at any given point?

If you had the following fragment of a semantically correct c# program, you would be able to say that at line 4, it will print 10.

{:lang="javascript"}
    int i = 10;

    void Foo() {
        Console.WriteLine(i);
        ...
    }

But given this same semantically correct JavaScript fragment, you cannot say at line 4 what it will print without first reading the rest of the scope to see if it is referring to the local scope, or some parent scope.

{:lang="javascript"}
    var i = 10

    function foo() {
        console.log(i)
        ...
    }

Its fairly trivial in these small examples, but in larger programs it can cause hours of debugging if you're not looking out for it.

Static scoping makes our code easier to reason about, but it can also lead to odd situations like these. Other languages avoid this problem by disallowing references before assignments.

Next time we will look into how javascript's function scoping exacerbates this problem, and why it uses function scoping in the first place.
