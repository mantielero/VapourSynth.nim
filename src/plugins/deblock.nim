proc Deblock*(vsmap:ptr VSMap; quant= none(int); aoffset= none(int); boffset= none(int); planes= none(seq[int])):ptr VSMap =

  let plug = getPluginById("com.holywu.deblock")
  assert( plug != nil, "plugin \"com.holywu.deblock\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("clip") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()
  args.append("clip", clip)
  if quant.isSome: args.append("quant", quant.get)
  if aoffset.isSome: args.append("aoffset", aoffset.get)
  if boffset.isSome: args.append("boffset", boffset.get)
  if planes.isSome: args.set("planes", planes.get)

  result = API.invoke(plug, "Deblock".cstring, args)
  API.freeMap(args)


