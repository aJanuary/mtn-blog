---
layout: post
title: Optimising isn't a sin - but do it effectively
tags:
- Programming
status: publish
type: post
published: true
meta:
  _edit_last: '1'
---
We all know we shouldn't optimise prematurely our code or try and guess where code needs optimising. Optimisations should only be done as the result of consideration of performance measurements.

But sometimes we can go too far the other way - rarely optimising and instead living with inefficient algorithms and code.

If your algorithm iterates through a list several times because the code is simpler and cleaner than one which iterates once or twice that's fine. But bare in mind how big that list could be; What is the typical size of the list? What are the possible extremes? What are the acceptable limits?

If the user of your software wants to run your function over a list of a couple of thousand items, is it acceptable that it now takes several minutes to execute? You may well decide that is perfectly reasonable, the user is silly to expect otherwise. On the other hand, it may be that it's not entirely unreasonable for them to want a quicker response and now you have a frustrated user.

You need to decide what is and isn't acceptable, and you need to test your code is within the bounds of acceptable performance. If it isn't, then it's time to revisit the code and possibly find a more optimal algorithm, or do a bit of refactoring.

But when you're doing so, make sure you are optimising the bottlenecks. There is no point shaving off a few seconds by using an array instead of a list if the algorithm itself is quadratic. What is the use in linearly speeding up your algorithm if it takes 10 times as long to render the item?

Measure the performance of your program, and use these measurements to find the bottlenecks.

These guidelines aren't about not optimising your code, they're about making sure you optimise productively. Only optimise away your bottlenecks, otherwise all your work will be in vain. Only optimise if your code is outside the acceptable limits, otherwise you'll be wasting time which may be better spent elsewhere.
