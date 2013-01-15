---
layout: post
title: A New Improved Circular Buffer
tags: []
status: publish
type: post
published: true
meta:
  _edit_last: '1'
---
A while back I wrote a post on what I called a [Stream Data Structure](http://www.morethannothing.co.uk/2009/02/stream-data-structure/). I recently needed a similar thing again, and so looked back at the post to reuse the code.

While it works well, I've never been particularly happy with all of the code, more specifically the use of two loop variables in GetEnumerator. Today I managed to do a simple refactoring to hopefully make the logic simpler.

    private class StreamBuffer<T> : IEnumerable<T>
    {
        private int head = 0;
        private bool filled = false;

        private T[] stream;
        public int Size { get; private set; }

        public StreamBuffer(int size)
        {
            Size = size;
            stream = new T[Size];
        }

        public void Add(T item)
        {
            stream[head] = item;

            head += 1;
            if (head >= Size)
            {
                head = 0;
                filled = true;
            }
        }

        public IEnumerator<T> GetEnumerator()
        {
            int start = filled ? head : 0;
            int size = filled ? Size : head;
            for (int i = 0; i < size; i += 1)
            {
                int p = (start + i) % Size;
                yield return stream[p];
            }
        }

        System.Collections.IEnumerator System.Collections.IEnumerable.GetEnumerator()
        {
            return GetEnumerator();
        }
    }
