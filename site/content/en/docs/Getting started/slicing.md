---
title: "Slicing and other syntactic suger"
linkTitle: "Slicing"
weight: 2
description: >
  This page describes some syntactic sugar pretty similar to the one provided in Python.
---

In Python you can perform [slicing](http://www.vapoursynth.com/doc/pythonreference.html#slicing-and-other-syntactic-sugar) on the clips. 

VapourSynth.nim provides similar capabilities. One difference is that VapoutSynth.nim returns `ptr VSMap` instead of clip or clips.

As in Python, the first frame has number `0`. The last frame is referenced as `last` or `-1`. So it is ok to write:
```nim
clip[0..last]
```

You can operate on `last` like:
```nim
clip[15..last-10]
```

The frames can be reversed by changing the order. Is it ok to do:
```nim
clip[last..0]
```

or:
```nim
clip[last-10..10]
```

You can skip frames for instance:

- Keeping Odd frames:
```nim
clip[1..last, 2]
```
- Keeping Even frames:
```nim
clip[0..last, 2]
```

## Concatenating clips
It is feasible to perform:
```nim
clip[0..50] + clip[50..0]
```

## Repeating clips
It is ok to do:
```nim
clip1 = clip * 40
clip2 = 40 * clip
```

> They both work


> TODO: We should use the same approach as VapourSynth: using Loop