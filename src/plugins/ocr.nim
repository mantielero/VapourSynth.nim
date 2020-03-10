proc Recognize(clip:ptr VSNodeRef; datapath=none(string); language=none(string); options=none(data[])):ptr VSMap =
  let plug = getPluginById("biz.srsfckn.ocr")
  let args = createMap()
  propSetNode(args, "clip", clip, paAppend)
  if datapath.isSome:
    propSetData(args, "datapath", datapath.get, paAppend)
  if language.isSome:
    propSetData(args, "language", language.get, paAppend)
  if options.isSome:
    (args, "options", options.get, paAppend)

  return API.invoke(plug, "Recognize".cstring, args)        

