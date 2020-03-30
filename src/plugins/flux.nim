proc SmoothST*(vsmap:ptr VSMap; temporal_threshold=none(int); spatial_threshold=none(int); planes=none(seq[int])):ptr VSMap =
  let plug = getPluginById("com.nodame.fluxsmooth")
  if plug == nil:
    raise newException(ValueError, "plugin \"flux\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq    # Convert the VSMap into a sequence
  if tmpSeq.len == 0:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()
  args.append("clip", clip)
  if temporal_threshold.isSome: args.append("temporal_threshold", temporal_threshold.get)
  if spatial_threshold.isSome: args.append("spatial_threshold", spatial_threshold.get)
  if planes.isSome: args.set("planes", planes.get)

  result = API.invoke(plug, "SmoothST".cstring, args)
  API.freeMap(args)        

proc SmoothT*(vsmap:ptr VSMap; temporal_threshold=none(int); planes=none(seq[int])):ptr VSMap =
  let plug = getPluginById("com.nodame.fluxsmooth")
  if plug == nil:
    raise newException(ValueError, "plugin \"flux\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq    # Convert the VSMap into a sequence
  if tmpSeq.len == 0:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()
  args.append("clip", clip)
  if temporal_threshold.isSome: args.append("temporal_threshold", temporal_threshold.get)
  if planes.isSome: args.set("planes", planes.get)

  result = API.invoke(plug, "SmoothT".cstring, args)
  API.freeMap(args)        

