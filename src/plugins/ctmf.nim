proc CTMF(clip:ptr VSNodeRef; radius=none(int); memsize=none(int); opt=none(int); planes=none(seq[int])):ptr VSMap =
  let plug = getPluginById("com.holywu.ctmf")
  let args = createMap()
  propSetNode(args, "clip", clip, paAppend)
  if radius.isSome:
    propSetInt(args, "radius", radius.get, paAppend)
  if memsize.isSome:
    propSetInt(args, "memsize", memsize.get, paAppend)
  if opt.isSome:
    propSetInt(args, "opt", opt.get, paAppend)
  if planes.isSome:
    propSetIntArray(args, "planes", planes.get, paAppend)

  return API.invoke(plug, "CTMF".cstring, args)        

