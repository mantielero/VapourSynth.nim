proc BottomHat*(vsmap:ptr VSMap; size=none(int); shape=none(int)):ptr VSMap =
  let plug = getPluginById("biz.srsfckn.morpho")
  if plug == nil:
    raise newException(ValueError, "plugin \"morpho\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq    # Convert the VSMap into a sequence
  if tmpSeq.len == 0:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()
  args.append("clip", clip)
  if size.isSome: args.append("size", size.get)
  if shape.isSome: args.append("shape", shape.get)

  return API.invoke(plug, "BottomHat".cstring, args)        

proc Close*(vsmap:ptr VSMap; size=none(int); shape=none(int)):ptr VSMap =
  let plug = getPluginById("biz.srsfckn.morpho")
  if plug == nil:
    raise newException(ValueError, "plugin \"morpho\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq    # Convert the VSMap into a sequence
  if tmpSeq.len == 0:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()
  args.append("clip", clip)
  if size.isSome: args.append("size", size.get)
  if shape.isSome: args.append("shape", shape.get)

  return API.invoke(plug, "Close".cstring, args)        

proc Dilate*(vsmap:ptr VSMap; size=none(int); shape=none(int)):ptr VSMap =
  let plug = getPluginById("biz.srsfckn.morpho")
  if plug == nil:
    raise newException(ValueError, "plugin \"morpho\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq    # Convert the VSMap into a sequence
  if tmpSeq.len == 0:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()
  args.append("clip", clip)
  if size.isSome: args.append("size", size.get)
  if shape.isSome: args.append("shape", shape.get)

  return API.invoke(plug, "Dilate".cstring, args)        

proc Erode*(vsmap:ptr VSMap; size=none(int); shape=none(int)):ptr VSMap =
  let plug = getPluginById("biz.srsfckn.morpho")
  if plug == nil:
    raise newException(ValueError, "plugin \"morpho\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq    # Convert the VSMap into a sequence
  if tmpSeq.len == 0:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()
  args.append("clip", clip)
  if size.isSome: args.append("size", size.get)
  if shape.isSome: args.append("shape", shape.get)

  return API.invoke(plug, "Erode".cstring, args)        

proc Open*(vsmap:ptr VSMap; size=none(int); shape=none(int)):ptr VSMap =
  let plug = getPluginById("biz.srsfckn.morpho")
  if plug == nil:
    raise newException(ValueError, "plugin \"morpho\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq    # Convert the VSMap into a sequence
  if tmpSeq.len == 0:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()
  args.append("clip", clip)
  if size.isSome: args.append("size", size.get)
  if shape.isSome: args.append("shape", shape.get)

  return API.invoke(plug, "Open".cstring, args)        

proc TopHat*(vsmap:ptr VSMap; size=none(int); shape=none(int)):ptr VSMap =
  let plug = getPluginById("biz.srsfckn.morpho")
  if plug == nil:
    raise newException(ValueError, "plugin \"morpho\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq    # Convert the VSMap into a sequence
  if tmpSeq.len == 0:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()
  args.append("clip", clip)
  if size.isSome: args.append("size", size.get)
  if shape.isSome: args.append("shape", shape.get)

  return API.invoke(plug, "TopHat".cstring, args)        

