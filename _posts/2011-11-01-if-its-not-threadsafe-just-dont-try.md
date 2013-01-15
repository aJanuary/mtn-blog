---
layout: post
title: If it's not threadsafe, just don't try
tags:
- Java
status: publish
type: post
published: true
meta:
  _edit_last: '1'
---
I recently got burnt by this at work. Even though I knew HashMap isn't threadsafe it was apparently working and rewriting to not use HashMap was work I didn't have time for now and was scheduled for later.

It appeared to be working because, whenever I printed out all the keys and values in the HashMap they were all correct, even when the overall result of the algorithm was wrong.

After much debugging it turned out it *was* the problem. This little sample should demonstrate it:

	import java.util.HashMap;
	import java.util.Map;
	import java.util.Set;

	public class Test {
		static final int NUM_THREADS = 4;
		static final int NUM_ELEMENTS = 4;
		static final int NUM_RUNS = 1000000;
		
		static class Tester {
			Map<Integer, Integer> map = new HashMap<Integer, Integer>();
		
			public void run() {
				for (int i = 1; i < NUM_ELEMENTS; i += 1) {
					map.put(i, i);
				}
		
				Runnable runnable = new Runnable() {
					public void run() {
						for (int i = 0; i < NUM_RUNS; i += 1) {
							map.put(0, 0);
							Set<Integer> elements = map.keySet();
							if (elements.size() != NUM_ELEMENTS) {
								System.err.println("[" + Thread.currentThread().getId() + "] numElements=" + elements.size());
								
								for (Object element : elements) {
									System.err.println("[" + Thread.currentThread().getId() + "] " + element + "=" + map.get(element));
								}
							}
						}
					}
				};
			
				for (int i = 0; i < NUM_THREADS; i += 1) {
					new Thread(runnable).start();
				}
			}
		}
		
		public static void main(String[] args) {
			while (true) {
				new Tester().run();
			}
		}
	}

If you leave it running for a bit (the higher NUM_THREADS is the quicker it should happen) you'll eventually start to see that map.keySet().size() is way off - 11, 14, 23 - each thread will start to have its own incorrect value for elements.size(). But - and here's the weird bit - the keys and values inside map are all correct.

The take-away lesson? Even if you think something is working fine, if it's documented as not being threadsafe just don't try it.
