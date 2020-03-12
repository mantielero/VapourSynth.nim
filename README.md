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

## TODO

- [ ] Simplify the wrapper with some overloading.
- [ ] To use better naming given the advantages provided by Nim.
- [ ] Better handling of errors.
- [ ] Helper functions for +, [], ...

  - The whole clip: clip[1:end]
  - Reversed: clip[end:-1:1]
  - Odd: clip[1:2:end]
  - Even: clip[2:2:end]

- [ ] Better documentation
- [ ] Github pages
- [ ] To enable dealing with frames like an array.
- [ ] To enable loading plugins manually.
- [ ] To enable loading AVS scripts (for instance for deinlerlacing). Options are [AviSource](http://avisynth.nl/index.php/AviSource). [VS_AvsReader](https://github.com/chikuzen/VS_AvsReader) and [vsavsreader](https://forum.doom9.org/showthread.php?t=165957)
- [ ] To take a look at [Home Of VapourSynth Evolution](https://github.com/HomeOfVapourSynthEvolution/havsfunc/blob/master/havsfunc.py)

- [ ] Developping plugins directly in Nim (maybe is already possible). In any case, check: [Escribir Filtros](http://avisynth.nl/index.php/Filter_SDK), [InvertNeg](http://avisynth.nl/index.php/Filter_SDK/InvertNeg), [AddGrain](https://github.com/HomeOfVapourSynthEvolution/VapourSynth-AddGrain/blob/master/AddGrain/AddGrain.cpp), [filter in python](https://forum.doom9.org/showthread.php?t=172206)


## Note for developpers
### Note on plugins function's signatures
Rather than a clip, the input is always a `ptr VSMap`. Given than `invoke` returns `ptr VSMap`, this enables chaining function scheme shown in the example.



