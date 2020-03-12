proc Deblock*(vsmap:ptr VSMap; quant=none(int); aoffset=none(int); boffset=none(int); planes=none(seq[int])):ptr VSMap =
  let plug = getPluginById("com.holywu.deblock")
  if plug == nil:
    raise newException(ValueError, "plugin \"deblock\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq
  if tmpSeq.len != 1:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  let args = createMap()
  propSetNode(args, "clip", clip, paAppend)
  if quant.isSome:
    propSetInt(args, "quant", quant.get, paAppend)
  if aoffset.isSome:
    propSetInt(args, "aoffset", aoffset.get, paAppend)
  if boffset.isSome:
    propSetInt(args, "boffset", boffset.get, paAppend)
  if planes.isSome:
    propSetIntArray(args, "planes", planes.get)

  return API.invoke(plug, "Deblock".cstring, args)        

