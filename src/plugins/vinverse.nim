proc Vinverse*(vsmap:ptr VSMap; sstr= none(float); amnt= none(int); scl= none(float)):ptr VSMap =

  let plug = getPluginById("biz.srsfckn.Vinverse")
  assert( plug != nil, "plugin \"biz.srsfckn.Vinverse\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("clip") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()
  args.append("clip", clip)
  if sstr.isSome: args.append("sstr", sstr.get)
  if amnt.isSome: args.append("amnt", amnt.get)
  if scl.isSome: args.append("scl", scl.get)

  result = API.invoke(plug, "Vinverse".cstring, args)
  API.freeMap(args)


