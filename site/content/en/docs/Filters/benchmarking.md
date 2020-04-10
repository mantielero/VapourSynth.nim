---
title: "Benchmarking"
linkTitle: "Benchmarking"
weight: 10
description: >
  Comparing filters performance in Nim and C++
---


I manage to compare in my computer the pure C++ filter and a Nim based version.


## Not apples to apples
Right now this is not comparing apples to apples. Using `vspipe`

## C++ Version
I took it from [here](https://github.com/IFeelBloated/test_c_filters). I compiled with:
```
g++ -Wall -O3 -shared -fPIC -I. -o libfilter.so GaussBlur.cxx
```

Create a VapourSynth python filter like **test_filter.vpy**:
```python
import vapoursynth as vs
core = vs.get_core()
core.std.LoadPlugin(path='./libfilter.so')
core.std.SetMaxCPU('none')
clip = core.std.BlankClip(format=vs.GRAYS, length=100000, fpsnum=24000, fpsden=1001, keep=True)
clip = core.testc.GaussBlur(clip)
clip.set_output()
```

and finally:
```
$ vspipe test_filter.vpy /dev/null
Output 100000 frames in 29.53 seconds (3386.27 fps)
```

## Nim Version
I use custom_filter.nim which uses DrawFrame.nim.

I compile it like:
```
$ nim c -f --threads:on -d:release -d:danger custom_filter
```

And test it by doing:
```
$ ./custom_filter 
Time       : 9.394126653671265
Num. frames: 100000
FPS        : 10644.94909283766
```
when using int32.

If I use float32:
```
$ ./custom_filter 
Time       : 16.52139902114868
Num. frames: 100000
FPS        : 6052.756178335272
```

I wasn't using multithreading before while vspipe does.

## Convolution 
Another test that I have done is using the Convolution filter from Nim: **convolution.nim** and I get:
```
$ ./convolution 
Time       : 5.210163354873657
Num. frames: 100000
FPS        : 19193.25617813089
```

Using vspipe and python script:
```
$ vspipe convolution.vpy /dev/null
Output 100000 frames in 26.87 seconds (3721.76 fps)
```

I think that vspipe is actually writting frames to /dev/null while I just request the frame and then dismiss them without further processing.

## TODO
In order to avoid the effect that using `vspipe` has, I need to wrap Gauss C++ filter in nim and use it through nim.