proc ABlur*(vsmap:ptr VSMap; blur= none(int); `type`= none(int); planes= none(seq[int]); opt= none(int)):ptr VSMap =

  let plug = getPluginById("com.nodame.awarpsharp2")
  assert( plug != nil, "plugin \"com.nodame.awarpsharp2\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("clip") != 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()
  args.append("clip", clip)
  if blur.isSome: args.append("blur", blur.get)
  if `type`.isSome: args.append("type", `type`.get)
  if planes.isSome: args.set("planes", planes.get)
  if opt.isSome: args.append("opt", opt.get)

  result = API.invoke(plug, "ABlur".cstring, args)
  API.freeMap(args)


proc ASobel*(vsmap:ptr VSMap; thresh= none(int); planes= none(seq[int]); opt= none(int)):ptr VSMap =

  let plug = getPluginById("com.nodame.awarpsharp2")
  assert( plug != nil, "plugin \"com.nodame.awarpsharp2\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("clip") != 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()
  args.append("clip", clip)
  if thresh.isSome: args.append("thresh", thresh.get)
  if planes.isSome: args.set("planes", planes.get)
  if opt.isSome: args.append("opt", opt.get)

  result = API.invoke(plug, "ASobel".cstring, args)
  API.freeMap(args)


proc AWarp*(vsmap:ptr VSMap, mask:ptr VSNodeRef; depth= none(seq[int]); chroma= none(int); planes= none(seq[int]); opt= none(int); cplace= none(string)):ptr VSMap =

  let plug = getPluginById("com.nodame.awarpsharp2")
  assert( plug != nil, "plugin \"com.nodame.awarpsharp2\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("clip") != 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()
  args.append("clip", clip)
  args.append("mask", mask)
  if depth.isSome: args.set("depth", depth.get)
  if chroma.isSome: args.append("chroma", chroma.get)
  if planes.isSome: args.set("planes", planes.get)
  if opt.isSome: args.append("opt", opt.get)
  if cplace.isSome: args.append("cplace", cplace.get)

  result = API.invoke(plug, "AWarp".cstring, args)
  API.freeMap(args)


proc AWarpSharp2*(vsmap:ptr VSMap; thresh= none(int); blur= none(int); `type`= none(int); depth= none(seq[int]); chroma= none(int); planes= none(seq[int]); opt= none(int); cplace= none(string)):ptr VSMap =

  let plug = getPluginById("com.nodame.awarpsharp2")
  assert( plug != nil, "plugin \"com.nodame.awarpsharp2\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("clip") != 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()
  args.append("clip", clip)
  if thresh.isSome: args.append("thresh", thresh.get)
  if blur.isSome: args.append("blur", blur.get)
  if `type`.isSome: args.append("type", `type`.get)
  if depth.isSome: args.set("depth", depth.get)
  if chroma.isSome: args.append("chroma", chroma.get)
  if planes.isSome: args.set("planes", planes.get)
  if opt.isSome: args.append("opt", opt.get)
  if cplace.isSome: args.append("cplace", cplace.get)

  result = API.invoke(plug, "AWarpSharp2".cstring, args)
  API.freeMap(args)


