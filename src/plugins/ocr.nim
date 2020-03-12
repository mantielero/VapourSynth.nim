proc Recognize*(vsmap:ptr VSMap; datapath=none(string); language=none(string); options=none(seq[string])):ptr VSMap =
  let plug = getPluginById("biz.srsfckn.ocr")
  if plug == nil:
    raise newException(ValueError, "plugin \"ocr\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq
  if tmpSeq.len != 1:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  let args = createMap()
  propSetNode(args, "clip", clip, paAppend)
  if datapath.isSome:
    propSetData(args, "datapath", datapath.get, paAppend)
  if language.isSome:
    propSetData(args, "language", language.get, paAppend)
  if options.isSome:
    for item in options.get:
      propSetData(args, "options", item, paAppend)

  return API.invoke(plug, "Recognize".cstring, args)        

