proc ClipInfo*(vsmap:ptr VSMap; alignment=none(int)):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.text")
  if plug == nil:
    raise newException(ValueError, "plugin \"text\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq    # Convert the VSMap into a sequence
  if tmpSeq.len == 0:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()
  args.append("clip", clip)
  if alignment.isSome: args.append("alignment", alignment.get)

  result = API.invoke(plug, "ClipInfo".cstring, args)
  API.freeMap(args)        

proc CoreInfo*(vsmap:ptr VSMap; alignment=none(int)):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.text")
  if plug == nil:
    raise newException(ValueError, "plugin \"text\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq    # Convert the VSMap into a sequence
  if tmpSeq.len == 0:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = some(tmpSeq[0].nodes[0])


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()
  if clip.isSome: args.append("clip", clip.get)
  if alignment.isSome: args.append("alignment", alignment.get)

  result = API.invoke(plug, "CoreInfo".cstring, args)
  API.freeMap(args)        

proc FrameNum*(vsmap:ptr VSMap; alignment=none(int)):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.text")
  if plug == nil:
    raise newException(ValueError, "plugin \"text\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq    # Convert the VSMap into a sequence
  if tmpSeq.len == 0:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()
  args.append("clip", clip)
  if alignment.isSome: args.append("alignment", alignment.get)

  result = API.invoke(plug, "FrameNum".cstring, args)
  API.freeMap(args)        

proc FrameProps*(vsmap:ptr VSMap; props=none(seq[string]); alignment=none(int)):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.text")
  if plug == nil:
    raise newException(ValueError, "plugin \"text\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq    # Convert the VSMap into a sequence
  if tmpSeq.len == 0:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()
  args.append("clip", clip)
  if props.isSome:
    for item in props.get:
      args.append("props", item)
  if alignment.isSome: args.append("alignment", alignment.get)

  result = API.invoke(plug, "FrameProps".cstring, args)
  API.freeMap(args)        

proc Text*(vsmap:ptr VSMap, text:string; alignment=none(int)):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.text")
  if plug == nil:
    raise newException(ValueError, "plugin \"text\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq    # Convert the VSMap into a sequence
  if tmpSeq.len == 0:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()
  args.append("clip", clip)
  args.append("text", text)
  if alignment.isSome: args.append("alignment", alignment.get)

  result = API.invoke(plug, "Text".cstring, args)
  API.freeMap(args)        

