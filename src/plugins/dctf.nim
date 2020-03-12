proc DCTFilter*(vsmap:ptr VSMap, factors:seq[float]; planes=none(seq[int])):ptr VSMap =
  let plug = getPluginById("com.holywu.dctfilter")
  if plug == nil:
    raise newException(ValueError, "plugin \"dctf\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq
  if tmpSeq.len != 1:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  let args = createMap()
  propSetNode(args, "clip", clip, paAppend)
  propSetFloatArray(args, "factors", factors)
  if planes.isSome:
    propSetIntArray(args, "planes", planes.get)

  return API.invoke(plug, "DCTFilter".cstring, args)        

