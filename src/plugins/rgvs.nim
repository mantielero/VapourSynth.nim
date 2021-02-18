proc BackwardClense*(vsmap:ptr VSMap; planes= none(seq[int])):ptr VSMap =

  let plug = getPluginById("com.vapoursynth.removegrainvs")
  assert( plug != nil, "plugin \"com.vapoursynth.removegrainvs\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("clip") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()
  args.append("clip", clip)
  if planes.isSome: args.set("planes", planes.get)

  result = API.invoke(plug, "BackwardClense".cstring, args)
  API.freeMap(args)


proc Clense*(vsmap:ptr VSMap; previous= none(ptr VSNodeRef); next= none(ptr VSNodeRef); planes= none(seq[int])):ptr VSMap =

  let plug = getPluginById("com.vapoursynth.removegrainvs")
  assert( plug != nil, "plugin \"com.vapoursynth.removegrainvs\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("clip") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()
  args.append("clip", clip)
  if previous.isSome: args.append("previous", previous.get)
  if next.isSome: args.append("next", next.get)
  if planes.isSome: args.set("planes", planes.get)

  result = API.invoke(plug, "Clense".cstring, args)
  API.freeMap(args)


proc ForwardClense*(vsmap:ptr VSMap; planes= none(seq[int])):ptr VSMap =

  let plug = getPluginById("com.vapoursynth.removegrainvs")
  assert( plug != nil, "plugin \"com.vapoursynth.removegrainvs\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("clip") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()
  args.append("clip", clip)
  if planes.isSome: args.set("planes", planes.get)

  result = API.invoke(plug, "ForwardClense".cstring, args)
  API.freeMap(args)


proc RemoveGrain*(vsmap:ptr VSMap, mode:seq[int]):ptr VSMap =

  let plug = getPluginById("com.vapoursynth.removegrainvs")
  assert( plug != nil, "plugin \"com.vapoursynth.removegrainvs\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("clip") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()
  args.append("clip", clip)
  args.set("mode", mode)

  result = API.invoke(plug, "RemoveGrain".cstring, args)
  API.freeMap(args)


proc Repair*(vsmap:ptr VSMap, repairclip:ptr VSNodeRef, mode:seq[int]):ptr VSMap =

  let plug = getPluginById("com.vapoursynth.removegrainvs")
  assert( plug != nil, "plugin \"com.vapoursynth.removegrainvs\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("clip") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()
  args.append("clip", clip)
  args.append("repairclip", repairclip)
  args.set("mode", mode)

  result = API.invoke(plug, "Repair".cstring, args)
  API.freeMap(args)


proc VerticalCleaner*(vsmap:ptr VSMap, mode:seq[int]):ptr VSMap =

  let plug = getPluginById("com.vapoursynth.removegrainvs")
  assert( plug != nil, "plugin \"com.vapoursynth.removegrainvs\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("clip") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()
  args.append("clip", clip)
  args.set("mode", mode)

  result = API.invoke(plug, "VerticalCleaner".cstring, args)
  API.freeMap(args)


