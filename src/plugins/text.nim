proc ClipInfo*(vsmap:ptr VSMap; alignment=none(int)):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.text")
  if plug == nil:
    raise newException(ValueError, "plugin \"text\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq
  if tmpSeq.len != 1:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  let args = createMap()
  propSetNode(args, "clip", clip, paAppend)
  if alignment.isSome:
    propSetInt(args, "alignment", alignment.get, paAppend)

  return API.invoke(plug, "ClipInfo".cstring, args)        

proc CoreInfo*(vsmap:ptr VSMap; alignment=none(int)):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.text")
  if plug == nil:
    raise newException(ValueError, "plugin \"text\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq
  if tmpSeq.len != 1:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = some(tmpSeq[0].nodes[0])


  let args = createMap()
  if clip.isSome:
    propSetNode(args, "clip", clip.get, paAppend)
  if alignment.isSome:
    propSetInt(args, "alignment", alignment.get, paAppend)

  return API.invoke(plug, "CoreInfo".cstring, args)        

proc FrameNum*(vsmap:ptr VSMap; alignment=none(int)):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.text")
  if plug == nil:
    raise newException(ValueError, "plugin \"text\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq
  if tmpSeq.len != 1:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  let args = createMap()
  propSetNode(args, "clip", clip, paAppend)
  if alignment.isSome:
    propSetInt(args, "alignment", alignment.get, paAppend)

  return API.invoke(plug, "FrameNum".cstring, args)        

proc FrameProps*(vsmap:ptr VSMap; props=none(seq[string]); alignment=none(int)):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.text")
  if plug == nil:
    raise newException(ValueError, "plugin \"text\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq
  if tmpSeq.len != 1:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  let args = createMap()
  propSetNode(args, "clip", clip, paAppend)
  if props.isSome:
    for item in props.get:
      propSetData(args, "props", item, paAppend)
  if alignment.isSome:
    propSetInt(args, "alignment", alignment.get, paAppend)

  return API.invoke(plug, "FrameProps".cstring, args)        

proc Text*(vsmap:ptr VSMap, text:string; alignment=none(int)):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.text")
  if plug == nil:
    raise newException(ValueError, "plugin \"text\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq
  if tmpSeq.len != 1:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  let args = createMap()
  propSetNode(args, "clip", clip, paAppend)
  propSetData(args, "text", text, paAppend)
  if alignment.isSome:
    propSetInt(args, "alignment", alignment.get, paAppend)

  return API.invoke(plug, "Text".cstring, args)        

