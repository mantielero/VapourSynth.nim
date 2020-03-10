proc SmoothST(clip:ptr VSNodeRef; temporal_threshold=none(int); spatial_threshold=none(int); planes=none(seq[int])):ptr VSMap =
  let plug = getPluginById("com.nodame.fluxsmooth")
  let args = createMap()
  propSetNode(args, "clip", clip, paAppend)
  if temporal_threshold.isSome:
    propSetInt(args, "temporal_threshold", temporal_threshold.get, paAppend)
  if spatial_threshold.isSome:
    propSetInt(args, "spatial_threshold", spatial_threshold.get, paAppend)
  if planes.isSome:
    propSetIntArray(args, "planes", planes.get, paAppend)

  return API.invoke(plug, "SmoothST".cstring, args)        

proc SmoothT(clip:ptr VSNodeRef; temporal_threshold=none(int); planes=none(seq[int])):ptr VSMap =
  let plug = getPluginById("com.nodame.fluxsmooth")
  let args = createMap()
  propSetNode(args, "clip", clip, paAppend)
  if temporal_threshold.isSome:
    propSetInt(args, "temporal_threshold", temporal_threshold.get, paAppend)
  if planes.isSome:
    propSetIntArray(args, "planes", planes.get, paAppend)

  return API.invoke(plug, "SmoothT".cstring, args)        

