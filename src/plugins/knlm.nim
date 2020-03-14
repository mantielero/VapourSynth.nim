proc KNLMeansCL*(vsmap:ptr VSMap; d=none(int); a=none(int); s=none(int); h=none(float); channels=none(string); wmode=none(int); wref=none(float); rclip=none(ptr VSNodeRef); device_type=none(string); device_id=none(int); ocl_x=none(int); ocl_y=none(int); ocl_r=none(int); info=none(int)):ptr VSMap =
  let plug = getPluginById("com.Khanattila.KNLMeansCL")
  if plug == nil:
    raise newException(ValueError, "plugin \"knlm\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq    # Convert the VSMap into a sequence
  if tmpSeq.len == 0:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()
  args.append("clip", clip)
  if d.isSome: args.append("d", d.get)
  if a.isSome: args.append("a", a.get)
  if s.isSome: args.append("s", s.get)
  if h.isSome: args.append("h", h.get)
  if channels.isSome: args.append("channels", channels.get)
  if wmode.isSome: args.append("wmode", wmode.get)
  if wref.isSome: args.append("wref", wref.get)
  if rclip.isSome: args.append("rclip", rclip.get)
  if device_type.isSome: args.append("device_type", device_type.get)
  if device_id.isSome: args.append("device_id", device_id.get)
  if ocl_x.isSome: args.append("ocl_x", ocl_x.get)
  if ocl_y.isSome: args.append("ocl_y", ocl_y.get)
  if ocl_r.isSome: args.append("ocl_r", ocl_r.get)
  if info.isSome: args.append("info", info.get)

  return API.invoke(plug, "KNLMeansCL".cstring, args)        

