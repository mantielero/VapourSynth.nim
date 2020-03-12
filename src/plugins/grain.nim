proc Add*(vsmap:ptr VSMap; `var`=none(float); uvar=none(float); hcorr=none(float); vcorr=none(float); seed=none(int); constant=none(int)):ptr VSMap =
  let plug = getPluginById("com.holywu.addgrain")
  if plug == nil:
    raise newException(ValueError, "plugin \"grain\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq
  if tmpSeq.len != 1:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  let args = createMap()
  propSetNode(args, "clip", clip, paAppend)
  if `var`.isSome:
    propSetFloat(args, "var", `var`.get, paAppend)
  if uvar.isSome:
    propSetFloat(args, "uvar", uvar.get, paAppend)
  if hcorr.isSome:
    propSetFloat(args, "hcorr", hcorr.get, paAppend)
  if vcorr.isSome:
    propSetFloat(args, "vcorr", vcorr.get, paAppend)
  if seed.isSome:
    propSetInt(args, "seed", seed.get, paAppend)
  if constant.isSome:
    propSetInt(args, "constant", constant.get, paAppend)

  return API.invoke(plug, "Add".cstring, args)        

