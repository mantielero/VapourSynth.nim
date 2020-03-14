proc nnedi3*(vsmap:ptr VSMap, field:int; dh=none(int); planes=none(seq[int]); nsize=none(int); nns=none(int); qual=none(int); etype=none(int); pscrn=none(int); opt=none(int); int16_prescreener=none(int); int16_predictor=none(int); exp=none(int); show_mask=none(int); x_nnedi3_weights_bin=none(string); x_cpu=none(string)):ptr VSMap =
  let plug = getPluginById("xxx.abc.znedi3")
  if plug == nil:
    raise newException(ValueError, "plugin \"znedi3\" not installed properly in your computer")

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
  if nsize.isSome: args.append("nsize", nsize.get)
  if nns.isSome: args.append("nns", nns.get)
  if qual.isSome: args.append("qual", qual.get)
  if etype.isSome: args.append("etype", etype.get)
  if pscrn.isSome: args.append("pscrn", pscrn.get)
  if opt.isSome: args.append("opt", opt.get)
  if int16_prescreener.isSome: args.append("int16_prescreener", int16_prescreener.get)
  if int16_predictor.isSome: args.append("int16_predictor", int16_predictor.get)
  if exp.isSome: args.append("exp", exp.get)
  if show_mask.isSome: args.append("show_mask", show_mask.get)
  if x_nnedi3_weights_bin.isSome: args.append("x_nnedi3_weights_bin", x_nnedi3_weights_bin.get)
  if x_cpu.isSome: args.append("x_cpu", x_cpu.get)

  return API.invoke(plug, "nnedi3".cstring, args)        

