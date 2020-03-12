proc AverageFrames*(vsmap:ptr VSMap, weights:seq[float]; scale=none(float); scenechange=none(int); planes=none(seq[int])):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.misc")
  if plug == nil:
    raise newException(ValueError, "plugin \"misc\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq
  if tmpSeq.len != 1:
    raise newException(ValueError, "the vsmap should contain one item")
  if tmpSeq[0].nodes.len >= 1:
    raise newException(ValueError, "the vsmap should contain a seq with nodes")
  var clips = tmpSeq[0].nodes


  let args = createMap()
  for item in clips:
    propSetNode(args, "clips", item, paAppend)
  propSetFloatArray(args, "weights", weights)
  if scale.isSome:
    propSetFloat(args, "scale", scale.get, paAppend)
  if scenechange.isSome:
    propSetInt(args, "scenechange", scenechange.get, paAppend)
  if planes.isSome:
    propSetIntArray(args, "planes", planes.get)

  return API.invoke(plug, "AverageFrames".cstring, args)        

proc Hysteresis*(vsmap:ptr VSMap, clipb:ptr VSNodeRef; planes=none(seq[int])):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.misc")
  if plug == nil:
    raise newException(ValueError, "plugin \"misc\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq
  if tmpSeq.len != 1:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clipa = tmpSeq[0].nodes[0]


  let args = createMap()
  propSetNode(args, "clipa", clipa, paAppend)
  propSetNode(args, "clipb", clipb, paAppend)
  if planes.isSome:
    propSetIntArray(args, "planes", planes.get)

  return API.invoke(plug, "Hysteresis".cstring, args)        

proc SCDetect*(vsmap:ptr VSMap; threshold=none(float)):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.misc")
  if plug == nil:
    raise newException(ValueError, "plugin \"misc\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq
  if tmpSeq.len != 1:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  let args = createMap()
  propSetNode(args, "clip", clip, paAppend)
  if threshold.isSome:
    propSetFloat(args, "threshold", threshold.get, paAppend)

  return API.invoke(plug, "SCDetect".cstring, args)        

