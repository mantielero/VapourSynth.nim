proc MotionMask*(vsmap:ptr VSMap; planes= none(seq[int]); th1= none(seq[int]); th2= none(seq[int]); tht= none(int); sc_value= none(int)):ptr VSMap =

  let plug = getPluginById("com.nodame.motionmask")
  assert( plug != nil, "plugin \"com.nodame.motionmask\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("clip") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()
  args.append("clip", clip)
  if planes.isSome: args.set("planes", planes.get)
  if th1.isSome: args.set("th1", th1.get)
  if th2.isSome: args.set("th2", th2.get)
  if tht.isSome: args.append("tht", tht.get)
  if sc_value.isSome: args.append("sc_value", sc_value.get)

  result = API.invoke(plug, "MotionMask".cstring, args)
  API.freeMap(args)


