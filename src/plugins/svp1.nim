proc Analyse*(vsmap:ptr VSMap, sdata:int, src:ptr VSNodeRef, opt:string):ptr VSMap =
  let plug = getPluginById("com.svp-team.flow1")
  if plug == nil:
    raise newException(ValueError, "plugin \"svp1\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq
  if tmpSeq.len != 1:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  let args = createMap()
  propSetNode(args, "clip", clip, paAppend)
  propSetInt(args, "sdata", sdata, paAppend)
  propSetNode(args, "src", src, paAppend)
  propSetData(args, "opt", opt, paAppend)

  return API.invoke(plug, "Analyse".cstring, args)        

proc Super*(vsmap:ptr VSMap, opt:string):ptr VSMap =
  let plug = getPluginById("com.svp-team.flow1")
  if plug == nil:
    raise newException(ValueError, "plugin \"svp1\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq
  if tmpSeq.len != 1:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  let args = createMap()
  propSetNode(args, "clip", clip, paAppend)
  propSetData(args, "opt", opt, paAppend)

  return API.invoke(plug, "Super".cstring, args)        

