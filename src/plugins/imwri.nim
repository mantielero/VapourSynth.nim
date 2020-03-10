proc Read(filename:data[]; firstnum=none(int); mismatch=none(int); alpha=none(int); float_output=none(int)):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.imwri")
  let args = createMap()
  (args, "filename", filename, paAppend)
  if firstnum.isSome:
    propSetInt(args, "firstnum", firstnum.get, paAppend)
  if mismatch.isSome:
    propSetInt(args, "mismatch", mismatch.get, paAppend)
  if alpha.isSome:
    propSetInt(args, "alpha", alpha.get, paAppend)
  if float_output.isSome:
    propSetInt(args, "float_output", float_output.get, paAppend)

  return API.invoke(plug, "Read".cstring, args)        

proc Write(clip:ptr VSNodeRef, imgformat:string, filename:string; firstnum=none(int); quality=none(int); dither=none(int); compression_type=none(string); overwrite=none(int); alpha=none(ptr VSNodeRef)):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.imwri")
  let args = createMap()
  propSetNode(args, "clip", clip, paAppend)
  propSetData(args, "imgformat", imgformat, paAppend)
  propSetData(args, "filename", filename, paAppend)
  if firstnum.isSome:
    propSetInt(args, "firstnum", firstnum.get, paAppend)
  if quality.isSome:
    propSetInt(args, "quality", quality.get, paAppend)
  if dither.isSome:
    propSetInt(args, "dither", dither.get, paAppend)
  if compression_type.isSome:
    propSetData(args, "compression_type", compression_type.get, paAppend)
  if overwrite.isSome:
    propSetInt(args, "overwrite", overwrite.get, paAppend)
  if alpha.isSome:
    propSetNode(args, "alpha", alpha.get, paAppend)

  return API.invoke(plug, "Write".cstring, args)        

