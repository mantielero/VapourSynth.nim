proc BottomHat*(vsmap:ptr VSMap; size=none(int); shape=none(int)):ptr VSMap =
  let plug = getPluginById("biz.srsfckn.morpho")
  if plug == nil:
    raise newException(ValueError, "plugin \"morpho\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq
  if tmpSeq.len != 1:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  let args = createMap()
  propSetNode(args, "clip", clip, paAppend)
  if size.isSome:
    propSetInt(args, "size", size.get, paAppend)
  if shape.isSome:
    propSetInt(args, "shape", shape.get, paAppend)

  return API.invoke(plug, "BottomHat".cstring, args)        

proc Close*(vsmap:ptr VSMap; size=none(int); shape=none(int)):ptr VSMap =
  let plug = getPluginById("biz.srsfckn.morpho")
  if plug == nil:
    raise newException(ValueError, "plugin \"morpho\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq
  if tmpSeq.len != 1:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  let args = createMap()
  propSetNode(args, "clip", clip, paAppend)
  if size.isSome:
    propSetInt(args, "size", size.get, paAppend)
  if shape.isSome:
    propSetInt(args, "shape", shape.get, paAppend)

  return API.invoke(plug, "Close".cstring, args)        

proc Dilate*(vsmap:ptr VSMap; size=none(int); shape=none(int)):ptr VSMap =
  let plug = getPluginById("biz.srsfckn.morpho")
  if plug == nil:
    raise newException(ValueError, "plugin \"morpho\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq
  if tmpSeq.len != 1:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  let args = createMap()
  propSetNode(args, "clip", clip, paAppend)
  if size.isSome:
    propSetInt(args, "size", size.get, paAppend)
  if shape.isSome:
    propSetInt(args, "shape", shape.get, paAppend)

  return API.invoke(plug, "Dilate".cstring, args)        

proc Erode*(vsmap:ptr VSMap; size=none(int); shape=none(int)):ptr VSMap =
  let plug = getPluginById("biz.srsfckn.morpho")
  if plug == nil:
    raise newException(ValueError, "plugin \"morpho\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq
  if tmpSeq.len != 1:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  let args = createMap()
  propSetNode(args, "clip", clip, paAppend)
  if size.isSome:
    propSetInt(args, "size", size.get, paAppend)
  if shape.isSome:
    propSetInt(args, "shape", shape.get, paAppend)

  return API.invoke(plug, "Erode".cstring, args)        

proc Open*(vsmap:ptr VSMap; size=none(int); shape=none(int)):ptr VSMap =
  let plug = getPluginById("biz.srsfckn.morpho")
  if plug == nil:
    raise newException(ValueError, "plugin \"morpho\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq
  if tmpSeq.len != 1:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  let args = createMap()
  propSetNode(args, "clip", clip, paAppend)
  if size.isSome:
    propSetInt(args, "size", size.get, paAppend)
  if shape.isSome:
    propSetInt(args, "shape", shape.get, paAppend)

  return API.invoke(plug, "Open".cstring, args)        

proc TopHat*(vsmap:ptr VSMap; size=none(int); shape=none(int)):ptr VSMap =
  let plug = getPluginById("biz.srsfckn.morpho")
  if plug == nil:
    raise newException(ValueError, "plugin \"morpho\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq
  if tmpSeq.len != 1:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  let args = createMap()
  propSetNode(args, "clip", clip, paAppend)
  if size.isSome:
    propSetInt(args, "size", size.get, paAppend)
  if shape.isSome:
    propSetInt(args, "shape", shape.get, paAppend)

  return API.invoke(plug, "TopHat".cstring, args)        

