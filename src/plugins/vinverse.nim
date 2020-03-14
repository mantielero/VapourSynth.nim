proc Vinverse*(vsmap:ptr VSMap; sstr=none(float); amnt=none(int); scl=none(float)):ptr VSMap =
  let plug = getPluginById("biz.srsfckn.Vinverse")
  if plug == nil:
    raise newException(ValueError, "plugin \"vinverse\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq    # Convert the VSMap into a sequence
  if tmpSeq.len == 0:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()
  args.append("clip", clip)
  if sstr.isSome: args.append("sstr", sstr.get)
  if amnt.isSome: args.append("amnt", amnt.get)
  if scl.isSome: args.append("scl", scl.get)

  return API.invoke(plug, "Vinverse".cstring, args)        

