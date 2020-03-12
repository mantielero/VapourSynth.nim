proc CTMF*(vsmap:ptr VSMap; radius=none(int); memsize=none(int); opt=none(int); planes=none(seq[int])):ptr VSMap =
  let plug = getPluginById("com.holywu.ctmf")
  if plug == nil:
    raise newException(ValueError, "plugin \"ctmf\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq
  if tmpSeq.len != 1:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  let args = createMap()
  propSetNode(args, "clip", clip, paAppend)
  if radius.isSome:
    propSetInt(args, "radius", radius.get, paAppend)
  if memsize.isSome:
    propSetInt(args, "memsize", memsize.get, paAppend)
  if opt.isSome:
    propSetInt(args, "opt", opt.get, paAppend)
  if planes.isSome:
    propSetIntArray(args, "planes", planes.get)

  return API.invoke(plug, "CTMF".cstring, args)        

