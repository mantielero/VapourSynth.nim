proc FFT3DFilter*(vsmap:ptr VSMap; sigma=none(float); beta=none(float); planes=none(seq[int]); bw=none(int); bh=none(int); bt=none(int); ow=none(int); oh=none(int); kratio=none(float); sharpen=none(float); scutoff=none(float); svr=none(float); smin=none(float); smax=none(float); measure=none(int); interlaced=none(int); wintype=none(int); pframe=none(int); px=none(int); py=none(int); pshow=none(int); pcutoff=none(float); pfactor=none(float); sigma2=none(float); sigma3=none(float); sigma4=none(float); degrid=none(float); dehalo=none(float); hr=none(float); ht=none(float); ncpu=none(int)):ptr VSMap =
  let plug = getPluginById("systems.innocent.fft3dfilter")
  if plug == nil:
    raise newException(ValueError, "plugin \"fft3dfilter\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq
  if tmpSeq.len != 1:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  let args = createMap()
  propSetNode(args, "clip", clip, paAppend)
  if sigma.isSome:
    propSetFloat(args, "sigma", sigma.get, paAppend)
  if beta.isSome:
    propSetFloat(args, "beta", beta.get, paAppend)
  if planes.isSome:
    propSetIntArray(args, "planes", planes.get)
  if bw.isSome:
    propSetInt(args, "bw", bw.get, paAppend)
  if bh.isSome:
    propSetInt(args, "bh", bh.get, paAppend)
  if bt.isSome:
    propSetInt(args, "bt", bt.get, paAppend)
  if ow.isSome:
    propSetInt(args, "ow", ow.get, paAppend)
  if oh.isSome:
    propSetInt(args, "oh", oh.get, paAppend)
  if kratio.isSome:
    propSetFloat(args, "kratio", kratio.get, paAppend)
  if sharpen.isSome:
    propSetFloat(args, "sharpen", sharpen.get, paAppend)
  if scutoff.isSome:
    propSetFloat(args, "scutoff", scutoff.get, paAppend)
  if svr.isSome:
    propSetFloat(args, "svr", svr.get, paAppend)
  if smin.isSome:
    propSetFloat(args, "smin", smin.get, paAppend)
  if smax.isSome:
    propSetFloat(args, "smax", smax.get, paAppend)
  if measure.isSome:
    propSetInt(args, "measure", measure.get, paAppend)
  if interlaced.isSome:
    propSetInt(args, "interlaced", interlaced.get, paAppend)
  if wintype.isSome:
    propSetInt(args, "wintype", wintype.get, paAppend)
  if pframe.isSome:
    propSetInt(args, "pframe", pframe.get, paAppend)
  if px.isSome:
    propSetInt(args, "px", px.get, paAppend)
  if py.isSome:
    propSetInt(args, "py", py.get, paAppend)
  if pshow.isSome:
    propSetInt(args, "pshow", pshow.get, paAppend)
  if pcutoff.isSome:
    propSetFloat(args, "pcutoff", pcutoff.get, paAppend)
  if pfactor.isSome:
    propSetFloat(args, "pfactor", pfactor.get, paAppend)
  if sigma2.isSome:
    propSetFloat(args, "sigma2", sigma2.get, paAppend)
  if sigma3.isSome:
    propSetFloat(args, "sigma3", sigma3.get, paAppend)
  if sigma4.isSome:
    propSetFloat(args, "sigma4", sigma4.get, paAppend)
  if degrid.isSome:
    propSetFloat(args, "degrid", degrid.get, paAppend)
  if dehalo.isSome:
    propSetFloat(args, "dehalo", dehalo.get, paAppend)
  if hr.isSome:
    propSetFloat(args, "hr", hr.get, paAppend)
  if ht.isSome:
    propSetFloat(args, "ht", ht.get, paAppend)
  if ncpu.isSome:
    propSetInt(args, "ncpu", ncpu.get, paAppend)

  return API.invoke(plug, "FFT3DFilter".cstring, args)        

