proc Analyse*(vsmap:ptr VSMap, sdata:int, src:ptr VSNodeRef, opt:string):ptr VSMap =

  let plug = getPluginById("com.svp-team.flow1")
  assert( plug != nil, "plugin \"com.svp-team.flow1\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("clip") != 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()
  args.append("clip", clip)
  args.append("sdata", sdata)
  args.append("src", src)
  args.append("opt", opt)

  result = API.invoke(plug, "Analyse".cstring, args)
  API.freeMap(args)


proc Super*(vsmap:ptr VSMap, opt:string):ptr VSMap =

  let plug = getPluginById("com.svp-team.flow1")
  assert( plug != nil, "plugin \"com.svp-team.flow1\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("clip") != 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()
  args.append("clip", clip)
  args.append("opt", opt)

  result = API.invoke(plug, "Super".cstring, args)
  API.freeMap(args)


