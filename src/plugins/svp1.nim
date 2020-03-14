proc Analyse*(vsmap:ptr VSMap, sdata:int, src:ptr VSNodeRef, opt:string):ptr VSMap =
  let plug = getPluginById("com.svp-team.flow1")
  if plug == nil:
    raise newException(ValueError, "plugin \"svp1\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq    # Convert the VSMap into a sequence
  if tmpSeq.len == 0:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()
  args.append("clip", clip)
  args.append("sdata", sdata)
  args.append("src", src)
  args.append("opt", opt)

  return API.invoke(plug, "Analyse".cstring, args)        

proc Super*(vsmap:ptr VSMap, opt:string):ptr VSMap =
  let plug = getPluginById("com.svp-team.flow1")
  if plug == nil:
    raise newException(ValueError, "plugin \"svp1\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq    # Convert the VSMap into a sequence
  if tmpSeq.len == 0:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()
  args.append("clip", clip)
  args.append("opt", opt)

  return API.invoke(plug, "Super".cstring, args)        

