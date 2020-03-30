proc AverageFrames*(vsmap:ptr VSMap, weights:seq[float]; scale=none(float); scenechange=none(int); planes=none(seq[int])):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.misc")
  if plug == nil:
    raise newException(ValueError, "plugin \"misc\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq    # Convert the VSMap into a sequence
  if tmpSeq.len == 0:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len >= 1:
    raise newException(ValueError, "the vsmap should contain a seq with nodes")
  var clips = tmpSeq[0].nodes


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()
  for item in clips:
    args.append("clips", item)
  args.set("weights", weights)
  if scale.isSome: args.append("scale", scale.get)
  if scenechange.isSome: args.append("scenechange", scenechange.get)
  if planes.isSome: args.set("planes", planes.get)

  result = API.invoke(plug, "AverageFrames".cstring, args)
  API.freeMap(args)        

proc Hysteresis*(vsmap:ptr VSMap, clipb:ptr VSNodeRef; planes=none(seq[int])):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.misc")
  if plug == nil:
    raise newException(ValueError, "plugin \"misc\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq    # Convert the VSMap into a sequence
  if tmpSeq.len == 0:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clipa = tmpSeq[0].nodes[0]


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()
  args.append("clipa", clipa)
  args.append("clipb", clipb)
  if planes.isSome: args.set("planes", planes.get)

  result = API.invoke(plug, "Hysteresis".cstring, args)
  API.freeMap(args)        

proc SCDetect*(vsmap:ptr VSMap; threshold=none(float)):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.misc")
  if plug == nil:
    raise newException(ValueError, "plugin \"misc\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq    # Convert the VSMap into a sequence
  if tmpSeq.len == 0:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()
  args.append("clip", clip)
  if threshold.isSome: args.append("threshold", threshold.get)

  result = API.invoke(plug, "SCDetect".cstring, args)
  API.freeMap(args)        

