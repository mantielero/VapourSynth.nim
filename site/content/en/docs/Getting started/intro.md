---
title: "Introduction"
linkTitle: "Introduction"
weight: 1
description: >
  This provides some flavor about how to use it.
---


## Python vs Nim syntax
This sections aims to give you an idea about how you normally do things in Python and how can you do it in Nim

### Open a file, transpose it and play it

#### Python
Create **script.vpy** with:
```python
from vapoursynth import core
video = core.ffms2.Source(source='videofile.mkv')
video = core.std.Transpose(video)
video.set_output()
```

and play it like:
```
$ vspipe --y4m script.vpy - | ffplay -i pipe:
```

#### Nim
Create **script.nim**:
```nim
import vapoursynth
Source("videofile.mkv").Transpose.Pipey4m
```

Compile it:
```
$ nim c -d:release -d:danger --threads:on script.nim
```

and then you can play it like:
```
$ ./script | ffplay -i pipe:
```

-------

## Current status
It can load videos, transform them and pipe them to stdout (or store them in a file).

Currently, the following [plugins](https://github.com/mantielero/VapourSynth.nim/tree/master/src/plugins) are supposed to work (they need to be installed in your environment). 



How to implement Nim functions as filters is shown in:

- [test/simple.nim](https://github.com/mantielero/VapourSynth.nim/blob/a022a045694c2bf1e93d821ff87f6a0a8916f098/test/simple.nim): a very simple passthrough filter with comments
- [test/mycrop.nim](https://github.com/mantielero/VapourSynth.nim/blob/a022a045694c2bf1e93d821ff87f6a0a8916f098/test/mycrop.nim): a crop filter inspired on [cropRelCreate](https://github.com/vapoursynth/vapoursynth/blob/R48/src/core/simplefilters.c#L251). Just crops a video giving `top`, `bottom`, `left` and `right`.

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

> Functions can be chained because, rather than a clip, the input is always a `ptr VSMap`. Given that `invoke` returns `ptr VSMap`.

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



# Additional notes. 


## TODO

- [DONE] Helper functions for +, [], ...


  - [DONE] Some functions no write filters

- [ ] Better documentation
- [WON'T WORK] Does it work with nimscript? Given Nimscript limitation: "Nim's FFI (foreign function interface) is not available in NimScript. This means that any stdlib module which relies on importc can not be used in the VM."
- [ ] Github pages
- [ ] To enable dealing with frames like an array.
- [ ] To enable loading plugins manually.
- [ ] To enable loading AVS scripts (for instance for deinlerlacing). Options are [AviSource](http://avisynth.nl/index.php/AviSource). [VS_AvsReader](https://github.com/chikuzen/VS_AvsReader) and [vsavsreader](https://forum.doom9.org/showthread.php?t=165957)
- [ ] To take a look at [Home Of VapourSynth Evolution](https://github.com/HomeOfVapourSynthEvolution/havsfunc/blob/master/havsfunc.py)
- [ ] To compare with this [filter in pure python](https://forum.doom9.org/showthread.php?t=172206)


# Vapoursynth Tutorial 
https://hackmd.io/@Se1ry_ZUSminEO7QQyVHAQ/HJwtY1WV7?type=view


# Avisynth
https://forum.doom9.org/showthread.php?t=175141
https://forum.doom9.org/showthread.php?t=165957

[AddGrain](https://github.com/HomeOfVapourSynthEvolution/VapourSynth-AddGrain/blob/master/AddGrain/AddGrain.cpp), 