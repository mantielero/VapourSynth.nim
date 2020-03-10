proc ClipInfo(clip:ptr VSNodeRef; alignment=none(int)):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.text")
  let args = createMap()
  propSetNode(args, "clip", clip, paAppend)
  if alignment.isSome:
    propSetInt(args, "alignment", alignment.get, paAppend)

  return API.invoke(plug, "ClipInfo".cstring, args)        

proc CoreInfo(clip=none(ptr VSNodeRef); alignment=none(int)):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.text")
  let args = createMap()
  if clip.isSome:
    propSetNode(args, "clip", clip.get, paAppend)
  if alignment.isSome:
    propSetInt(args, "alignment", alignment.get, paAppend)

  return API.invoke(plug, "CoreInfo".cstring, args)        

proc FrameNum(clip:ptr VSNodeRef; alignment=none(int)):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.text")
  let args = createMap()
  propSetNode(args, "clip", clip, paAppend)
  if alignment.isSome:
    propSetInt(args, "alignment", alignment.get, paAppend)

  return API.invoke(plug, "FrameNum".cstring, args)        

proc FrameProps(clip:ptr VSNodeRef; props=none(data[]); alignment=none(int)):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.text")
  let args = createMap()
  propSetNode(args, "clip", clip, paAppend)
  if props.isSome:
    (args, "props", props.get, paAppend)
  if alignment.isSome:
    propSetInt(args, "alignment", alignment.get, paAppend)

  return API.invoke(plug, "FrameProps".cstring, args)        

proc Text(clip:ptr VSNodeRef, text:string; alignment=none(int)):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.text")
  let args = createMap()
  propSetNode(args, "clip", clip, paAppend)
  propSetData(args, "text", text, paAppend)
  if alignment.isSome:
    propSetInt(args, "alignment", alignment.get, paAppend)

  return API.invoke(plug, "Text".cstring, args)        

