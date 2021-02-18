proc SangNom*(vsmap:ptr VSMap; order= none(int); dh= none(int); aa= none(seq[int]); planes= none(seq[int])):ptr VSMap =

  let plug = getPluginById("com.mio.sangnom")
  assert( plug != nil, "plugin \"com.mio.sangnom\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("clip") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()
  args.append("clip", clip)
  if order.isSome: args.append("order", order.get)
  if dh.isSome: args.append("dh", dh.get)
  if aa.isSome: args.set("aa", aa.get)
  if planes.isSome: args.set("planes", planes.get)

  result = API.invoke(plug, "SangNom".cstring, args)
  API.freeMap(args)


