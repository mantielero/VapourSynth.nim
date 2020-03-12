proc SmoothST*(vsmap:ptr VSMap; temporal_threshold=none(int); spatial_threshold=none(int); planes=none(seq[int])):ptr VSMap =
  let plug = getPluginById("com.nodame.fluxsmooth")
  if plug == nil:
    raise newException(ValueError, "plugin \"flux\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq
  if tmpSeq.len != 1:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  let args = createMap()
  propSetNode(args, "clip", clip, paAppend)
  if temporal_threshold.isSome:
    propSetInt(args, "temporal_threshold", temporal_threshold.get, paAppend)
  if spatial_threshold.isSome:
    propSetInt(args, "spatial_threshold", spatial_threshold.get, paAppend)
  if planes.isSome:
    propSetIntArray(args, "planes", planes.get)

  return API.invoke(plug, "SmoothST".cstring, args)        

proc SmoothT*(vsmap:ptr VSMap; temporal_threshold=none(int); planes=none(seq[int])):ptr VSMap =
  let plug = getPluginById("com.nodame.fluxsmooth")
  if plug == nil:
    raise newException(ValueError, "plugin \"flux\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq
  if tmpSeq.len != 1:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  let args = createMap()
  propSetNode(args, "clip", clip, paAppend)
  if temporal_threshold.isSome:
    propSetInt(args, "temporal_threshold", temporal_threshold.get, paAppend)
  if planes.isSome:
    propSetIntArray(args, "planes", planes.get)

  return API.invoke(plug, "SmoothT".cstring, args)        

