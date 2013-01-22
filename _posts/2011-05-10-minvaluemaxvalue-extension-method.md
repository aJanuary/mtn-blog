---
layout: post
title: MinValue/MaxValue Extension Method
tags:
- C#
status: publish
type: post
published: true
meta:
  _wp_old_slug: ''
  _edit_last: '1'
---
Quite a lot of times it seems these little extension methods come in handy. They give the maximum or minimum value(s) from an `IEnumerable<T>`, optionally applying a projection for the ordering.

They have better complexity characteristics than ordering and taking the first item, which requires time and space to order pairs of items that we aren't interested in.

I could have used Aggregate instead of manually iterating over the enumerables. For Max/MinItem this would have made for much more readable code, but the implementations of Max/MinItems would have been either obscure or less performant, and I wanted to use a similar implementation for both.

I've only given the implementations that use a projection to int to pick the maximum or minimum value, but if needed it is trivial to implement them using other orderable data types.

It's all pretty simple stuff - it's just remembering to start with the first value that could possibly trip you up.

{:lang="java"}
    public static int MaxItem(this IEnumerable<int> list) {
        return MaxItem(list, x => x);
    }

    public static T MaxItem<T>(this IEnumerable<T> list, Func<T, int> selector) {
        var enumerator = list.GetEnumerator();

        if (!enumerator.MoveNext()) {
            // Return null/default on an empty list. Could choose to throw instead.
            return default(T);
        }

        T maxItem = enumerator.Current;
        int maxValue = selector(maxItem);

        while (enumerator.MoveNext()) {
            var item = enumerator.Current;
            var value = selector(item);

            if (value > maxValue) {
                maxValue = value;
                maxItem = item;
            }
        }

        return maxItem;
    }


    public static int MinItem(this IEnumerable<int> list) {
        return MinItem(list, x => x);
    }

    public static T MinItem<T>(this IEnumerable<T> list, Func<T, int> selector) {
        var enumerator = list.GetEnumerator();

        if (!enumerator.MoveNext()) {
            // Return null/default on an empty list. Could choose to throw instead.
            return default(T);
        }

        T minItem = enumerator.Current;
        int minValue = selector(minItem);

        while (enumerator.MoveNext()) {
            var item = enumerator.Current;
            var value = selector(item);

            if (value < minValue) {
                minValue = value;
                minItem = item;
            }
        }

        return minItem;
    }


{:lang="java"}
    public static IEnumerable<int> MaxItems(this IEnumerable<int> list) {
        return MaxItems(list, x => x);
    }

    public static IEnumerable<T> MaxItems<T>(this IEnumerable<T> list, Func<T, int> selector) {
        var enumerator = list.GetEnumerator();

        if (!enumerator.MoveNext()) {
            return Enumerable.Empty<T>();
        }

        var maxItem = enumerator.Current;
        List<T> maxItems = new List<T>() { maxItem };
        int maxValue = selector(maxItem);

        while (enumerator.MoveNext()) {
            var item = enumerator.Current;
            var value = selector(item);

            if (value > maxValue) {
                maxValue = value;
                maxItems = new List<T>() { item };
            } else if (value == maxValue) {
                maxItems.Add(item);
            }
        }

        return maxItems;
    }


{:lang="java"}
    public static IEnumerable<int> MinItems(this IEnumerable<int> list) {
        return MinItems(list, x => x);
    }

    public static IEnumerable<T> MinItems<T>(this IEnumerable<T> list, Func<T, int> selector) {
        var enumerator = list.GetEnumerator();

        if (!enumerator.MoveNext()) {
            return Enumerable.Empty<T>();
        }

        var minItem = enumerator.Current;
        List<T> minItems = new List<T>() { minItem };
        int minValue = selector(minItem);

        while (enumerator.MoveNext()) {
            var item = enumerator.Current;
            var value = selector(item);

            if (value < maxValue) {
                minValue = value;
                minItems = new List<T>() { item };
            } else if (value == minValue) {
                minItems.Add(item);
            }
        }

        return minItems;
    }