proc FFT3DFilter*(vsmap:ptr VSMap; sigma=none(float); beta=none(float); planes=none(seq[int]); bw=none(int); bh=none(int); bt=none(int); ow=none(int); oh=none(int); kratio=none(float); sharpen=none(float); scutoff=none(float); svr=none(float); smin=none(float); smax=none(float); measure=none(int); interlaced=none(int); wintype=none(int); pframe=none(int); px=none(int); py=none(int); pshow=none(int); pcutoff=none(float); pfactor=none(float); sigma2=none(float); sigma3=none(float); sigma4=none(float); degrid=none(float); dehalo=none(float); hr=none(float); ht=none(float); ncpu=none(int)):ptr VSMap =
  let plug = getPluginById("systems.innocent.fft3dfilter")
  if plug == nil:
    raise newException(ValueError, "plugin \"fft3dfilter\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq    # Convert the VSMap into a sequence
  if tmpSeq.len == 0:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()
  args.append("clip", clip)
  if sigma.isSome: args.append("sigma", sigma.get)
  if beta.isSome: args.append("beta", beta.get)
  if planes.isSome: args.set("planes", planes.get)
  if bw.isSome: args.append("bw", bw.get)
  if bh.isSome: args.append("bh", bh.get)
  if bt.isSome: args.append("bt", bt.get)
  if ow.isSome: args.append("ow", ow.get)
  if oh.isSome: args.append("oh", oh.get)
  if kratio.isSome: args.append("kratio", kratio.get)
  if sharpen.isSome: args.append("sharpen", sharpen.get)
  if scutoff.isSome: args.append("scutoff", scutoff.get)
  if svr.isSome: args.append("svr", svr.get)
  if smin.isSome: args.append("smin", smin.get)
  if smax.isSome: args.append("smax", smax.get)
  if measure.isSome: args.append("measure", measure.get)
  if interlaced.isSome: args.append("interlaced", interlaced.get)
  if wintype.isSome: args.append("wintype", wintype.get)
  if pframe.isSome: args.append("pframe", pframe.get)
  if px.isSome: args.append("px", px.get)
  if py.isSome: args.append("py", py.get)
  if pshow.isSome: args.append("pshow", pshow.get)
  if pcutoff.isSome: args.append("pcutoff", pcutoff.get)
  if pfactor.isSome: args.append("pfactor", pfactor.get)
  if sigma2.isSome: args.append("sigma2", sigma2.get)
  if sigma3.isSome: args.append("sigma3", sigma3.get)
  if sigma4.isSome: args.append("sigma4", sigma4.get)
  if degrid.isSome: args.append("degrid", degrid.get)
  if dehalo.isSome: args.append("dehalo", dehalo.get)
  if hr.isSome: args.append("hr", hr.get)
  if ht.isSome: args.append("ht", ht.get)
  if ncpu.isSome: args.append("ncpu", ncpu.get)

  result = API.invoke(plug, "FFT3DFilter".cstring, args)
  API.freeMap(args)        

