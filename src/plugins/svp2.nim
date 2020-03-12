proc SmoothFps*(vsmap:ptr VSMap, super:ptr VSNodeRef, sdata:int, vectors:ptr VSNodeRef, vdata:int, opt:string; src=none(ptr VSNodeRef); fps=none(float)):ptr VSMap =
  let plug = getPluginById("com.svp-team.flow2")
  if plug == nil:
    raise newException(ValueError, "plugin \"svp2\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq
  if tmpSeq.len != 1:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  let args = createMap()
  propSetNode(args, "clip", clip, paAppend)
  propSetNode(args, "super", super, paAppend)
  propSetInt(args, "sdata", sdata, paAppend)
  propSetNode(args, "vectors", vectors, paAppend)
  propSetInt(args, "vdata", vdata, paAppend)
  propSetData(args, "opt", opt, paAppend)
  if src.isSome:
    propSetNode(args, "src", src.get, paAppend)
  if fps.isSome:
    propSetFloat(args, "fps", fps.get, paAppend)

  return API.invoke(plug, "SmoothFps".cstring, args)        

proc SmoothFps_NVOF*(vsmap:ptr VSMap, opt:string; nvof_src=none(ptr VSNodeRef); src=none(ptr VSNodeRef); fps=none(float)):ptr VSMap =
  let plug = getPluginById("com.svp-team.flow2")
  if plug == nil:
    raise newException(ValueError, "plugin \"svp2\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq
  if tmpSeq.len != 1:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  let args = createMap()
  propSetNode(args, "clip", clip, paAppend)
  propSetData(args, "opt", opt, paAppend)
  if nvof_src.isSome:
    propSetNode(args, "nvof_src", nvof_src.get, paAppend)
  if src.isSome:
    propSetNode(args, "src", src.get, paAppend)
  if fps.isSome:
    propSetFloat(args, "fps", fps.get, paAppend)

  return API.invoke(plug, "SmoothFps_NVOF".cstring, args)        

