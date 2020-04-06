proc DCTFilter*(vsmap:ptr VSMap, factors:seq[float]; planes= none(seq[int])):ptr VSMap =

  let plug = getPluginById("com.holywu.dctfilter")
  assert( plug != nil, "plugin \"com.holywu.dctfilter\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("clip") != 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()
  args.append("clip", clip)
  args.set("factors", factors)
  if planes.isSome: args.set("planes", planes.get)

  result = API.invoke(plug, "DCTFilter".cstring, args)
  API.freeMap(args)


