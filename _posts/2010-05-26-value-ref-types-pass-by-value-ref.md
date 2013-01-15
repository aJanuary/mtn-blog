---
layout: post
title: Value Types vs. Reference Types vs. Passing by Value vs. Passing by Reference
tags:
- Programming
status: publish
type: post
published: true
meta:
  _edit_last: '1'
---
I've seen a lot of people getting confused about value/reference types, and passing by value/reference, so I thought I'd write a post to explain it.

These are two different phenomena with confusingly similar names. Value/reference types are to do with how values are copied when assigning from one variable to another. Passing by value/reference is to do with how values are copied when passing a variable as an argument to a method. You can pass a value type by value, or pass a value type by reference, and you can pass a reference type by value, or pass a reference type by reference The important thing to remember is that, whilst both references, reference types and passing by reference are two different sorts of references.

Let's begin with value and reference types. The main distinction between value and reference types is that value types have deep copy semantics, whilst references have shallow copy semantics.

This means that when you assign a value type from one variable to another, the whole value is copied. There now exists two completely separate, though identical, objects. If you change the attributes of one object, it is only changed on that object - the other object is completely separate.

<img src="http://dev.morethannothing.co.uk/valuevsreference/Valuevs.Reference1.png">

When `a` is assigned to `b`, the value of `a` is copied and assigned to `b`. When we change the `Name` property on `b`, it only changes on `b` because `a` refers to a completely different object.

Reference types, rather than containing a value, contain a reference to the value. The shallow copy semantics mean that, when a reference value is assigned from one variable to another, only the reference is copied. There still exists only one object, but now both variables point to the same object. If you change the attributes of the object through one variable, these changes can be seen by accessing the attribute through the other variable.

<img src="http://dev.morethannothing.co.uk/valuevsreference/Valuevs.Reference2.png">

If, rather than changing an attribute of one of the variables containing a reference type, we change which object the variable refers to, this change is only reflected in that variable. It does not change the value the other variable refers to.

<img src="http://dev.morethannothing.co.uk/valuevsreference/Valuevs.Reference3.png">

Assignment changes the value of the variable - in the case of a reference type this value is a reference to an object. Assigning a new reference changes only the value of the variable, that is it changes which object it refers to. The object it used to refer to, and any other variables that also refer to that object, remain unchanged.

Moving onto passing by value/reference. Passing by value creates a copy of the variable before passing it into the function - this would be the object in the case of a value type, and the reference to an object in the case of a reference type. Passing by reference holds onto a reference to the original variable being passed into the method - anything done with the argument is redirected to the variable passed in, whether it be changing an attribute of the object, changing the value or changing the reference.

For the purpose of the examples, let us suppose we have a method `Foo` which takes one argument, `person`. The body of `Foo` either changes the `Name` property on `person`, or changes the value of `person`. The third line of code in the example pictures donates which of these happens.

Firstly, we can pass value types by value. The value of the variable is copied (using the deep copy semantics described above) before being passed to the method. Changing attributes on the argument or changing the value of the argument has no effect on the variable being passed in as they are completely separate objects.

<img src="http://dev.morethannothing.co.uk/valuevsreference/Valuevs.Reference4.png">

We can also pass reference types by value. The value of the variable - that is the reference - is copied (using the shallow copy semantics described above) before being passed to the method. Changing attributes on the argument are reflected in the variable being passed in, as both the variable and the argument refer to the same object.

<img src="http://dev.morethannothing.co.uk/valuevsreference/Valuevs.Reference5.png">

Because `a` and `person` refer to the same object, changing the `Name` property through `person` can be seen by inspecting the `Name` property through `a`.

Changing which object the argument refers to, however, has no change on which object the variable refers to.

<img src="http://dev.morethannothing.co.uk/valuevsreference/Valuevs.Reference6.png">

Changing the value of `person` - that is changing which object it refers to - does not change the value of `a`.

Now let's suppose the arguments for `Foo` are passed by reference. When passing either value or reference types by reference, any operations (assignment, changing attributes etc.) on the argument are redirected to happen on the variable.

<img src="http://dev.morethannothing.co.uk/valuevsreference/Valuevs.Reference7.png">

<img src="http://dev.morethannothing.co.uk/valuevsreference/Valuevs.Reference8.png">

Changing the value of an argument passed by reference changes the value of the variable being passed in, whether the variable is a value or a reference type.

Usually languages default to pass by value. Some, such as C#, offering pass by reference as an explicit option.

Hopefully, despite value and value types being different, and the reference in reference types and pass by reference being of different sorts, this has made things a little clearer. If not, please ask questions in the comments and I shall endeavour to clarify, either in comments or by changing the post.
