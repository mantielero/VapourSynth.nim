---
title: "VapourSynth functions"
linkTitle: "Functions"
description: >
  Here you will found out about how to use VapourSynth functions
---

## Introduction
VapourSynth provides a number of functions that you can find in the [Function Reference](http://www.vapoursynth.com/doc/functions.html).

At the end of the day, these are just filters included in a plugin named `std`. The source code for these filters is in [simplefilter.c](https://github.com/vapoursynth/vapoursynth/blob/master/src/core/simplefilters.c).

## Most of them work
### Using a filter
VapourSynth.nim treats `std` plugin as any other plugin. It is already wrapped in [std.nim](https://github.com/mantielero/VapourSynth.nim/blob/master/src/plugins/std.nim) and you don't need to do anything special to use it.

For instance, in order to apply the [Transpose](http://www.vapoursynth.com/doc/functions/transpose.html) filter:
```nim
import vapoursynth
Source("video.mkv").Transpose.Pipey4m
```

### How can I pass parameters?
The way I wrap the functions is that optional parameters can receive `none` or `some` value. By default, I am passing `none` to all the optional parameters. Optional parameters requires importing the `options` module, which provides the keyword `some`. If you want to pass something different you have to do it like this:
```nim
import vapoursynth, options
Source("video.mkv").Bicubic(width=some(320), height=some(200)).Pipey4m
```

> In Nim, it is equivalent doing: `some(320)`, `320.some` and `some 320` so you could write:
> ```nim
> import vapoursynth, options
> Source("video.mkv").Bicubic(width=320.some, height=200.some).Pipey4m
>                                   ^^^^^^^^         ^^^^^^^^
> ```

You could create a custom function making this parameters mandatory. This might be useful if you are going to call the same function with the same signature many times (and you want to avoid writting `some` many times:
```nim
import vapoursynth, options
proc myfilter(vsmap:ptr VSMap, w:int, h:int):ptr VSMap = 
  return vsmap.Bicubic(width=some(w), height=some(h))

Source("video.mkv").myfilter(320,200).Pipey4m
```

> All the filters in VapourSynth.nim, has a first argument typed `ptr VSMap` and returns a `ptr VSMap`. This allows chaining functions.
> ```nim
> proc myfilter(vsmap:ptr VSMap, w:int, h:int):ptr VSMap =
>                     ^^^^^^^^^                ^^^^^^^^^
> ```

We can improve the readability by calling the filter with `(w=320,h=200)`:
```nim
Source("video.mkv").myfilter(w=320,h=200).Pipey4m
```

## Some notes on Nim
Nim is typed. So you can avoid some erros by taking advance of it. For example, you could define `myfilter` to take `Natural` (which includes only integers equal or greater than 0) instead of `int`.