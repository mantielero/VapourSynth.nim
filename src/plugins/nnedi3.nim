proc nnedi3*(vsmap:ptr VSMap, field:int; dh= none(int); planes= none(seq[int]); nsize= none(int); nns= none(int); qual= none(int); etype= none(int); pscrn= none(int); opt= none(int); int16_prescreener= none(int); int16_predictor= none(int); exp= none(int); show_mask= none(int); combed_only= none(int)):ptr VSMap =

  let plug = getPluginById("com.deinterlace.nnedi3")
  assert( plug != nil, "plugin \"com.deinterlace.nnedi3\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("clip") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()
  args.append("clip", clip)
  args.append("field", field)
  if dh.isSome: args.append("dh", dh.get)
  if planes.isSome: args.set("planes", planes.get)
  if nsize.isSome: args.append("nsize", nsize.get)
  if nns.isSome: args.append("nns", nns.get)
  if qual.isSome: args.append("qual", qual.get)
  if etype.isSome: args.append("etype", etype.get)
  if pscrn.isSome: args.append("pscrn", pscrn.get)
  if opt.isSome: args.append("opt", opt.get)
  if int16_prescreener.isSome: args.append("int16_prescreener", int16_prescreener.get)
  if int16_predictor.isSome: args.append("int16_predictor", int16_predictor.get)
  if exp.isSome: args.append("exp", exp.get)
  if show_mask.isSome: args.append("show_mask", show_mask.get)
  if combed_only.isSome: args.append("combed_only", combed_only.get)

  result = API.invoke(plug, "nnedi3".cstring, args)
  API.freeMap(args)


