proc BackwardClense(clip:ptr VSNodeRef; planes=none(seq[int])):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.removegrainvs")
  let args = createMap()
  propSetNode(args, "clip", clip, paAppend)
  if planes.isSome:
    propSetIntArray(args, "planes", planes.get, paAppend)

  return API.invoke(plug, "BackwardClense".cstring, args)        

proc Clense(clip:ptr VSNodeRef; previous=none(ptr VSNodeRef); next=none(ptr VSNodeRef); planes=none(seq[int])):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.removegrainvs")
  let args = createMap()
  propSetNode(args, "clip", clip, paAppend)
  if previous.isSome:
    propSetNode(args, "previous", previous.get, paAppend)
  if next.isSome:
    propSetNode(args, "next", next.get, paAppend)
  if planes.isSome:
    propSetIntArray(args, "planes", planes.get, paAppend)

  return API.invoke(plug, "Clense".cstring, args)        

proc ForwardClense(clip:ptr VSNodeRef; planes=none(seq[int])):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.removegrainvs")
  let args = createMap()
  propSetNode(args, "clip", clip, paAppend)
  if planes.isSome:
    propSetIntArray(args, "planes", planes.get, paAppend)

  return API.invoke(plug, "ForwardClense".cstring, args)        

proc RemoveGrain(clip:ptr VSNodeRef, mode:seq[int]):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.removegrainvs")
  let args = createMap()
  propSetNode(args, "clip", clip, paAppend)
  propSetIntArray(args, "mode", mode, paAppend)

  return API.invoke(plug, "RemoveGrain".cstring, args)        

proc Repair(clip:ptr VSNodeRef, repairclip:ptr VSNodeRef, mode:seq[int]):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.removegrainvs")
  let args = createMap()
  propSetNode(args, "clip", clip, paAppend)
  propSetNode(args, "repairclip", repairclip, paAppend)
  propSetIntArray(args, "mode", mode, paAppend)

  return API.invoke(plug, "Repair".cstring, args)        

proc VerticalCleaner(clip:ptr VSNodeRef, mode:seq[int]):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.removegrainvs")
  let args = createMap()
  propSetNode(args, "clip", clip, paAppend)
  propSetIntArray(args, "mode", mode, paAppend)

  return API.invoke(plug, "VerticalCleaner".cstring, args)        

