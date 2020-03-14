proc Recognize*(vsmap:ptr VSMap; datapath=none(string); language=none(string); options=none(seq[string])):ptr VSMap =
  let plug = getPluginById("biz.srsfckn.ocr")
  if plug == nil:
    raise newException(ValueError, "plugin \"ocr\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq    # Convert the VSMap into a sequence
  if tmpSeq.len == 0:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()
  args.append("clip", clip)
  if datapath.isSome: args.append("datapath", datapath.get)
  if language.isSome: args.append("language", language.get)
  if options.isSome:
    for item in options.get:
      args.append("options", item)

  return API.invoke(plug, "Recognize".cstring, args)        

