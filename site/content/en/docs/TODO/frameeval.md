
---
title: "FrameEval"
linkTitle: "FrameEval"
weight: 1
description: >
  This should enable animations
---

## FrameEval
An alternative to [FrameEval](http://www.vapoursynth.com/doc/functions/frameeval.html).

[simplefilter.c](https://github.com/vapoursynth/vapoursynth/blob/master/src/core/simplefilters.c#L1449-L1617) definitions.

https://forum.doom9.org/showthread.php?t=180441


Vemos que llama a la función mediante:

```
vsapi->callFunc(d->func, d->in, d->out, core, vsapi);
```

En donde `d->in` y `d->out` son los VSMap de entrada y salida. El objeto que usa en el filtro tiene la pinta:

```c
typedef struct {
    VSVideoInfo vi;
    VSFuncRef *func;
    VSNodeRef **propsrc;
    int numpropsrc;
    VSMap *in;
    VSMap *out;
} FrameEvalData;
``` 

Si vemos un ejemplo de su uso:

```python
import vapoursynth as vs
import functools

core = vs.get_core()
base_clip = core.std.BlankClip(format=vs.YUV420P8, length=1000, color=[255, 128, 128])

def animator(n, clip):
   if n > 255:
      return clip
   else:
      return core.std.BlankClip(format=vs.YUV420P8, length=1000, color=[n, 128, 128])

animated_clip = core.std.FrameEval(base_clip, functools.partial(animator, clip=base_clip))
animated_clip.set_output()
```

Vemos que la función queda definida en Python. 

La firma de FrameEval es:
```nim
proc FrameEval*(vsmap:ptr VSMap, eval:ptr VSFuncRef; prop_src= none(seq[ptr VSNodeRef])):ptr VSMap =
```

Puede interesar [createFunc](http://www.vapoursynth.com/doc/api/vapoursynth.h.html#createfunc).

[createFuncRef](https://github.com/vapoursynth/vapoursynth/blob/069b333ce2723cda2c28e5c88e263143a0be09fb/src/cython/vapoursynth.pyx#L351)