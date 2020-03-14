proc SangNom*(vsmap:ptr VSMap; order=none(int); dh=none(int); aa=none(seq[int]); planes=none(seq[int])):ptr VSMap =
  let plug = getPluginById("com.mio.sangnom")
  if plug == nil:
    raise newException(ValueError, "plugin \"sangnom\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq    # Convert the VSMap into a sequence
  if tmpSeq.len == 0:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()
  args.append("clip", clip)
  if order.isSome: args.append("order", order.get)
  if dh.isSome: args.append("dh", dh.get)
  if aa.isSome: args.set("aa", aa.get)
  if planes.isSome: args.set("planes", planes.get)

  return API.invoke(plug, "SangNom".cstring, args)        

