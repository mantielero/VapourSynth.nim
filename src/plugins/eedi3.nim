proc eedi3*(vsmap:ptr VSMap, field:int; dh=none(int); planes=none(seq[int]); alpha=none(float); beta=none(float); gamma=none(float); nrad=none(int); mdis=none(int); hp=none(int); ucubic=none(int); cost3=none(int); vcheck=none(int); vthresh0=none(float); vthresh1=none(float); vthresh2=none(float); sclip=none(ptr VSNodeRef)):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.eedi3")
  if plug == nil:
    raise newException(ValueError, "plugin \"eedi3\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq    # Convert the VSMap into a sequence
  if tmpSeq.len == 0:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()
  args.append("clip", clip)
  args.append("field", field)
  if dh.isSome: args.append("dh", dh.get)
  if planes.isSome: args.set("planes", planes.get)
  if alpha.isSome: args.append("alpha", alpha.get)
  if beta.isSome: args.append("beta", beta.get)
  if gamma.isSome: args.append("gamma", gamma.get)
  if nrad.isSome: args.append("nrad", nrad.get)
  if mdis.isSome: args.append("mdis", mdis.get)
  if hp.isSome: args.append("hp", hp.get)
  if ucubic.isSome: args.append("ucubic", ucubic.get)
  if cost3.isSome: args.append("cost3", cost3.get)
  if vcheck.isSome: args.append("vcheck", vcheck.get)
  if vthresh0.isSome: args.append("vthresh0", vthresh0.get)
  if vthresh1.isSome: args.append("vthresh1", vthresh1.get)
  if vthresh2.isSome: args.append("vthresh2", vthresh2.get)
  if sclip.isSome: args.append("sclip", sclip.get)

  return API.invoke(plug, "eedi3".cstring, args)        

