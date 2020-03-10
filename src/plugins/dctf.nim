proc DCTFilter(clip:ptr VSNodeRef, factors:seq[float]; planes=none(seq[int])):ptr VSMap =
  let plug = getPluginById("com.holywu.dctfilter")
  let args = createMap()
  propSetNode(args, "clip", clip, paAppend)
  propSetFloatArray(args, "factors", factors, paAppend)
  if planes.isSome:
    propSetIntArray(args, "planes", planes.get, paAppend)

  return API.invoke(plug, "DCTFilter".cstring, args)        

