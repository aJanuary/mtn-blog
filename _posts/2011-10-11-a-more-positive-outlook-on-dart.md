---
layout: post
title: A more positive outlook on Dart
tags: []
status: draft
type: post
published: false
meta:
  _edit_last: '1'
---
Google recently announced [Dart](http://www.dartlang.org/) a new language designed to be a new language for both browser and server, with an eye on rapidly developed prototypes being easily transformed into large maintainable codebases.

A lot of people seem quite dissapointed, ranging from slightly deflated to declaring it a pointless waste. But, to me at least, a lot of the critisism seems to be directed in some odd, though unfortunately predictable, areas.

##Yet another language?
It is true that there has been a proliferation of languages in similar sorts of spaces to Dart: for the "unified language on web and server" arena there's [nodeJs](http://nodejs.org) and even Google's own [GWT](http://code.google.com/webtoolkit/); [Coffeescript](http://jashkenas.github.com/coffee-script/) and [Clojure](http://clojure.org/) are both attempts at making a saner, cleaner language that can compile down to browser and server-side javascript; in terms of some of the smaller goals, [Erlang](http://www.erlang.org/) and [nodeJs](http://nodejs.org/) propose models for dealing with asynchronous and parallel code execution; some would even argue that [Go](http://golang.org/) is a contender in the 'trendy new language' and 'owned by Google' space.

So why another language? Because none of these quite fit the niche that Dart fills. nodeJs has all the idiosyncrasies of javascript, GWT is a systems language, with a syntax and features with that particular focus and bent, Coffeescript is only a thing vaneer (though a nice one) over javascript and retains many of it's quirks, Erlang is not a browser language. Clojure, imo, provides the closest fit, but I unfortunately don't know a great deal about it to comment further.

This time was always going to come - we were always going to reach a point where we both had the desire to replace javascript and the ability to do it. Not because of anything especially to do with javascript - it's full of quirks but lots can and are being fixed - but because people always want choice. Choice isn't always a good thing, but I think it's almost universally enevitable. People will always want tools to work the way they want them to, and creating new tools - and thus new choices - is the only way to get there.

There have always been lots of choices in any particular domain, and there have always been multiple seminal languages arriving at around the same time. What perhaps makes this different is the long term dominance of javascript, the fact that so many of these languages have such a similar problem domain and the echo chamber or alpha web-developers giving fast adoption and publicity to these new languages.

I can understand the hesitancy people have about new languages in this space, but if we want to see progress I don't really see any alternative.

##Java = Java + 1?
A lot of people are comparing it to Java, and it does have some striking similarities. It's got curley braces and semi colons, types first, classes and interfaces, angle bracket generics, static members and factories and probably a dozen other things I can't think of right now. Which is no real big surprise, given Gilad's involvement and the, some argue misguided, attempt at being familiar to existing java developers.

A vast number of the similarities are syntactic similarities, such as curley braces and semi-colons, but even skin-deep comparisons with Java brings with it some heavy baggage. "Java syntax is verbose" is a common critisism levied at it. Curley braces make a langues verbose? No, needing to do things like "abc".equals(other) because there is no operator overloading makes it verbose. And Dart *does* have operator overloading. Needing to type out Map<Integer, Map<Integer, List<String>>> theTable = new HashMap<Integer, Map<Integer, List<String>>>() because the language doesn't have dynamic typing or type inference makes it verbose. And Dart *does* allow dynamic typing, and can easily be adapted to support type inference.

I will grant you semi-colons are largely an unneeded hangover, and I wouldn't be at all surprised if they get removed pretty soon, but I think braces are useful, functional and pretty. They're a unified model for specifying a region of code that allows it to be embedded cleanly and readibly in the middle of code, which makes them perfect for lambda expressions.

Before you go exhaulting the beauty of Python in all its bracelessness, just take a minute and look at it. I mean, really look at some Python code. Sure, it's wonderfully functional and minimalistic, but it's also *ugly*. The colons create warts petruding from the end of half the lines, the mangled names destroys scanability (and not in a good way) and the significant whitespace leads to a tree of branches balancing precariously from the global definitions looking as though they're about to snap off.

**ahem** anyway, my point is you don't just get to assert that Python is pretty and curly-brace languages are ugly or verbose. There is a balance to be made, and taste is the biggest player.

##The typesystem is weaksauce?

A lot of people seem to be confused by the type system in Dart. I personally think it's one of its strongest features, because it's what allows the rapidly developed prototypes to be developed into large maintainable codebases. Plus from a language geek perspective the nudge towards pluggable type systems is kinda cool.

At its core, the language is dynamically typed. That means you can do things like assigning values of different types to the same variable.

{:lang="java"}
	var a = 10;
	a = "foo";

It *isn't* untyped, which means the type of the value still defines what operations can be performed on it. For example, you can't add together two instances of MyClass without defining the add operator on them. At compile time you'll get a 'MyClass has no method named "operator+"' warning, and at runtime you'll get an 'NoSuchMethodException - receiver: '' function name: 'ADD$operator' arguments: []]' error.

{:lang="java"}
	class MyClass { }
	main() {
		new MyClass() + new MyClass();
	}

You have all the same runtime assurances you do in other dynamic languages like Python, but with the ability to optionally specify type annotations.

{:lang="java"}
	int a = 10;
	a = "foo";

The type annotations allow a type checker to be run on the code, which can statically assign types to variables, using the type annotations as guideance. It can then statically verify that only values of that type are assigned to those variables. This is exactly what the type checker does in any other statically typed language does. Where Dart differs, and what some people are objecting to, is that these type errors manifest as warnings, rather than errors that break the build. This does seem a little strange to me as well, and I wonder what the reasoning is. If it's a straight up design decision with little other consequences I can forsee a lot of discussion going forward, possibly leading to that changing, possibly not.

Designing an optional type system has some interesting implacations, the biggest being that the evaluation semantics of the language *cannot* depend on the type system. This seems to have confused some people, leading them to suggest that the type system isn't on-par with other statically typed languages because the type system doesn't appear to be so integral to the language. This isn't the case.

All it means is that if you took the type annotations away, or added them where they previously were not, your program shouldn't then do something different. This procludes certain language features, or anti-features as some may designate them. For example, you cannot have method overloading, because as soon as you remove the types, or if you add a type to an existing argument, the program would behave differently.

{:lang="java"}
	void foo(int a) {
	    print(a * 2);
	}

	void foo(String a) {
		print(a);
	}

	foo(1);
	foo("1");

Ensuring the core of your language is not dependant on types is a good way to create cleaner concepts, even if it does proclude some features.

##No type inference?

One of the advantages of the type system not being tangled with evaluation dynamics is that features of the type system can largely evolve independently of the language. I think that one early place we'll see this is type inference. Type inference seems a natural fit for a language that straddles the line between static and dynamic typing.

##Aren't dynamic languages slow?

You and I both know that's simply not true. But it seems to be cropping up in the form of "optional typing means you can't take advantage of the type system to speed things up". But if dynamic languages are "fast enough", then what's the problem?

When the language doesn't have a reliance on the type system a whole raft of alternate optimisation routes open up. As Gilad will be keen to tall you, [Strongtalk](http://www.strongtalk.org/), which unsurprisingly shares a lot of its philosophy with Dart, manages to perform surprisingly well despite being optionally typed.

##So it's all a bed or roses?
The overwealmingly possitive bent to the post is designed to counteract the vast suaves of what I would consider unwarrented negativity I've seen. Not everything in Dart is good, and I have my own share of dissapointments - the inclusion of nulls, no signs of any plans to add type annotations beyond classnames - to add alongside the legitimate frowns of others, such as no implicit interfaces alla Go.

But remember, it's early days. I think it's a promising start to a language that has more room to grow than any others in the same arena (e.g. Coffescript). They seem keen to gather community feedback - though how much they'll pay attention remains to be seen.

Personally, I'm quite excited about where this Dart could go.
