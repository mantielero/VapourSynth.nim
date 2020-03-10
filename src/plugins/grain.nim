proc Add(clip:ptr VSNodeRef; var=none(float); uvar=none(float); hcorr=none(float); vcorr=none(float); seed=none(int); constant=none(int)):ptr VSMap =
  let plug = getPluginById("com.holywu.addgrain")
  let args = createMap()
  propSetNode(args, "clip", clip, paAppend)
  if var.isSome:
    propSetFloat(args, "var", var.get, paAppend)
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

