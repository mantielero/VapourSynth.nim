proc BottomHat(clip:ptr VSNodeRef; size=none(int); shape=none(int)):ptr VSMap =
  let plug = getPluginById("biz.srsfckn.morpho")
  let args = createMap()
  propSetNode(args, "clip", clip, paAppend)
  if size.isSome:
    propSetInt(args, "size", size.get, paAppend)
  if shape.isSome:
    propSetInt(args, "shape", shape.get, paAppend)

  return API.invoke(plug, "BottomHat".cstring, args)        

proc Close(clip:ptr VSNodeRef; size=none(int); shape=none(int)):ptr VSMap =
  let plug = getPluginById("biz.srsfckn.morpho")
  let args = createMap()
  propSetNode(args, "clip", clip, paAppend)
  if size.isSome:
    propSetInt(args, "size", size.get, paAppend)
  if shape.isSome:
    propSetInt(args, "shape", shape.get, paAppend)

  return API.invoke(plug, "Close".cstring, args)        

proc Dilate(clip:ptr VSNodeRef; size=none(int); shape=none(int)):ptr VSMap =
  let plug = getPluginById("biz.srsfckn.morpho")
  let args = createMap()
  propSetNode(args, "clip", clip, paAppend)
  if size.isSome:
    propSetInt(args, "size", size.get, paAppend)
  if shape.isSome:
    propSetInt(args, "shape", shape.get, paAppend)

  return API.invoke(plug, "Dilate".cstring, args)        

proc Erode(clip:ptr VSNodeRef; size=none(int); shape=none(int)):ptr VSMap =
  let plug = getPluginById("biz.srsfckn.morpho")
  let args = createMap()
  propSetNode(args, "clip", clip, paAppend)
  if size.isSome:
    propSetInt(args, "size", size.get, paAppend)
  if shape.isSome:
    propSetInt(args, "shape", shape.get, paAppend)

  return API.invoke(plug, "Erode".cstring, args)        

proc Open(clip:ptr VSNodeRef; size=none(int); shape=none(int)):ptr VSMap =
  let plug = getPluginById("biz.srsfckn.morpho")
  let args = createMap()
  propSetNode(args, "clip", clip, paAppend)
  if size.isSome:
    propSetInt(args, "size", size.get, paAppend)
  if shape.isSome:
    propSetInt(args, "shape", shape.get, paAppend)

  return API.invoke(plug, "Open".cstring, args)        

proc TopHat(clip:ptr VSNodeRef; size=none(int); shape=none(int)):ptr VSMap =
  let plug = getPluginById("biz.srsfckn.morpho")
  let args = createMap()
  propSetNode(args, "clip", clip, paAppend)
  if size.isSome:
    propSetInt(args, "size", size.get, paAppend)
  if shape.isSome:
    propSetInt(args, "shape", shape.get, paAppend)

  return API.invoke(plug, "TopHat".cstring, args)        

