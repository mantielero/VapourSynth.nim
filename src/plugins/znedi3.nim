proc nnedi3*(vsmap:ptr VSMap, field:int; dh=none(int); planes=none(seq[int]); nsize=none(int); nns=none(int); qual=none(int); etype=none(int); pscrn=none(int); opt=none(int); int16_prescreener=none(int); int16_predictor=none(int); exp=none(int); show_mask=none(int); x_nnedi3_weights_bin=none(string); x_cpu=none(string)):ptr VSMap =
  let plug = getPluginById("xxx.abc.znedi3")
  if plug == nil:
    raise newException(ValueError, "plugin \"znedi3\" not installed properly in your computer")

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
  if nsize.isSome:
    propSetInt(args, "nsize", nsize.get, paAppend)
  if nns.isSome:
    propSetInt(args, "nns", nns.get, paAppend)
  if qual.isSome:
    propSetInt(args, "qual", qual.get, paAppend)
  if etype.isSome:
    propSetInt(args, "etype", etype.get, paAppend)
  if pscrn.isSome:
    propSetInt(args, "pscrn", pscrn.get, paAppend)
  if opt.isSome:
    propSetInt(args, "opt", opt.get, paAppend)
  if int16_prescreener.isSome:
    propSetInt(args, "int16_prescreener", int16_prescreener.get, paAppend)
  if int16_predictor.isSome:
    propSetInt(args, "int16_predictor", int16_predictor.get, paAppend)
  if exp.isSome:
    propSetInt(args, "exp", exp.get, paAppend)
  if show_mask.isSome:
    propSetInt(args, "show_mask", show_mask.get, paAppend)
  if x_nnedi3_weights_bin.isSome:
    propSetData(args, "x_nnedi3_weights_bin", x_nnedi3_weights_bin.get, paAppend)
  if x_cpu.isSome:
    propSetData(args, "x_cpu", x_cpu.get, paAppend)

  return API.invoke(plug, "nnedi3".cstring, args)        
