proc BackwardClense*(vsmap:ptr VSMap; planes=none(seq[int])):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.removegrainvs")
  if plug == nil:
    raise newException(ValueError, "plugin \"rgvs\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq    # Convert the VSMap into a sequence
  if tmpSeq.len == 0:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()
  args.append("clip", clip)
  if planes.isSome: args.set("planes", planes.get)

  return API.invoke(plug, "BackwardClense".cstring, args)        

proc Clense*(vsmap:ptr VSMap; previous=none(ptr VSNodeRef); next=none(ptr VSNodeRef); planes=none(seq[int])):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.removegrainvs")
  if plug == nil:
    raise newException(ValueError, "plugin \"rgvs\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq    # Convert the VSMap into a sequence
  if tmpSeq.len == 0:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()
  args.append("clip", clip)
  if previous.isSome: args.append("previous", previous.get)
  if next.isSome: args.append("next", next.get)
  if planes.isSome: args.set("planes", planes.get)

  return API.invoke(plug, "Clense".cstring, args)        

proc ForwardClense*(vsmap:ptr VSMap; planes=none(seq[int])):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.removegrainvs")
  if plug == nil:
    raise newException(ValueError, "plugin \"rgvs\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq    # Convert the VSMap into a sequence
  if tmpSeq.len == 0:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()
  args.append("clip", clip)
  if planes.isSome: args.set("planes", planes.get)

  return API.invoke(plug, "ForwardClense".cstring, args)        

proc RemoveGrain*(vsmap:ptr VSMap, mode:seq[int]):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.removegrainvs")
  if plug == nil:
    raise newException(ValueError, "plugin \"rgvs\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq    # Convert the VSMap into a sequence
  if tmpSeq.len == 0:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()
  args.append("clip", clip)
  args.set("mode", mode)

  return API.invoke(plug, "RemoveGrain".cstring, args)        

proc Repair*(vsmap:ptr VSMap, repairclip:ptr VSNodeRef, mode:seq[int]):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.removegrainvs")
  if plug == nil:
    raise newException(ValueError, "plugin \"rgvs\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq    # Convert the VSMap into a sequence
  if tmpSeq.len == 0:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()
  args.append("clip", clip)
  args.append("repairclip", repairclip)
  args.set("mode", mode)

  return API.invoke(plug, "Repair".cstring, args)        

proc VerticalCleaner*(vsmap:ptr VSMap, mode:seq[int]):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.removegrainvs")
  if plug == nil:
    raise newException(ValueError, "plugin \"rgvs\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq    # Convert the VSMap into a sequence
  if tmpSeq.len == 0:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()
  args.append("clip", clip)
  args.set("mode", mode)

  return API.invoke(plug, "VerticalCleaner".cstring, args)        

