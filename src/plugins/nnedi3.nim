proc nnedi3(clip:ptr VSNodeRef, field:int; dh=none(int); planes=none(seq[int]); nsize=none(int); nns=none(int); qual=none(int); etype=none(int); pscrn=none(int); opt=none(int); int16_prescreener=none(int); int16_predictor=none(int); exp=none(int); show_mask=none(int); combed_only=none(int)):ptr VSMap =
  let plug = getPluginById("com.deinterlace.nnedi3")
  let args = createMap()
  propSetNode(args, "clip", clip, paAppend)
  propSetInt(args, "field", field, paAppend)
  if dh.isSome:
    propSetInt(args, "dh", dh.get, paAppend)
  if planes.isSome:
    propSetIntArray(args, "planes", planes.get, paAppend)
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
  if combed_only.isSome:
    propSetInt(args, "combed_only", combed_only.get, paAppend)

  return API.invoke(plug, "nnedi3".cstring, args)        

