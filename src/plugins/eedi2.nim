proc EEDI2*(vsmap:ptr VSMap, field:int; mthresh=none(int); lthresh=none(int); vthresh=none(int); estr=none(int); dstr=none(int); maxd=none(int); map=none(int); nt=none(int); pp=none(int)):ptr VSMap =
  let plug = getPluginById("com.holywu.eedi2")
  if plug == nil:
    raise newException(ValueError, "plugin \"eedi2\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq    # Convert the VSMap into a sequence
  if tmpSeq.len == 0:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()
  args.append("clip", clip)
  args.append("field", field)
  if mthresh.isSome: args.append("mthresh", mthresh.get)
  if lthresh.isSome: args.append("lthresh", lthresh.get)
  if vthresh.isSome: args.append("vthresh", vthresh.get)
  if estr.isSome: args.append("estr", estr.get)
  if dstr.isSome: args.append("dstr", dstr.get)
  if maxd.isSome: args.append("maxd", maxd.get)
  if map.isSome: args.append("map", map.get)
  if nt.isSome: args.append("nt", nt.get)
  if pp.isSome: args.append("pp", pp.get)

  result = API.invoke(plug, "EEDI2".cstring, args)
  API.freeMap(args)        

