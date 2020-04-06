proc Deband*(vsmap:ptr VSMap; range= none(int); y= none(int); cb= none(int); cr= none(int); grainy= none(int); grainc= none(int); sample_mode= none(int); seed= none(int); blur_first= none(int); dynamic_grain= none(int); opt= none(int); dither_algo= none(int); keep_tv_range= none(int); output_depth= none(int); random_algo_ref= none(int); random_algo_grain= none(int); random_param_ref= none(float); random_param_grain= none(float); preset= none(string)):ptr VSMap =

  let plug = getPluginById("net.sapikachu.f3kdb")
  assert( plug != nil, "plugin \"net.sapikachu.f3kdb\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("clip") != 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()
  args.append("clip", clip)
  if range.isSome: args.append("range", range.get)
  if y.isSome: args.append("y", y.get)
  if cb.isSome: args.append("cb", cb.get)
  if cr.isSome: args.append("cr", cr.get)
  if grainy.isSome: args.append("grainy", grainy.get)
  if grainc.isSome: args.append("grainc", grainc.get)
  if sample_mode.isSome: args.append("sample_mode", sample_mode.get)
  if seed.isSome: args.append("seed", seed.get)
  if blur_first.isSome: args.append("blur_first", blur_first.get)
  if dynamic_grain.isSome: args.append("dynamic_grain", dynamic_grain.get)
  if opt.isSome: args.append("opt", opt.get)
  if dither_algo.isSome: args.append("dither_algo", dither_algo.get)
  if keep_tv_range.isSome: args.append("keep_tv_range", keep_tv_range.get)
  if output_depth.isSome: args.append("output_depth", output_depth.get)
  if random_algo_ref.isSome: args.append("random_algo_ref", random_algo_ref.get)
  if random_algo_grain.isSome: args.append("random_algo_grain", random_algo_grain.get)
  if random_param_ref.isSome: args.append("random_param_ref", random_param_ref.get)
  if random_param_grain.isSome: args.append("random_param_grain", random_param_grain.get)
  if preset.isSome: args.append("preset", preset.get)

  result = API.invoke(plug, "Deband".cstring, args)
  API.freeMap(args)


