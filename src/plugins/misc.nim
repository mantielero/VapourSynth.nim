proc AverageFrames*(vsmap:ptr VSMap, weights:seq[float]; scale= none(float); scenechange= none(int); planes= none(seq[int])):ptr VSMap =

  let plug = getPluginById("com.vapoursynth.misc")
  assert( plug != nil, "plugin \"com.vapoursynth.misc\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("clips") >= 1, "the vsmap should contain a seq with nodes")
  var clips = getFirstNodes(vsmap)


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


proc Hysteresis*(vsmap:ptr VSMap, clipb:ptr VSNodeRef; planes= none(seq[int])):ptr VSMap =

  let plug = getPluginById("com.vapoursynth.misc")
  assert( plug != nil, "plugin \"com.vapoursynth.misc\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("clip") != 1, "the vsmap should contain one node")
  var clipa = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()
  args.append("clipa", clipa)
  args.append("clipb", clipb)
  if planes.isSome: args.set("planes", planes.get)

  result = API.invoke(plug, "Hysteresis".cstring, args)
  API.freeMap(args)


proc SCDetect*(vsmap:ptr VSMap; threshold= none(float)):ptr VSMap =

  let plug = getPluginById("com.vapoursynth.misc")
  assert( plug != nil, "plugin \"com.vapoursynth.misc\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("clip") != 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()
  args.append("clip", clip)
  if threshold.isSome: args.append("threshold", threshold.get)

  result = API.invoke(plug, "SCDetect".cstring, args)
  API.freeMap(args)


