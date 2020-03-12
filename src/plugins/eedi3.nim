proc eedi3*(vsmap:ptr VSMap, field:int; dh=none(int); planes=none(seq[int]); alpha=none(float); beta=none(float); gamma=none(float); nrad=none(int); mdis=none(int); hp=none(int); ucubic=none(int); cost3=none(int); vcheck=none(int); vthresh0=none(float); vthresh1=none(float); vthresh2=none(float); sclip=none(ptr VSNodeRef)):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.eedi3")
  if plug == nil:
    raise newException(ValueError, "plugin \"eedi3\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq
  if tmpSeq.len != 1:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  let args = createMap()
  propSetNode(args, "clip", clip, paAppend)
  propSetInt(args, "field", field, paAppend)
  if dh.isSome:
    propSetInt(args, "dh", dh.get, paAppend)
  if planes.isSome:
    propSetIntArray(args, "planes", planes.get)
  if alpha.isSome:
    propSetFloat(args, "alpha", alpha.get, paAppend)
  if beta.isSome:
    propSetFloat(args, "beta", beta.get, paAppend)
  if gamma.isSome:
    propSetFloat(args, "gamma", gamma.get, paAppend)
  if nrad.isSome:
    propSetInt(args, "nrad", nrad.get, paAppend)
  if mdis.isSome:
    propSetInt(args, "mdis", mdis.get, paAppend)
  if hp.isSome:
    propSetInt(args, "hp", hp.get, paAppend)
  if ucubic.isSome:
    propSetInt(args, "ucubic", ucubic.get, paAppend)
  if cost3.isSome:
    propSetInt(args, "cost3", cost3.get, paAppend)
  if vcheck.isSome:
    propSetInt(args, "vcheck", vcheck.get, paAppend)
  if vthresh0.isSome:
    propSetFloat(args, "vthresh0", vthresh0.get, paAppend)
  if vthresh1.isSome:
    propSetFloat(args, "vthresh1", vthresh1.get, paAppend)
  if vthresh2.isSome:
    propSetFloat(args, "vthresh2", vthresh2.get, paAppend)
  if sclip.isSome:
    propSetNode(args, "sclip", sclip.get, paAppend)

  return API.invoke(plug, "eedi3".cstring, args)        

