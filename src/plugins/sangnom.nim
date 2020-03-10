proc SangNom(clip:ptr VSNodeRef; order=none(int); dh=none(int); aa=none(seq[int]); planes=none(seq[int])):ptr VSMap =
  let plug = getPluginById("com.mio.sangnom")
  let args = createMap()
  propSetNode(args, "clip", clip, paAppend)
  if order.isSome:
    propSetInt(args, "order", order.get, paAppend)
  if dh.isSome:
    propSetInt(args, "dh", dh.get, paAppend)
  if aa.isSome:
    propSetIntArray(args, "aa", aa.get, paAppend)
  if planes.isSome:
    propSetIntArray(args, "planes", planes.get, paAppend)

  return API.invoke(plug, "SangNom".cstring, args)        

