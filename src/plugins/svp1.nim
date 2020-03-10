proc Analyse(clip:ptr VSNodeRef, sdata:int, src:ptr VSNodeRef, opt:string):ptr VSMap =
  let plug = getPluginById("com.svp-team.flow1")
  let args = createMap()
  propSetNode(args, "clip", clip, paAppend)
  propSetInt(args, "sdata", sdata, paAppend)
  propSetNode(args, "src", src, paAppend)
  propSetData(args, "opt", opt, paAppend)

  return API.invoke(plug, "Analyse".cstring, args)        

proc Super(clip:ptr VSNodeRef, opt:string):ptr VSMap =
  let plug = getPluginById("com.svp-team.flow1")
  let args = createMap()
  propSetNode(args, "clip", clip, paAppend)
  propSetData(args, "opt", opt, paAppend)

  return API.invoke(plug, "Super".cstring, args)        

