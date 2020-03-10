proc Vinverse(clip:ptr VSNodeRef; sstr=none(float); amnt=none(int); scl=none(float)):ptr VSMap =
  let plug = getPluginById("biz.srsfckn.Vinverse")
  let args = createMap()
  propSetNode(args, "clip", clip, paAppend)
  if sstr.isSome:
    propSetFloat(args, "sstr", sstr.get, paAppend)
  if amnt.isSome:
    propSetInt(args, "amnt", amnt.get, paAppend)
  if scl.isSome:
    propSetFloat(args, "scl", scl.get, paAppend)

  return API.invoke(plug, "Vinverse".cstring, args)        

