proc Deblock(clip:ptr VSNodeRef; quant=none(int); aoffset=none(int); boffset=none(int); planes=none(seq[int])):ptr VSMap =
  let plug = getPluginById("com.holywu.deblock")
  let args = createMap()
  propSetNode(args, "clip", clip, paAppend)
  if quant.isSome:
    propSetInt(args, "quant", quant.get, paAppend)
  if aoffset.isSome:
    propSetInt(args, "aoffset", aoffset.get, paAppend)
  if boffset.isSome:
    propSetInt(args, "boffset", boffset.get, paAppend)
  if planes.isSome:
    propSetIntArray(args, "planes", planes.get, paAppend)

  return API.invoke(plug, "Deblock".cstring, args)        

