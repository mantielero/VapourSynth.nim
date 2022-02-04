# VapourSynth.nim

This enables video editing using the Nim programming language by means of using VapourSynth.

For more information visit the [web page](https://mantielero.github.io/VapourSynth.nim/) or go straight to the [documentation](https://mantielero.github.io/VapourSynth.nim/docs/).

> Everything is work in progress

# TODO
## Supporting new API4
New API implications: audio?

## Audio
To support the following:
```python
import vapoursynth as vs
audio = vs.core.bas.Source("somefile.mp3", track=-1)
video = vs.core.std.BlankClip()
video.set_output(0)
audio.set_output(1)
```

In Linux, install [BestAudioSource](https://github.com/vapoursynth/bestaudiosource):
```bash
$ yay -S aur/vapoursynth-plugin-bestaudiosource-git
```

Then rerun: `tools/plugin_generator`. This will wrap that plugin, creating the file: `plugins/bas.nim`.

Issue: now it is empty.