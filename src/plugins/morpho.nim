proc BottomHat*(vsmap:ptr VSMap; size= none(int); shape= none(int)):ptr VSMap =

  let plug = getPluginById("biz.srsfckn.morpho")
  assert( plug != nil, "plugin \"biz.srsfckn.morpho\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("clip") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()
  args.append("clip", clip)
  if size.isSome: args.append("size", size.get)
  if shape.isSome: args.append("shape", shape.get)

  result = API.invoke(plug, "BottomHat".cstring, args)
  API.freeMap(args)


proc Close*(vsmap:ptr VSMap; size= none(int); shape= none(int)):ptr VSMap =

  let plug = getPluginById("biz.srsfckn.morpho")
  assert( plug != nil, "plugin \"biz.srsfckn.morpho\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("clip") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()
  args.append("clip", clip)
  if size.isSome: args.append("size", size.get)
  if shape.isSome: args.append("shape", shape.get)

  result = API.invoke(plug, "Close".cstring, args)
  API.freeMap(args)


proc Dilate*(vsmap:ptr VSMap; size= none(int); shape= none(int)):ptr VSMap =

  let plug = getPluginById("biz.srsfckn.morpho")
  assert( plug != nil, "plugin \"biz.srsfckn.morpho\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("clip") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()
  args.append("clip", clip)
  if size.isSome: args.append("size", size.get)
  if shape.isSome: args.append("shape", shape.get)

  result = API.invoke(plug, "Dilate".cstring, args)
  API.freeMap(args)


proc Erode*(vsmap:ptr VSMap; size= none(int); shape= none(int)):ptr VSMap =

  let plug = getPluginById("biz.srsfckn.morpho")
  assert( plug != nil, "plugin \"biz.srsfckn.morpho\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("clip") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()
  args.append("clip", clip)
  if size.isSome: args.append("size", size.get)
  if shape.isSome: args.append("shape", shape.get)

  result = API.invoke(plug, "Erode".cstring, args)
  API.freeMap(args)


proc Open*(vsmap:ptr VSMap; size= none(int); shape= none(int)):ptr VSMap =

  let plug = getPluginById("biz.srsfckn.morpho")
  assert( plug != nil, "plugin \"biz.srsfckn.morpho\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("clip") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()
  args.append("clip", clip)
  if size.isSome: args.append("size", size.get)
  if shape.isSome: args.append("shape", shape.get)

  result = API.invoke(plug, "Open".cstring, args)
  API.freeMap(args)


proc TopHat*(vsmap:ptr VSMap; size= none(int); shape= none(int)):ptr VSMap =

  let plug = getPluginById("biz.srsfckn.morpho")
  assert( plug != nil, "plugin \"biz.srsfckn.morpho\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("clip") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()
  args.append("clip", clip)
  if size.isSome: args.append("size", size.get)
  if shape.isSome: args.append("shape", shape.get)

  result = API.invoke(plug, "TopHat".cstring, args)
  API.freeMap(args)


