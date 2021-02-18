proc SmoothFps*(vsmap:ptr VSMap, super:ptr VSNodeRef, sdata:int, vectors:ptr VSNodeRef, vdata:int, opt:string; src= none(ptr VSNodeRef); fps= none(float)):ptr VSMap =

  let plug = getPluginById("com.svp-team.flow2")
  assert( plug != nil, "plugin \"com.svp-team.flow2\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("clip") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()
  args.append("clip", clip)
  args.append("super", super)
  args.append("sdata", sdata)
  args.append("vectors", vectors)
  args.append("vdata", vdata)
  args.append("opt", opt)
  if src.isSome: args.append("src", src.get)
  if fps.isSome: args.append("fps", fps.get)

  result = API.invoke(plug, "SmoothFps".cstring, args)
  API.freeMap(args)


proc SmoothFps_NVOF*(vsmap:ptr VSMap, opt:string; nvof_src= none(ptr VSNodeRef); src= none(ptr VSNodeRef); fps= none(float)):ptr VSMap =

  let plug = getPluginById("com.svp-team.flow2")
  assert( plug != nil, "plugin \"com.svp-team.flow2\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("clip") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()
  args.append("clip", clip)
  args.append("opt", opt)
  if nvof_src.isSome: args.append("nvof_src", nvof_src.get)
  if src.isSome: args.append("src", src.get)
  if fps.isSome: args.append("fps", fps.get)

  result = API.invoke(plug, "SmoothFps_NVOF".cstring, args)
  API.freeMap(args)


