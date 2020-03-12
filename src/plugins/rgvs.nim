proc BackwardClense*(vsmap:ptr VSMap; planes=none(seq[int])):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.removegrainvs")
  if plug == nil:
    raise newException(ValueError, "plugin \"rgvs\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq
  if tmpSeq.len != 1:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  let args = createMap()
  propSetNode(args, "clip", clip, paAppend)
  if planes.isSome:
    propSetIntArray(args, "planes", planes.get)

  return API.invoke(plug, "BackwardClense".cstring, args)        

proc Clense*(vsmap:ptr VSMap; previous=none(ptr VSNodeRef); next=none(ptr VSNodeRef); planes=none(seq[int])):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.removegrainvs")
  if plug == nil:
    raise newException(ValueError, "plugin \"rgvs\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq
  if tmpSeq.len != 1:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  let args = createMap()
  propSetNode(args, "clip", clip, paAppend)
  if previous.isSome:
    propSetNode(args, "previous", previous.get, paAppend)
  if next.isSome:
    propSetNode(args, "next", next.get, paAppend)
  if planes.isSome:
    propSetIntArray(args, "planes", planes.get)

  return API.invoke(plug, "Clense".cstring, args)        

proc ForwardClense*(vsmap:ptr VSMap; planes=none(seq[int])):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.removegrainvs")
  if plug == nil:
    raise newException(ValueError, "plugin \"rgvs\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq
  if tmpSeq.len != 1:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  let args = createMap()
  propSetNode(args, "clip", clip, paAppend)
  if planes.isSome:
    propSetIntArray(args, "planes", planes.get)

  return API.invoke(plug, "ForwardClense".cstring, args)        

proc RemoveGrain*(vsmap:ptr VSMap, mode:seq[int]):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.removegrainvs")
  if plug == nil:
    raise newException(ValueError, "plugin \"rgvs\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq
  if tmpSeq.len != 1:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  let args = createMap()
  propSetNode(args, "clip", clip, paAppend)
  propSetIntArray(args, "mode", mode)

  return API.invoke(plug, "RemoveGrain".cstring, args)        

proc Repair*(vsmap:ptr VSMap, repairclip:ptr VSNodeRef, mode:seq[int]):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.removegrainvs")
  if plug == nil:
    raise newException(ValueError, "plugin \"rgvs\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq
  if tmpSeq.len != 1:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  let args = createMap()
  propSetNode(args, "clip", clip, paAppend)
  propSetNode(args, "repairclip", repairclip, paAppend)
  propSetIntArray(args, "mode", mode)

  return API.invoke(plug, "Repair".cstring, args)        

proc VerticalCleaner*(vsmap:ptr VSMap, mode:seq[int]):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.removegrainvs")
  if plug == nil:
    raise newException(ValueError, "plugin \"rgvs\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq
  if tmpSeq.len != 1:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  let args = createMap()
  propSetNode(args, "clip", clip, paAppend)
  propSetIntArray(args, "mode", mode)

  return API.invoke(plug, "VerticalCleaner".cstring, args)        

