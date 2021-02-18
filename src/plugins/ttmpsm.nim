proc TTempSmooth*(vsmap:ptr VSMap; maxr= none(int); thresh= none(seq[int]); mdiff= none(seq[int]); strength= none(int); scthresh= none(float); fp= none(int); pfclip= none(ptr VSNodeRef); planes= none(seq[int])):ptr VSMap =

  let plug = getPluginById("com.holywu.ttempsmooth")
  assert( plug != nil, "plugin \"com.holywu.ttempsmooth\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("clip") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()
  args.append("clip", clip)
  if maxr.isSome: args.append("maxr", maxr.get)
  if thresh.isSome: args.set("thresh", thresh.get)
  if mdiff.isSome: args.set("mdiff", mdiff.get)
  if strength.isSome: args.append("strength", strength.get)
  if scthresh.isSome: args.append("scthresh", scthresh.get)
  if fp.isSome: args.append("fp", fp.get)
  if pfclip.isSome: args.append("pfclip", pfclip.get)
  if planes.isSome: args.set("planes", planes.get)

  result = API.invoke(plug, "TTempSmooth".cstring, args)
  API.freeMap(args)


