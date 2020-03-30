proc Read*(filename:seq[string]; firstnum=none(int); mismatch=none(int); alpha=none(int); float_output=none(int)):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.imwri")
  if plug == nil:
    raise newException(ValueError, "plugin \"imwri\" not installed properly in your computer")

  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()
  for item in filename:
    args.append("filename", item)
  if firstnum.isSome: args.append("firstnum", firstnum.get)
  if mismatch.isSome: args.append("mismatch", mismatch.get)
  if alpha.isSome: args.append("alpha", alpha.get)
  if float_output.isSome: args.append("float_output", float_output.get)

  result = API.invoke(plug, "Read".cstring, args)
  API.freeMap(args)        

proc Write*(vsmap:ptr VSMap, imgformat:string, filename:string; firstnum=none(int); quality=none(int); dither=none(int); compression_type=none(string); overwrite=none(int); alpha=none(ptr VSNodeRef)):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.imwri")
  if plug == nil:
    raise newException(ValueError, "plugin \"imwri\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq    # Convert the VSMap into a sequence
  if tmpSeq.len == 0:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()
  args.append("clip", clip)
  args.append("imgformat", imgformat)
  args.append("filename", filename)
  if firstnum.isSome: args.append("firstnum", firstnum.get)
  if quality.isSome: args.append("quality", quality.get)
  if dither.isSome: args.append("dither", dither.get)
  if compression_type.isSome: args.append("compression_type", compression_type.get)
  if overwrite.isSome: args.append("overwrite", overwrite.get)
  if alpha.isSome: args.append("alpha", alpha.get)

  result = API.invoke(plug, "Write".cstring, args)
  API.freeMap(args)        

