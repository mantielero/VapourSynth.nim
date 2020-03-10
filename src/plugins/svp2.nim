proc SmoothFps(clip:ptr VSNodeRef, super:ptr VSNodeRef, sdata:int, vectors:ptr VSNodeRef, vdata:int, opt:string; src=none(ptr VSNodeRef); fps=none(float)):ptr VSMap =
  let plug = getPluginById("com.svp-team.flow2")
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

proc SmoothFps_NVOF(clip:ptr VSNodeRef, opt:string; nvof_src=none(ptr VSNodeRef); src=none(ptr VSNodeRef); fps=none(float)):ptr VSMap =
  let plug = getPluginById("com.svp-team.flow2")
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

