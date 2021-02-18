proc Add*(vsmap:ptr VSMap; `var`= none(float); uvar= none(float); hcorr= none(float); vcorr= none(float); seed= none(int); constant= none(int)):ptr VSMap =

  let plug = getPluginById("com.holywu.addgrain")
  assert( plug != nil, "plugin \"com.holywu.addgrain\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("clip") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


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


