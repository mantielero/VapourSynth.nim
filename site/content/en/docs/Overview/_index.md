---
title: "Overview"
linkTitle: "Overview"
weight: 1
description: >
  What is VapourSynth.nim and how can it help me?
---


## What is it?

VapourSynth.nim wraps [VapourSynth](https://www.vapoursynth.com) in the [Nim](https://nim-lang.org/) programming language (formerly known as Nimrod).

- **VapourSynth** is a frame server. This is a library that enables you process video. There are plenty of plugins which contain filters. They can be combined in Python scripts. This enables the creation of complex pipelines allowing you to perform anything from adjusting colours, video stabilization, advance deinterlacing, [video restoration](https://youtu.be/OulrI4yaz64), ... 

- **Nim** is a language that compiles to C and it is optionally garbage collected. It gives you C-like performance. But on the other hand, it gives you Python-like syntax. 

  It is not an easy language to learn (but it is not as complex as Rust). The difficulty comes in my opinion because all the features it brings. Nonetheless, when you use it, it feels like they have taken a lot of good decissions. In my opinion, Nim it is like Go, but more powerful. 



## Why?

In VapourSynth, you have scripts made in Python and filters made in C or C++.

Nim provides metaprogramming, so it makes easy to create Domain Specific Language. I used this feature in order to create custom filters. 

So in VapourSynth.nim you have scripts made in Nim and filters made in... Nim again. So it solves the two language problem that Julia aims to solve as well.

Nim is a compiled language, so you only need to have installed the vapoursynth library and whatever plugin you are using. There is no need for an additional runtime as in the case of python. This makes easier the deployment (as in Go), because you end up with just one binary.

## Limitations
This is a toy project that I made in order to learn Nim. I just made it work. But I haven't implemented all the capabilities that might be necessary:

- I haven't check with all the format that one migth face.  
- I integrate only the plugins available in my system. Every plugin you use needs a wrapper. I have a binary in order to create wrapper for whatever plugin is available in your system.
- I am not a pro, and this is the first time I wrap a C library (well I had an attemp with Julia). I am not a C developper, so you might expect all sort of things (memory leaks, ... who knows).
- It does not use `.vpy`files.
- It does not use AviSynth plugins.
- Filters that depend on python functions won't work.

## Guarantees
None. I earn nothing with this project and I am not a proffessional developer, so this library might bite your hand.

## Where should I go next?

* [Getting Started](/getting-started/): Get started with $project
* [Examples](/examples/): Check out some example code!




