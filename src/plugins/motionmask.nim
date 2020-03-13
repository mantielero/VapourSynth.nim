proc MotionMask*(vsmap:ptr VSMap; planes=none(seq[int]); th1=none(seq[int]); th2=none(seq[int]); tht=none(int); sc_value=none(int)):ptr VSMap =
  let plug = getPluginById("com.nodame.motionmask")
  if plug == nil:
    raise newException(ValueError, "plugin \"motionmask\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq
  if tmpSeq.len != 1:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  let args = createMap()
  propSetNode(args, "clip", clip, paAppend)
  if planes.isSome:
    propSetIntArray(args, "planes", planes.get)
  if th1.isSome:
    propSetIntArray(args, "th1", th1.get)
  if th2.isSome:
    propSetIntArray(args, "th2", th2.get)
  if tht.isSome:
    propSetInt(args, "tht", tht.get, paAppend)
  if sc_value.isSome:
    propSetInt(args, "sc_value", sc_value.get, paAppend)

  return API.invoke(plug, "MotionMask".cstring, args)        

