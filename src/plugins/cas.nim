proc CAS*(vsmap:ptr VSMap; sharpness= none(float); planes= none(seq[int]); opt= none(int)):ptr VSMap =

  let plug = getPluginById("com.holywu.cas")
  assert( plug != nil, "plugin \"com.holywu.cas\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("clip") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()
  args.append("clip", clip)
  if sharpness.isSome: args.append("sharpness", sharpness.get)
  if planes.isSome: args.set("planes", planes.get)
  if opt.isSome: args.append("opt", opt.get)

  result = API.invoke(plug, "CAS".cstring, args)
  API.freeMap(args)


