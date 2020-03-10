proc VDecimate(clip:ptr VSNodeRef; cycle=none(int); chroma=none(int); dupthresh=none(float); scthresh=none(float); blockx=none(int); blocky=none(int); clip2=none(ptr VSNodeRef); ovr=none(string); dryrun=none(int)):ptr VSMap =
  let plug = getPluginById("org.ivtc.v")
  let args = createMap()
  propSetNode(args, "clip", clip, paAppend)
  if cycle.isSome:
    propSetInt(args, "cycle", cycle.get, paAppend)
  if chroma.isSome:
    propSetInt(args, "chroma", chroma.get, paAppend)
  if dupthresh.isSome:
    propSetFloat(args, "dupthresh", dupthresh.get, paAppend)
  if scthresh.isSome:
    propSetFloat(args, "scthresh", scthresh.get, paAppend)
  if blockx.isSome:
    propSetInt(args, "blockx", blockx.get, paAppend)
  if blocky.isSome:
    propSetInt(args, "blocky", blocky.get, paAppend)
  if clip2.isSome:
    propSetNode(args, "clip2", clip2.get, paAppend)
  if ovr.isSome:
    propSetData(args, "ovr", ovr.get, paAppend)
  if dryrun.isSome:
    propSetInt(args, "dryrun", dryrun.get, paAppend)

  return API.invoke(plug, "VDecimate".cstring, args)        

proc VFM(clip:ptr VSNodeRef, order:int; field=none(int); mode=none(int); mchroma=none(int); cthresh=none(int); mi=none(int); chroma=none(int); blockx=none(int); blocky=none(int); y0=none(int); y1=none(int); scthresh=none(float); micmatch=none(int); micout=none(int); clip2=none(ptr VSNodeRef)):ptr VSMap =
  let plug = getPluginById("org.ivtc.v")
  let args = createMap()
  propSetNode(args, "clip", clip, paAppend)
  propSetInt(args, "order", order, paAppend)
  if field.isSome:
    propSetInt(args, "field", field.get, paAppend)
  if mode.isSome:
    propSetInt(args, "mode", mode.get, paAppend)
  if mchroma.isSome:
    propSetInt(args, "mchroma", mchroma.get, paAppend)
  if cthresh.isSome:
    propSetInt(args, "cthresh", cthresh.get, paAppend)
  if mi.isSome:
    propSetInt(args, "mi", mi.get, paAppend)
  if chroma.isSome:
    propSetInt(args, "chroma", chroma.get, paAppend)
  if blockx.isSome:
    propSetInt(args, "blockx", blockx.get, paAppend)
  if blocky.isSome:
    propSetInt(args, "blocky", blocky.get, paAppend)
  if y0.isSome:
    propSetInt(args, "y0", y0.get, paAppend)
  if y1.isSome:
    propSetInt(args, "y1", y1.get, paAppend)
  if scthresh.isSome:
    propSetFloat(args, "scthresh", scthresh.get, paAppend)
  if micmatch.isSome:
    propSetInt(args, "micmatch", micmatch.get, paAppend)
  if micout.isSome:
    propSetInt(args, "micout", micout.get, paAppend)
  if clip2.isSome:
    propSetNode(args, "clip2", clip2.get, paAppend)

  return API.invoke(plug, "VFM".cstring, args)        

