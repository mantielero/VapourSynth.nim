proc GetLogLevel*():ptr VSMap =
  let plug = getPluginById("com.vapoursynth.ffms2")
  if plug == nil:
    raise newException(ValueError, "plugin \"ffms2\" not installed properly in your computer")

  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()

  return API.invoke(plug, "GetLogLevel".cstring, args)        

proc Index*(source:string; cachefile=none(string); indextracks=none(seq[int]); dumptracks=none(seq[int]); audiofile=none(string); errorhandling=none(int); overwrite=none(int); demuxer=none(string)):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.ffms2")
  if plug == nil:
    raise newException(ValueError, "plugin \"ffms2\" not installed properly in your computer")

  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()
  args.append("source", source)
  if cachefile.isSome: args.append("cachefile", cachefile.get)
  if indextracks.isSome: args.set("indextracks", indextracks.get)
  if dumptracks.isSome: args.set("dumptracks", dumptracks.get)
  if audiofile.isSome: args.append("audiofile", audiofile.get)
  if errorhandling.isSome: args.append("errorhandling", errorhandling.get)
  if overwrite.isSome: args.append("overwrite", overwrite.get)
  if demuxer.isSome: args.append("demuxer", demuxer.get)

  return API.invoke(plug, "Index".cstring, args)        

proc SetLogLevel*(level:int):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.ffms2")
  if plug == nil:
    raise newException(ValueError, "plugin \"ffms2\" not installed properly in your computer")

  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()
  args.append("level", level)

  return API.invoke(plug, "SetLogLevel".cstring, args)        

proc Source*(source:string; track=none(int); cache=none(int); cachefile=none(string); fpsnum=none(int); fpsden=none(int); threads=none(int); timecodes=none(string); seekmode=none(int); width=none(int); height=none(int); resizer=none(string); format=none(int); alpha=none(int)):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.ffms2")
  if plug == nil:
    raise newException(ValueError, "plugin \"ffms2\" not installed properly in your computer")

  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()
  args.append("source", source)
  if track.isSome: args.append("track", track.get)
  if cache.isSome: args.append("cache", cache.get)
  if cachefile.isSome: args.append("cachefile", cachefile.get)
  if fpsnum.isSome: args.append("fpsnum", fpsnum.get)
  if fpsden.isSome: args.append("fpsden", fpsden.get)
  if threads.isSome: args.append("threads", threads.get)
  if timecodes.isSome: args.append("timecodes", timecodes.get)
  if seekmode.isSome: args.append("seekmode", seekmode.get)
  if width.isSome: args.append("width", width.get)
  if height.isSome: args.append("height", height.get)
  if resizer.isSome: args.append("resizer", resizer.get)
  if format.isSome: args.append("format", format.get)
  if alpha.isSome: args.append("alpha", alpha.get)

  return API.invoke(plug, "Source".cstring, args)        

proc Version*():ptr VSMap =
  let plug = getPluginById("com.vapoursynth.ffms2")
  if plug == nil:
    raise newException(ValueError, "plugin \"ffms2\" not installed properly in your computer")

  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()

  return API.invoke(plug, "Version".cstring, args)        

