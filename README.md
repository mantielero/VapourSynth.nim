# VapourSynth.nim

## Introduction
This library will enable you to perform video manipulation. To do it uses [VapourSynth](http://www.vapoursynth.com/) under the hood. With VapourSynth you can do things like this [video restoration](https://youtu.be/OulrI4yaz64).

This is a library for the [Nim programming language](https://nim-lang.org/). Why another programming language?

I won't say it is an easy programming language. But it is for this particular case. For example, in python you do:

```python
from vapoursynth import core
video = core.ffms2.Source(source='Rule6.mkv')
video = core.std.Transpose(video)
video.set_output()
```

and play it like:
```
$ vspipe --y4m script.vpy - | ffplay -i pipe:
```

With Nim, you write:
```nim
import vapoursynth
Source("Role6.mkv").Transpose.Pipey4m
```

Nim is a compiled language (like C). So you need to compile it:
```
$ nim c script.nim
```

and then you can play it like:
```
$ ./script | ffplay -i pipe:
```


## Current status
It can load videos, transform them and pipe them (or store them).

Currently, the following [plugins](https://github.com/mantielero/VapourSynth.nim/tree/master/src/plugins) are supposed to work (they need to be installed in your environment). 


## Some examples
### Piping a video
```nim
import vapoursynth
Source("video.mkv").Pipey4m
```
### Selecting the first 100 frames
```nim
import vapoursynth
Source("video.mkv")[0..100].Pipey4m
```
### Aplying one of [VapourSynth functions](http://www.vapoursynth.com/doc/functions.html) (ex. [Transpose](http://www.vapoursynth.com/doc/functions/transpose.html))
```nim
import vapoursynth
Source("video.mkv")[0..100].Transpose.Pipey4m
```
### Aplying one function from a plugin
The are two requirements in order to be able to use a function from a plugin:

- The plugin needs to be installed in your computer
- The plugin needs to be wrapped. You can find a list of the plugins already wrapped [here](https://github.com/mantielero/VapourSynth.nim/tree/master/src/plugins).

> Note that this wrappers are created automatically. You just need to install any plugin in your computer and then execute [plugin_generator](https://github.com/mantielero/VapourSynth.nim/blob/master/src/plugin_generator.nim). It will create the folder `plugins` for all the available plugins in your computer.

Then the function is called directly. For instance, the already used function `Source` is provided by the plugin [ffms2](https://github.com/mantielero/VapourSynth.nim/blob/master/src/plugins/ffms2.nim#L44):
```nim
import vapoursynth
Source("video.mkv").Pipey4m
```



### Passing parameters

Mandatory parameters are passed straight away, like in the case of `Source`, where we just put the name of the file:
```nim
Source("video.mkv")
```

Optional parameters requires importing the `options` module, which provides the keyword `some`. It is used as follows:

```nim
import vapoursynth, options
Source("video.mkv").Bicubic(width=some(320), height=some(200)).Pipey4m
```

> Note: in Nim, it is equivalent: `some(320)` to `320.some` and also to `some 320`. Write it as you wish, and be ready to see it in any of these forms.

If you need to call many times the same function with the same signature, this can be anoying, so you can define your own function call like this:
```nim
import vapoursynth, options
proc myfilter(vsmap:ptr VSMap, w:int, h:int):ptr VSMap = vsmap.Bicubic(width=some(w), height=some(h))

Source("video.mkv").myfilter(320,200).Pipey4m
```

If you wish you can improve the readibility by doing:
```nim
Source("video.mkv").myfilter(w=320,h=200).Pipey4m
```

> Note that the first parameter of the filter has to be `vsmap:ptr VSMap` and the type returned by the filter: `ptr VSMap`. 

### Passing list parameters
In Nim the equivalent to lists are called sequence, and they are written like: `@[1, 2, 3]`.

For example, if you use the plugin [motionmask](https://github.com/dubhater/vapoursynth-motionmask):

```
import vapoursynth, options
Source("video.mkv").MotionMask( th1= some(@[10, 10, 10]), th2= some(@[10, 10, 10]), tht=some(10), sc_value=some(0)).Pipey4m
```

### Not only chaining functions is possible
You can store the videos in variables:
```nim
import vapoursynth, options
let clip1 = Source("video.mkv")

let clip2 = MotionMask( clip1, th1= some(@[10, 10, 10]), th2= some(@[10, 10, 10]), tht=some(10), sc_value=some(0))

Pipey4m(clip2)
#Or you could pipe the first clip:
#Pipey4m(clip1)
```

> Hereafter, I will omit the `import vapoursynth` line


## Custom filter
### VapourSynth plugins
[Writting plugins](http://www.vapoursynth.com/doc/api/vapoursynth.h.html#writing-plugins) in VapourSynth requires five functions:

 - `VapourSynthPluginInit`: entry point. Its purpose is to configure the plugin and to register the filters the plugin wants to export. (It has the function signature `VSFilterInit`)
 - `<foo>Create`: user defined function tasked with creating a filter instance. (It has the function signature `VSPublicFunction`)
 - `<foo>Init`: A filter’s "init" function. This function is called by `createFilter()` (indirectly). (It has the function signature `VSFilterInit`)
 - `<foo>GetFrame`: A filter's "getframe" function. It is called by the core when it needs the filter to generate a frame. (It has the function signature `VSFilterGetFrame`)
 - `<foo>Free`: a "free" function. This is where the filter should free everything it allocated, including its instance data. (Function signature: `VSFilterFree`)

Another thing a filter requires is an object for storing a filter instance’s private data. This object will usually contain the filter’s input nodes (if it has any) and a VSVideoInfo struct describing the video the filter wants to return.

- [filter skeleton](https://github.com/vapoursynth/vapoursynth/blob/master/sdk/filter_skeleton.c)
- [invert example](https://github.com/vapoursynth/vapoursynth/blob/master/sdk/invert_example.c)
- [vscript example](https://github.com/vapoursynth/vapoursynth/blob/master/sdk/vsscript_example.c)


Regarding `<foo>GetFrame`, this is the main function that gets called when a frame should be produced. It will, in most cases, get called several times to produce one frame. This state is being kept track of by the value of `activationReason`. The first call to produce a certain frame n is always arInitial. In this state you should request all the input frames you need. Always do it in ascending order to play nice with the upstream filters. Once all frames are ready, the filter will be called with arAllFramesReady. It is now time to do the actual processing.

Depending on activationReason, calls: `requestFrameFilter` otherwise: `getFrameFilter`, `getFrameHeight`, `getFrameWidth`

> When creating a new frame for output it is VERY EXTREMELY SUPER IMPORTANT to supply the "dominant" source frame to copy properties from. Frame props are an essential part of the filter chain and you should NEVER break it.

Calls: `newVideoFrame`

> Then, It's processing loop time! Loop over all the planes


```c
int plane;
for (plane = 0; plane < fi->numPlanes; plane++) {
    const uint8_t *srcp = vsapi->getReadPtr(src, plane);
    int src_stride = vsapi->getStride(src, plane);
    uint8_t *dstp = vsapi->getWritePtr(dst, plane);
    int dst_stride = vsapi->getStride(dst, plane); // note that if a frame has the same dimensions and format, the stride is guaranteed to be the same. int dst_stride = src_stride would be fine too in this filter.
    // Since planes may be subsampled you have to query the height of them individually
    int h = vsapi->getFrameHeight(src, plane);
    int y;
    int w = vsapi->getFrameWidth(src, plane);
    int x;

    for (y = 0; y < h; y++) {
        for (x = 0; x < w; x++)
            dstp[x] = ~srcp[x];

        dstp += dst_stride;
        srcp += src_stride;
    }
}
```

> Release the source frame

> Return destination

## Nim filter
La clave es la función [createFilter](http://www.vapoursynth.com/doc/api/vapoursynth.h.html#createfilter) y quizá la función [registerFunction](http://www.vapoursynth.com/doc/api/vapoursynth.h.html#registerfunction).



The idea is to avoid all that an just to have a Nim function.
Probably using [ModifyFrame](http://www.vapoursynth.com/doc/functions/modifyframe.html), and then something equivalent to `getFrame`

https://github.com/vapoursynth/vapoursynth/blob/aa075b009fd4bdbf6aad7b4784092e79eb2f680c/src/core/simplefilters.c#L1620



## TODO

- [DONE] Simplify the wrapper with some overloading.
- [ ] To use better naming given the advantages provided by Nim.
- [DONE] Better handling of errors.
- [PARTIAL] Helper functions for +, [], ...

  - [DONE] The whole clip: clip[1:]
  - Reversed: clip[end:-1:1]
  - Odd: clip[1:2:end]
  - Even: clip[2:2:end]

- [ ] Better documentation
- [WON'T WORK] Does it work with nimscript? Given Nimscript limitation: "Nim's FFI (foreign function interface) is not available in NimScript. This means that any stdlib module which relies on importc can not be used in the VM."
- [ ] Github pages
- [ ] To enable dealing with frames like an array.
- [ ] To enable loading plugins manually.
- [ ] To enable loading AVS scripts (for instance for deinlerlacing). Options are [AviSource](http://avisynth.nl/index.php/AviSource). [VS_AvsReader](https://github.com/chikuzen/VS_AvsReader) and [vsavsreader](https://forum.doom9.org/showthread.php?t=165957)
- [ ] To take a look at [Home Of VapourSynth Evolution](https://github.com/HomeOfVapourSynthEvolution/havsfunc/blob/master/havsfunc.py)

- [ ] Developping plugins directly in Nim (maybe is already possible). In any case, check: [Escribir Filtros](http://avisynth.nl/index.php/Filter_SDK), [InvertNeg](http://avisynth.nl/index.php/Filter_SDK/InvertNeg), [AddGrain](https://github.com/HomeOfVapourSynthEvolution/VapourSynth-AddGrain/blob/master/AddGrain/AddGrain.cpp), [filter in python](https://forum.doom9.org/showthread.php?t=172206)


## Note for developpers
### Note on plugins function's signatures
Rather than a clip, the input is always a `ptr VSMap`. Given than `invoke` returns `ptr VSMap`, this enables chaining function scheme shown in the example.

# Vapoursynth Tutorial 
https://hackmd.io/@Se1ry_ZUSminEO7QQyVHAQ/HJwtY1WV7?type=view


# Avisynth
https://forum.doom9.org/showthread.php?t=175141
https://forum.doom9.org/showthread.php?t=165957


