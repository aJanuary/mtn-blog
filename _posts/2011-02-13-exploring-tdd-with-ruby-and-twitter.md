---
layout: post
title: Exploring TDD with Ruby and Twitter
tags: []
status: draft
type: post
published: false
meta:
  _edit_last: '1'
---
For the past few years I've been reading about TDD, I've been watching presentations about TDD, I've been listening to podcasts about TDD. Hell, I've even occasionally extolled the virtues of TDD. But the one thing I've not been doing is TDD itself.

You see, I have this problem, which I'm sure a lot of people share. For the small throw away projects, I feel like TDD is overkill. Yes, when you get sufficiently good and it doesn't take 5 minutes staring at the screen wondering how the heck to write the tests, TDD is wonderful for even small projects. But when I want to spend 10 minutes writing a small throw away application I don't want to quadruple my time and effort.

But whenever I start a more substantial project I feel like getting started with TDD is even harder. I have all sorts of external dependancies I'll need to mock out, and I have to start changing how I write the application to make it more testable etc.

But this has gone on for too long. It's embarrassing now, really. I should know how to do this stuff, and it's time to learn. Rather than sit and struggle with it on my own, I thought I'd blog about it as I go. I know I'm not going to get hundreds of replies - I'm no [Scott Hanselman](http://www.hanselman.com/blog/IntroducingBabySmashAWPFExperiment.aspx) - but hopefully if I make enough noise I'll get some help. Even if you're a complete novice, I'd appreciate some outside perspective on what I'm doing.

Historically I'm pretty bad at showing my own code. Sure, I'll do the odd snippet, but anything larger and I get embarrassed. Which is a pretty bad trait for a developer, when you think about it. To get over this hurdle I've decided to do the project in Ruby. I've never done any Ruby programming before, so whenever something looks hideous or is done wrong, I can blame that and save myself some face.

The first part of the project is to use the Twitter API to scrape tweets, extract the information I'm interested in, and store that in the database. Probably not a fantastic place to start learning TDD, as there's actually very little work I'm doing myself and quite large dependancies on external modules, but this forms part of a larger project I have been wanting to work on for a while.
