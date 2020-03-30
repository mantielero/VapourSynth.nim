proc VDecimate*(vsmap:ptr VSMap; cycle=none(int); chroma=none(int); dupthresh=none(float); scthresh=none(float); blockx=none(int); blocky=none(int); clip2=none(ptr VSNodeRef); ovr=none(string); dryrun=none(int)):ptr VSMap =
  let plug = getPluginById("org.ivtc.v")
  if plug == nil:
    raise newException(ValueError, "plugin \"vivtc\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq    # Convert the VSMap into a sequence
  if tmpSeq.len == 0:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()
  args.append("clip", clip)
  if cycle.isSome: args.append("cycle", cycle.get)
  if chroma.isSome: args.append("chroma", chroma.get)
  if dupthresh.isSome: args.append("dupthresh", dupthresh.get)
  if scthresh.isSome: args.append("scthresh", scthresh.get)
  if blockx.isSome: args.append("blockx", blockx.get)
  if blocky.isSome: args.append("blocky", blocky.get)
  if clip2.isSome: args.append("clip2", clip2.get)
  if ovr.isSome: args.append("ovr", ovr.get)
  if dryrun.isSome: args.append("dryrun", dryrun.get)

  result = API.invoke(plug, "VDecimate".cstring, args)
  API.freeMap(args)        

proc VFM*(vsmap:ptr VSMap, order:int; field=none(int); mode=none(int); mchroma=none(int); cthresh=none(int); mi=none(int); chroma=none(int); blockx=none(int); blocky=none(int); y0=none(int); y1=none(int); scthresh=none(float); micmatch=none(int); micout=none(int); clip2=none(ptr VSNodeRef)):ptr VSMap =
  let plug = getPluginById("org.ivtc.v")
  if plug == nil:
    raise newException(ValueError, "plugin \"vivtc\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq    # Convert the VSMap into a sequence
  if tmpSeq.len == 0:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()
  args.append("clip", clip)
  args.append("order", order)
  if field.isSome: args.append("field", field.get)
  if mode.isSome: args.append("mode", mode.get)
  if mchroma.isSome: args.append("mchroma", mchroma.get)
  if cthresh.isSome: args.append("cthresh", cthresh.get)
  if mi.isSome: args.append("mi", mi.get)
  if chroma.isSome: args.append("chroma", chroma.get)
  if blockx.isSome: args.append("blockx", blockx.get)
  if blocky.isSome: args.append("blocky", blocky.get)
  if y0.isSome: args.append("y0", y0.get)
  if y1.isSome: args.append("y1", y1.get)
  if scthresh.isSome: args.append("scthresh", scthresh.get)
  if micmatch.isSome: args.append("micmatch", micmatch.get)
  if micout.isSome: args.append("micout", micout.get)
  if clip2.isSome: args.append("clip2", clip2.get)

  result = API.invoke(plug, "VFM".cstring, args)
  API.freeMap(args)        

