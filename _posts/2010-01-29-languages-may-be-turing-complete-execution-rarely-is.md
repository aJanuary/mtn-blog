---
layout: post
title: Languages May Be Turing Complete - Execution Rarely Is
tags:
- Programming
- Turing Complete
status: publish
type: post
published: true
meta:
  _edit_last: '1'
---
Just because a language is Turing Complete, it doesn't necessarily mean that the execution is. This is because, while languages rarely bother about details like the size of memory, a particular implementation and execution environment place restrictions on things like the amount of memory available.

Take, for example, the problem of adding natural numbers in C. Cs built-in data types aren't capable of storing all natural numbers, so we'll have to come up with our own encoding. We'll pick a simple encoding to be representative - a natural number is encoded as a null terminated linked list, with the length of the list being the number it represents. We can then add them together by creating a new linked list which is as long as the length of both of them added.

    #include <stdlib.h>
    #include <stdio.h>

    struct encoding_el {
        struct encoding_el* next;
    };
    typedef struct encoding_el encoding;

    encoding* encode(long num) {
        if (num <= 0) {
            return NULL;
        }

        encoding* cur = (encoding *)malloc(sizeof(encoding));
        cur->next = encode(num - 1);
        return cur;
    }

    long decode(encoding* encoded) {
        if (encoded == NULL) {
            return 0;
        }
        return 1 + decode(encoded->next);
    }

    encoding* copy(encoding* encoded) {
        if (encoded == NULL) {
            return NULL;
        }

        encoding* cur = (encoding *)malloc(sizeof(encoding));
        cur->next = copy(encoded->next);
        return cur;
    }

    encoding* add(encoding* a, encoding* b) {
        encoding* a_copy = copy(a);
        encoding* b_copy = copy(b);
        encoding* result = a_copy;

        while (a_copy->next) {
            a_copy = a_copy->next;
        }
        a_copy->next = b;

        return result;
    }

    encoding* sub(encoding* a, encoding* b) {
        if (!a) {
            return NULL;
        }

        if (!b) {
            return copy(a);
        }

        return sub(a->next, b->next);
    }
        
    int main() {
        encoding* a = encode(10);
        encoding* b = encode(20);
        encoding* c = encode(15);

        encoding* result = sub(add(a, b), c);
        printf("%ld\n", decode(result));

        return 0;
    }</pre>

We've defined some convenience methods to convert to and from longs, but we needn't necessarily use them &mdash; we could manually build a really long list. If you run the code it should print out the expected value, 15.

While the encoding can theoretically hold a representation of any natural number, practically it can't. Once you start trying to encode huge numbers* you eventually hit a point where you run out of memory. So while we can add a large range of natural numbers, we can't add all natural numbers. Sure we could use a more compact representation, but eventually any implementation is going to get to the point where it has run out of memory.

Turing Machines deal with the theoretical &mdash; they have a theoretically infinite tape. In practice there are memory constraints. While this this isn't so much a problem nowadays, it still means that in reality an execution of a program cannot perform any calculation, just a large subsection.

* You'd need a different implementation of encode, as C doesn't usually do tail-recursion optimisations and so it runs out of stack.
