proc KNLMeansCL(clip:ptr VSNodeRef; d=none(int); a=none(int); s=none(int); h=none(float); channels=none(string); wmode=none(int); wref=none(float); rclip=none(ptr VSNodeRef); device_type=none(string); device_id=none(int); ocl_x=none(int); ocl_y=none(int); ocl_r=none(int); info=none(int)):ptr VSMap =
  let plug = getPluginById("com.Khanattila.KNLMeansCL")
  let args = createMap()
  propSetNode(args, "clip", clip, paAppend)
  if d.isSome:
    propSetInt(args, "d", d.get, paAppend)
  if a.isSome:
    propSetInt(args, "a", a.get, paAppend)
  if s.isSome:
    propSetInt(args, "s", s.get, paAppend)
  if h.isSome:
    propSetFloat(args, "h", h.get, paAppend)
  if channels.isSome:
    propSetData(args, "channels", channels.get, paAppend)
  if wmode.isSome:
    propSetInt(args, "wmode", wmode.get, paAppend)
  if wref.isSome:
    propSetFloat(args, "wref", wref.get, paAppend)
  if rclip.isSome:
    propSetNode(args, "rclip", rclip.get, paAppend)
  if device_type.isSome:
    propSetData(args, "device_type", device_type.get, paAppend)
  if device_id.isSome:
    propSetInt(args, "device_id", device_id.get, paAppend)
  if ocl_x.isSome:
    propSetInt(args, "ocl_x", ocl_x.get, paAppend)
  if ocl_y.isSome:
    propSetInt(args, "ocl_y", ocl_y.get, paAppend)
  if ocl_r.isSome:
    propSetInt(args, "ocl_r", ocl_r.get, paAppend)
  if info.isSome:
    propSetInt(args, "info", info.get, paAppend)

  return API.invoke(plug, "KNLMeansCL".cstring, args)        

