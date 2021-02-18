proc ImageFile*(vsmap:ptr VSMap, file:string; id= none(int); palette= none(seq[int]); gray= none(int); info= none(int); flatten= none(int); blend= none(int); matrix= none(int); matrix_s= none(string); transfer= none(int); transfer_s= none(string); primaries= none(int); primaries_s= none(string)):ptr VSMap =

  let plug = getPluginById("biz.srsfckn.subtext")
  assert( plug != nil, "plugin \"biz.srsfckn.subtext\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("clip") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()
  args.append("clip", clip)
  args.append("file", file)
  if id.isSome: args.append("id", id.get)
  if palette.isSome: args.set("palette", palette.get)
  if gray.isSome: args.append("gray", gray.get)
  if info.isSome: args.append("info", info.get)
  if flatten.isSome: args.append("flatten", flatten.get)
  if blend.isSome: args.append("blend", blend.get)
  if matrix.isSome: args.append("matrix", matrix.get)
  if matrix_s.isSome: args.append("matrix_s", matrix_s.get)
  if transfer.isSome: args.append("transfer", transfer.get)
  if transfer_s.isSome: args.append("transfer_s", transfer_s.get)
  if primaries.isSome: args.append("primaries", primaries.get)
  if primaries_s.isSome: args.append("primaries_s", primaries_s.get)

  result = API.invoke(plug, "ImageFile".cstring, args)
  API.freeMap(args)


proc Subtitle*(vsmap:ptr VSMap, text:string; start= none(int); `end`= none(int); debuglevel= none(int); fontdir= none(string); linespacing= none(float); margins= none(seq[int]); sar= none(float); style= none(string); blend= none(int); matrix= none(int); matrix_s= none(string); transfer= none(int); transfer_s= none(string); primaries= none(int); primaries_s= none(string)):ptr VSMap =

  let plug = getPluginById("biz.srsfckn.subtext")
  assert( plug != nil, "plugin \"biz.srsfckn.subtext\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("clip") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()
  args.append("clip", clip)
  args.append("text", text)
  if start.isSome: args.append("start", start.get)
  if `end`.isSome: args.append("end", `end`.get)
  if debuglevel.isSome: args.append("debuglevel", debuglevel.get)
  if fontdir.isSome: args.append("fontdir", fontdir.get)
  if linespacing.isSome: args.append("linespacing", linespacing.get)
  if margins.isSome: args.set("margins", margins.get)
  if sar.isSome: args.append("sar", sar.get)
  if style.isSome: args.append("style", style.get)
  if blend.isSome: args.append("blend", blend.get)
  if matrix.isSome: args.append("matrix", matrix.get)
  if matrix_s.isSome: args.append("matrix_s", matrix_s.get)
  if transfer.isSome: args.append("transfer", transfer.get)
  if transfer_s.isSome: args.append("transfer_s", transfer_s.get)
  if primaries.isSome: args.append("primaries", primaries.get)
  if primaries_s.isSome: args.append("primaries_s", primaries_s.get)

  result = API.invoke(plug, "Subtitle".cstring, args)
  API.freeMap(args)


proc TextFile*(vsmap:ptr VSMap, file:string; charset= none(string); scale= none(float); debuglevel= none(int); fontdir= none(string); linespacing= none(float); margins= none(seq[int]); sar= none(float); style= none(string); blend= none(int); matrix= none(int); matrix_s= none(string); transfer= none(int); transfer_s= none(string); primaries= none(int); primaries_s= none(string)):ptr VSMap =

  let plug = getPluginById("biz.srsfckn.subtext")
  assert( plug != nil, "plugin \"biz.srsfckn.subtext\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("clip") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()
  args.append("clip", clip)
  args.append("file", file)
  if charset.isSome: args.append("charset", charset.get)
  if scale.isSome: args.append("scale", scale.get)
  if debuglevel.isSome: args.append("debuglevel", debuglevel.get)
  if fontdir.isSome: args.append("fontdir", fontdir.get)
  if linespacing.isSome: args.append("linespacing", linespacing.get)
  if margins.isSome: args.set("margins", margins.get)
  if sar.isSome: args.append("sar", sar.get)
  if style.isSome: args.append("style", style.get)
  if blend.isSome: args.append("blend", blend.get)
  if matrix.isSome: args.append("matrix", matrix.get)
  if matrix_s.isSome: args.append("matrix_s", matrix_s.get)
  if transfer.isSome: args.append("transfer", transfer.get)
  if transfer_s.isSome: args.append("transfer_s", transfer_s.get)
  if primaries.isSome: args.append("primaries", primaries.get)
  if primaries_s.isSome: args.append("primaries_s", primaries_s.get)

  result = API.invoke(plug, "TextFile".cstring, args)
  API.freeMap(args)


