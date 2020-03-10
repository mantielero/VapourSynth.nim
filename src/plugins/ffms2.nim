proc GetLogLevel():ptr VSMap =
  let plug = getPluginById("com.vapoursynth.ffms2")
  let args = createMap()

  return API.invoke(plug, "GetLogLevel".cstring, args)        

proc Index(source:string; cachefile=none(string); indextracks=none(seq[int]); dumptracks=none(seq[int]); audiofile=none(string); errorhandling=none(int); overwrite=none(int); demuxer=none(string)):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.ffms2")
  let args = createMap()
  propSetData(args, "source", source, paAppend)
  if cachefile.isSome:
    propSetData(args, "cachefile", cachefile.get, paAppend)
  if indextracks.isSome:
    propSetIntArray(args, "indextracks", indextracks.get, paAppend)
  if dumptracks.isSome:
    propSetIntArray(args, "dumptracks", dumptracks.get, paAppend)
  if audiofile.isSome:
    propSetData(args, "audiofile", audiofile.get, paAppend)
  if errorhandling.isSome:
    propSetInt(args, "errorhandling", errorhandling.get, paAppend)
  if overwrite.isSome:
    propSetInt(args, "overwrite", overwrite.get, paAppend)
  if demuxer.isSome:
    propSetData(args, "demuxer", demuxer.get, paAppend)

  return API.invoke(plug, "Index".cstring, args)        

proc SetLogLevel(level:int):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.ffms2")
  let args = createMap()
  propSetInt(args, "level", level, paAppend)

  return API.invoke(plug, "SetLogLevel".cstring, args)        

proc Source(source:string; track=none(int); cache=none(int); cachefile=none(string); fpsnum=none(int); fpsden=none(int); threads=none(int); timecodes=none(string); seekmode=none(int); width=none(int); height=none(int); resizer=none(string); format=none(int); alpha=none(int)):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.ffms2")
  let args = createMap()
  propSetData(args, "source", source, paAppend)
  if track.isSome:
    propSetInt(args, "track", track.get, paAppend)
  if cache.isSome:
    propSetInt(args, "cache", cache.get, paAppend)
  if cachefile.isSome:
    propSetData(args, "cachefile", cachefile.get, paAppend)
  if fpsnum.isSome:
    propSetInt(args, "fpsnum", fpsnum.get, paAppend)
  if fpsden.isSome:
    propSetInt(args, "fpsden", fpsden.get, paAppend)
  if threads.isSome:
    propSetInt(args, "threads", threads.get, paAppend)
  if timecodes.isSome:
    propSetData(args, "timecodes", timecodes.get, paAppend)
  if seekmode.isSome:
    propSetInt(args, "seekmode", seekmode.get, paAppend)
  if width.isSome:
    propSetInt(args, "width", width.get, paAppend)
  if height.isSome:
    propSetInt(args, "height", height.get, paAppend)
  if resizer.isSome:
    propSetData(args, "resizer", resizer.get, paAppend)
  if format.isSome:
    propSetInt(args, "format", format.get, paAppend)
  if alpha.isSome:
    propSetInt(args, "alpha", alpha.get, paAppend)

  return API.invoke(plug, "Source".cstring, args)        

proc Version():ptr VSMap =
  let plug = getPluginById("com.vapoursynth.ffms2")
  let args = createMap()

  return API.invoke(plug, "Version".cstring, args)        

