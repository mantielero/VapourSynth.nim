proc Add*(vsmap:ptr VSMap; `var`=none(float); uvar=none(float); hcorr=none(float); vcorr=none(float); seed=none(int); constant=none(int)):ptr VSMap =
  let plug = getPluginById("com.holywu.addgrain")
  if plug == nil:
    raise newException(ValueError, "plugin \"grain\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq    # Convert the VSMap into a sequence
  if tmpSeq.len == 0:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()
  args.append("clip", clip)
  if `var`.isSome: args.append("var", `var`.get)
  if uvar.isSome: args.append("uvar", uvar.get)
  if hcorr.isSome: args.append("hcorr", hcorr.get)
  if vcorr.isSome: args.append("vcorr", vcorr.get)
  if seed.isSome: args.append("seed", seed.get)
  if constant.isSome: args.append("constant", constant.get)

  result = API.invoke(plug, "Add".cstring, args)
  API.freeMap(args)        

