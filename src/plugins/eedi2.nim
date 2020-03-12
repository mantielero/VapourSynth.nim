proc EEDI2*(vsmap:ptr VSMap, field:int; mthresh=none(int); lthresh=none(int); vthresh=none(int); estr=none(int); dstr=none(int); maxd=none(int); map=none(int); nt=none(int); pp=none(int)):ptr VSMap =
  let plug = getPluginById("com.holywu.eedi2")
  if plug == nil:
    raise newException(ValueError, "plugin \"eedi2\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq
  if tmpSeq.len != 1:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  let args = createMap()
  propSetNode(args, "clip", clip, paAppend)
  propSetInt(args, "field", field, paAppend)
  if mthresh.isSome:
    propSetInt(args, "mthresh", mthresh.get, paAppend)
  if lthresh.isSome:
    propSetInt(args, "lthresh", lthresh.get, paAppend)
  if vthresh.isSome:
    propSetInt(args, "vthresh", vthresh.get, paAppend)
  if estr.isSome:
    propSetInt(args, "estr", estr.get, paAppend)
  if dstr.isSome:
    propSetInt(args, "dstr", dstr.get, paAppend)
  if maxd.isSome:
    propSetInt(args, "maxd", maxd.get, paAppend)
  if map.isSome:
    propSetInt(args, "map", map.get, paAppend)
  if nt.isSome:
    propSetInt(args, "nt", nt.get, paAppend)
  if pp.isSome:
    propSetInt(args, "pp", pp.get, paAppend)

  return API.invoke(plug, "EEDI2".cstring, args)        

