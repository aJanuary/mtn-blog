---
layout: post
title: FizzBuzz Golf
tags:
- C#
- golf
- Programming
status: publish
type: post
published: true
meta:
  _edit_last: '1'
  _wp_old_slug: ''
---
Someone linked to [http://golf.shinh.org/p.rb?FizzBuzz](http://golf.shinh.org/p.rb?FizzBuzz) today and I couldn't help but have a go. Currently I'm ranked 20 in the C# solutions, but I just can't seem to shave off those last few characters. (The following code is obviously unminified)

	class X {
		static void Main() {
			for (int i=0; i<100;) {
				var z = ++i % 5 > 0 ? null : "Buzz";
				System.Console.WriteLine(i%3 > 0 ? z??i+"" : "Fizz" + z);
			}
		}
	}

While googling around for inspiration on other possible angles to attack the problem I saw many so-called "good" and "simple" solutions, all of which looked far too complicated to me. So here's what I think a good solution looks like.

	using System;

	static class FizzBuzz {
		static void Main() {
			for (int i = 1; i <= 100; i += 1) {
				var fizz = i % 3 == 0;
				var buzz = i % 5 == 0;
				
				if (fizz) {
					Console.Write("Fizz");
				}
				
				if (buzz) {
					Console.Write("Buzz");
				}
				
				if (!fizz && !buzz) {
					Console.Write(i);
				}
				
				Console.WriteLine();
			}
		}
	}

It doesn't over-complicate things - there's no need to build up intermediate strings or to have nested branches - and it's quite clear from reading it what it does.

Now if I can just squeeze those last few characters out I can get to the top of the chart…
