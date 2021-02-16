# The Nim Framework for Ellie Silver's Major Qualifying Project
This project implements a version of Jeurgen Schmidhuber's Optimal Ordered Problem Solver [(OOPS)](http://people.idsia.ch/~juergen/oops.html) in a lisp-like, point-free language. The framework is written in [Nim](https://nim-lang.org), because it allows for large amounts of meta-programming and still compiles to C. It is expressive, elegant, and extremely powerful.

This repository contains the source code for a universal solver. That is, a program which searches the entirety of valid program space to solve an input problem. Given enough time, this program can solve any computable problem. In fact the time taken is guaranteed to be polynomial with respect to the input problem, and exponential with respect to the solution's length.

This code is pre-setup to perform energy-based breadth-first searches on program space to solve y = x^2 for x in 0..10. The program punishes searching similar branches, that is ones whose answers closely mimic another branches, by merging energy and computational time when the same output is received by two separate programs.

Sample lines from output:
```
./main

(0, 0)
@[(X: 0, energy: 1048576.0, preference_table: @[0.5, 0.5], path: @["0"]), (X: 0, energy: 1048576.0, preference_table: @[0.5, 0.5], path: @["X[0]"])]

(1, 1)
@[(X: 1, energy: 1048576.0, preference_table: @[0.5, 0.5], path: @["X[1]"])]

(2, 4)
@[(X: 4, energy: 559240.5333333333, preference_table: @[0.3, 0.7], path: @["X[2]", "INC", "INC"])]

(3, 9)
@[(X: 9, energy: 312067.2026819047, preference_table: @[2.775557561562891e-17, 0.9999999999999999], path: @["X[3]", "INC", "INC", "INC", "INC", "INC", "INC"])]
```
In this restrictive language there are only the atomic functions INC and DEC, though theory tells us that those are the only functions required for full computability. The output shows first the problem instance pair (x, y) and then the machine's output:
* X: paradoxically, this stands for Y. This is a hold over from conflicting syntaxes of various theorists
* energy: the energy alloted to the branch (used as a polynomial-time bounding device for pruning exhausted branches)
* preference_table: each branch keeps a preference of what atom to use next [DEC, INC], based on its past experiences and success.
* path: the program created by the universal solver. That is the point-free string of combinators which calculate y from x.
