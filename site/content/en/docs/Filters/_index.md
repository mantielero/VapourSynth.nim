
---
title: "Filters"
linkTitle: "Filters"
weight: 3
date: 2017-01-05
description: >
  See your project in action!
---


## Introduction

In Nim you can create your custom filters as you would normally do in C or C++.

### Python example
In VapourSynth, you can create a filter in pure Python as shown [here](https://forum.doom9.org/showthread.php?t=172206). It is really easy (10 lines of code), but as the author mentioned, it is "exceptionally slow".

### C filters
In order to develop a filter in C, you need to include in a plugin or just to define a function. In any case, you need to fulfill the API depicted [here](/VapourSynth plugin/).

For example the [crop filter](https://github.com/vapoursynth/vapoursynth/blob/master/src/core/simplefilters.c#L136-L296) in the `std`
### Nim filters

You have two options. 

#### Implementing the C API
You can always implement the C API as in [mycrop.nim](https://github.com/mantielero/VapourSynth.nim/blob/02820715470ab9f9c152f8a68dc76a60893290db/test/mycrop.nim) example. 

This might be necessary in very particular cases, where you modify substancially the frame format.

#### Using a macro
I created a macro in order to make easier the development of filters.

This makes the creating of filters simple without having any impact on speed (this is because the macro creates all the required functions at compile time, not at runtime).

## Performance
The question is how fast is this. It is fast as C, but right now I am not comparing apples to apples yet.



