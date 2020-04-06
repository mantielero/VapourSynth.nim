proc CTMF*(vsmap:ptr VSMap; radius= none(int); memsize= none(int); opt= none(int); planes= none(seq[int])):ptr VSMap =

  let plug = getPluginById("com.holywu.ctmf")
  assert( plug != nil, "plugin \"com.holywu.ctmf\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("clip") != 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()
  args.append("clip", clip)
  if radius.isSome: args.append("radius", radius.get)
  if memsize.isSome: args.append("memsize", memsize.get)
  if opt.isSome: args.append("opt", opt.get)
  if planes.isSome: args.set("planes", planes.get)

  result = API.invoke(plug, "CTMF".cstring, args)
  API.freeMap(args)


