proc AverageFrames(clips:clip[], weights:seq[float]; scale=none(float); scenechange=none(int); planes=none(seq[int])):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.misc")
  let args = createMap()
  (args, "clips", clips, paAppend)
  propSetFloatArray(args, "weights", weights, paAppend)
  if scale.isSome:
    propSetFloat(args, "scale", scale.get, paAppend)
  if scenechange.isSome:
    propSetInt(args, "scenechange", scenechange.get, paAppend)
  if planes.isSome:
    propSetIntArray(args, "planes", planes.get, paAppend)

  return API.invoke(plug, "AverageFrames".cstring, args)        

proc Hysteresis(clipa:ptr VSNodeRef, clipb:ptr VSNodeRef; planes=none(seq[int])):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.misc")
  let args = createMap()
  propSetNode(args, "clipa", clipa, paAppend)
  propSetNode(args, "clipb", clipb, paAppend)
  if planes.isSome:
    propSetIntArray(args, "planes", planes.get, paAppend)

  return API.invoke(plug, "Hysteresis".cstring, args)        

proc SCDetect(clip:ptr VSNodeRef; threshold=none(float)):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.misc")
  let args = createMap()
  propSetNode(args, "clip", clip, paAppend)
  if threshold.isSome:
    propSetFloat(args, "threshold", threshold.get, paAppend)

  return API.invoke(plug, "SCDetect".cstring, args)        

