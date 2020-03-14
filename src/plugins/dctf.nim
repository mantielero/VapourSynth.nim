proc DCTFilter*(vsmap:ptr VSMap, factors:seq[float]; planes=none(seq[int])):ptr VSMap =
  let plug = getPluginById("com.holywu.dctfilter")
  if plug == nil:
    raise newException(ValueError, "plugin \"dctf\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq    # Convert the VSMap into a sequence
  if tmpSeq.len == 0:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()
  args.append("clip", clip)
  args.set("factors", factors)
  if planes.isSome: args.set("planes", planes.get)

  return API.invoke(plug, "DCTFilter".cstring, args)        

