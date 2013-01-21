---
layout: post
title: Adding Symmetry to Javascript Properties
status: publish
type: post
published: true
---
A common way to implement properties in Javascript is to use a single function that takes either zero or one arguments. If there are no arguments, it's a getter, if there is one, its a setter. The getter returns the object itself, which lets you chain a bunch of setters together to avoid writing the variable name again and again.

{:lang="javascript"}
    obj.foo(10).bar('baz'); // obj
    obj.foo();              // 10
    obj.bar();              // 'baz'

jQuery implements this by checking if the argument is `undefined`, using this as a sentinal value to switch between the getter and setter behaviour. In Javascript, if not enough arguments are passed to a function, the positional arguments are bound to `undefined`.

{:lang="javascript"}
    var Obj = function() {
      var _foo, _bar;
    }

    Obj.prototype.foo = function(value) {
      if (value === undefined) { return this._foo; }
      this._foo = value;
      return this;
    }

    Obj.prototype.bar = function(value) {
      if (value === undefined) { return this._bar; }
      this._bar = value;
      return this;
    }

    var obj = new Obj();

Sometimes we might want to erase a properties value. This is quite common with the `attr` property in jQuery, toggling behaviour by adding and removing attributes.

{:lang="javascript"}
    var $bttn = $('button', container);
    if (enabled) {
      $bttn.removeAttr('disabled');
    } else {
      $bttn.attr('disabled', 'disabled');
    }

Notice that you have to use the `removeAttr` function. You might expect you could just set the property to `undefined`, but we're using that as the sentinal value to check if an argument was passed in. Trying to assign `undefined` will make the function call behave like a getter.

{:lang="javascript"}
    obj.foo(10);        // obj
    obj.foo(undefined); // 10
    obj.foo();          // 10

This can occasionally be useful because it breaks chaining; setting a property to `undefined` is frequently a bug and this will cause a Javascript error if there are any methods chained after it. Of course this is no help if it's the last method in the chain, but it has made the errors easier to track down in numerous occasions.

{:lang="javascript"}
    $bttn.text('Loading');

    var text = getTextFromServer();     // undefined
    $bttn.text(text)                    // 'Loading'
         .attr('disabled', 'disabled'); // TypeError: Cannot call method 'attr' of undefined

We can instead implement the getter-setter behaviour switch using the `arguments` object. This checks for what is actually passed into the function rather than what was bound to the positional arguments.

{:lang="javascript"}
    var Obj = function() {
      var _foo, _bar;
    }

    Obj.prototype.foo = function(value) {
      if (arguments.length == 0) { return this._foo; }
      this._foo = value;
      return this;
    }

    Obj.prototype.bar = function(value) {
      if (arguments.length == 0) { return this._bar; }
      this._bar = value;
      return this;
    }

    var obj = new Obj();

This gives us a nice symmetry between the getter and setter. Invoking the getter for a property that doesn't have a value will return `undefined`, so it seems only natural to set `undefined` to remove the value.

{:lang="javascript"}
    obj.foo();                        // undefined
    obj.foo(10);                      // obj
    obj.foo();                        // 10
    obj.foo(undefined);               // obj
    obj.foo();                        // undefined
    obj.bar(10).bar(undefined).bar(); // undefined

This makes a lot more sense to me than the jQuery approach, but maybe that's just because it appeals to my fondness for patterns and order.