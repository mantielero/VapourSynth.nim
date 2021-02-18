proc Recognize*(vsmap:ptr VSMap; datapath= none(string); language= none(string); options= none(seq[string])):ptr VSMap =

  let plug = getPluginById("biz.srsfckn.ocr")
  assert( plug != nil, "plugin \"biz.srsfckn.ocr\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("clip") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()
  args.append("clip", clip)
  if datapath.isSome: args.append("datapath", datapath.get)
  if language.isSome: args.append("language", language.get)
  if options.isSome:
    for item in options.get:
      args.append("options", item)

  result = API.invoke(plug, "Recognize".cstring, args)
  API.freeMap(args)


