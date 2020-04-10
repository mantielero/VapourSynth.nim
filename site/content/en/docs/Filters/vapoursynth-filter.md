
---
title: "VS plugin API"
linkTitle: "VapourSynth plugin"
weight: 3
description: >
  This is VapourSynth plugin API overview
---


## VapourSynth plugins
These are a few references about how to develop plugins in vapoursynth using C. The principles remain with Nim. Nonetheless, I will try to make this a bit easier in the future.

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

> Release the source frame

> Return destination
