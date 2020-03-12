proc Deband*(vsmap:ptr VSMap; range=none(int); y=none(int); cb=none(int); cr=none(int); grainy=none(int); grainc=none(int); sample_mode=none(int); seed=none(int); blur_first=none(int); dynamic_grain=none(int); opt=none(int); dither_algo=none(int); keep_tv_range=none(int); output_depth=none(int); random_algo_ref=none(int); random_algo_grain=none(int); random_param_ref=none(float); random_param_grain=none(float); preset=none(string)):ptr VSMap =
  let plug = getPluginById("net.sapikachu.f3kdb")
  if plug == nil:
    raise newException(ValueError, "plugin \"f3kdb\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq
  if tmpSeq.len != 1:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  let args = createMap()
  propSetNode(args, "clip", clip, paAppend)
  if range.isSome:
    propSetInt(args, "range", range.get, paAppend)
  if y.isSome:
    propSetInt(args, "y", y.get, paAppend)
  if cb.isSome:
    propSetInt(args, "cb", cb.get, paAppend)
  if cr.isSome:
    propSetInt(args, "cr", cr.get, paAppend)
  if grainy.isSome:
    propSetInt(args, "grainy", grainy.get, paAppend)
  if grainc.isSome:
    propSetInt(args, "grainc", grainc.get, paAppend)
  if sample_mode.isSome:
    propSetInt(args, "sample_mode", sample_mode.get, paAppend)
  if seed.isSome:
    propSetInt(args, "seed", seed.get, paAppend)
  if blur_first.isSome:
    propSetInt(args, "blur_first", blur_first.get, paAppend)
  if dynamic_grain.isSome:
    propSetInt(args, "dynamic_grain", dynamic_grain.get, paAppend)
  if opt.isSome:
    propSetInt(args, "opt", opt.get, paAppend)
  if dither_algo.isSome:
    propSetInt(args, "dither_algo", dither_algo.get, paAppend)
  if keep_tv_range.isSome:
    propSetInt(args, "keep_tv_range", keep_tv_range.get, paAppend)
  if output_depth.isSome:
    propSetInt(args, "output_depth", output_depth.get, paAppend)
  if random_algo_ref.isSome:
    propSetInt(args, "random_algo_ref", random_algo_ref.get, paAppend)
  if random_algo_grain.isSome:
    propSetInt(args, "random_algo_grain", random_algo_grain.get, paAppend)
  if random_param_ref.isSome:
    propSetFloat(args, "random_param_ref", random_param_ref.get, paAppend)
  if random_param_grain.isSome:
    propSetFloat(args, "random_param_grain", random_param_grain.get, paAppend)
  if preset.isSome:
    propSetData(args, "preset", preset.get, paAppend)

  return API.invoke(plug, "Deband".cstring, args)        

