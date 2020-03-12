proc SangNom*(vsmap:ptr VSMap; order=none(int); dh=none(int); aa=none(seq[int]); planes=none(seq[int])):ptr VSMap =
  let plug = getPluginById("com.mio.sangnom")
  if plug == nil:
    raise newException(ValueError, "plugin \"sangnom\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq
  if tmpSeq.len != 1:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  let args = createMap()
  propSetNode(args, "clip", clip, paAppend)
  if order.isSome:
    propSetInt(args, "order", order.get, paAppend)
  if dh.isSome:
    propSetInt(args, "dh", dh.get, paAppend)
  if aa.isSome:
    propSetIntArray(args, "aa", aa.get)
  if planes.isSome:
    propSetIntArray(args, "planes", planes.get)

  return API.invoke(plug, "SangNom".cstring, args)        

