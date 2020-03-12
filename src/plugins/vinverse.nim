proc Vinverse*(vsmap:ptr VSMap; sstr=none(float); amnt=none(int); scl=none(float)):ptr VSMap =
  let plug = getPluginById("biz.srsfckn.Vinverse")
  if plug == nil:
    raise newException(ValueError, "plugin \"vinverse\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq
  if tmpSeq.len != 1:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  let args = createMap()
  propSetNode(args, "clip", clip, paAppend)
  if sstr.isSome:
    propSetFloat(args, "sstr", sstr.get, paAppend)
  if amnt.isSome:
    propSetInt(args, "amnt", amnt.get, paAppend)
  if scl.isSome:
    propSetFloat(args, "scl", scl.get, paAppend)

  return API.invoke(plug, "Vinverse".cstring, args)        

