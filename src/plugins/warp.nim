proc ABlur(clip:ptr VSNodeRef; blur=none(int); type=none(int); planes=none(seq[int]); opt=none(int)):ptr VSMap =
  let plug = getPluginById("com.nodame.awarpsharp2")
  let args = createMap()
  propSetNode(args, "clip", clip, paAppend)
  if blur.isSome:
    propSetInt(args, "blur", blur.get, paAppend)
  if type.isSome:
    propSetInt(args, "type", type.get, paAppend)
  if planes.isSome:
    propSetIntArray(args, "planes", planes.get, paAppend)
  if opt.isSome:
    propSetInt(args, "opt", opt.get, paAppend)

  return API.invoke(plug, "ABlur".cstring, args)        

proc ASobel(clip:ptr VSNodeRef; thresh=none(int); planes=none(seq[int]); opt=none(int)):ptr VSMap =
  let plug = getPluginById("com.nodame.awarpsharp2")
  let args = createMap()
  propSetNode(args, "clip", clip, paAppend)
  if thresh.isSome:
    propSetInt(args, "thresh", thresh.get, paAppend)
  if planes.isSome:
    propSetIntArray(args, "planes", planes.get, paAppend)
  if opt.isSome:
    propSetInt(args, "opt", opt.get, paAppend)

  return API.invoke(plug, "ASobel".cstring, args)        

proc AWarp(clip:ptr VSNodeRef, mask:ptr VSNodeRef; depth=none(seq[int]); chroma=none(int); planes=none(seq[int]); opt=none(int); cplace=none(string)):ptr VSMap =
  let plug = getPluginById("com.nodame.awarpsharp2")
  let args = createMap()
  propSetNode(args, "clip", clip, paAppend)
  propSetNode(args, "mask", mask, paAppend)
  if depth.isSome:
    propSetIntArray(args, "depth", depth.get, paAppend)
  if chroma.isSome:
    propSetInt(args, "chroma", chroma.get, paAppend)
  if planes.isSome:
    propSetIntArray(args, "planes", planes.get, paAppend)
  if opt.isSome:
    propSetInt(args, "opt", opt.get, paAppend)
  if cplace.isSome:
    propSetData(args, "cplace", cplace.get, paAppend)

  return API.invoke(plug, "AWarp".cstring, args)        

proc AWarpSharp2(clip:ptr VSNodeRef; thresh=none(int); blur=none(int); type=none(int); depth=none(seq[int]); chroma=none(int); planes=none(seq[int]); opt=none(int); cplace=none(string)):ptr VSMap =
  let plug = getPluginById("com.nodame.awarpsharp2")
  let args = createMap()
  propSetNode(args, "clip", clip, paAppend)
  if thresh.isSome:
    propSetInt(args, "thresh", thresh.get, paAppend)
  if blur.isSome:
    propSetInt(args, "blur", blur.get, paAppend)
  if type.isSome:
    propSetInt(args, "type", type.get, paAppend)
  if depth.isSome:
    propSetIntArray(args, "depth", depth.get, paAppend)
  if chroma.isSome:
    propSetInt(args, "chroma", chroma.get, paAppend)
  if planes.isSome:
    propSetIntArray(args, "planes", planes.get, paAppend)
  if opt.isSome:
    propSetInt(args, "opt", opt.get, paAppend)
  if cplace.isSome:
    propSetData(args, "cplace", cplace.get, paAppend)

  return API.invoke(plug, "AWarpSharp2".cstring, args)        

