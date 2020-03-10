proc DFTTest(clip:ptr VSNodeRef; ftype=none(int); sigma=none(float); sigma2=none(float); pmin=none(float); pmax=none(float); sbsize=none(int); smode=none(int); sosize=none(int); tbsize=none(int); tmode=none(int); tosize=none(int); swin=none(int); twin=none(int); sbeta=none(float); tbeta=none(float); zmean=none(int); f0beta=none(float); nlocation=none(seq[int]); alpha=none(float); slocation=none(seq[float]); ssx=none(seq[float]); ssy=none(seq[float]); sst=none(seq[float]); ssystem=none(int); planes=none(seq[int]); opt=none(int)):ptr VSMap =
  let plug = getPluginById("com.holywu.dfttest")
  let args = createMap()
  propSetNode(args, "clip", clip, paAppend)
  if ftype.isSome:
    propSetInt(args, "ftype", ftype.get, paAppend)
  if sigma.isSome:
    propSetFloat(args, "sigma", sigma.get, paAppend)
  if sigma2.isSome:
    propSetFloat(args, "sigma2", sigma2.get, paAppend)
  if pmin.isSome:
    propSetFloat(args, "pmin", pmin.get, paAppend)
  if pmax.isSome:
    propSetFloat(args, "pmax", pmax.get, paAppend)
  if sbsize.isSome:
    propSetInt(args, "sbsize", sbsize.get, paAppend)
  if smode.isSome:
    propSetInt(args, "smode", smode.get, paAppend)
  if sosize.isSome:
    propSetInt(args, "sosize", sosize.get, paAppend)
  if tbsize.isSome:
    propSetInt(args, "tbsize", tbsize.get, paAppend)
  if tmode.isSome:
    propSetInt(args, "tmode", tmode.get, paAppend)
  if tosize.isSome:
    propSetInt(args, "tosize", tosize.get, paAppend)
  if swin.isSome:
    propSetInt(args, "swin", swin.get, paAppend)
  if twin.isSome:
    propSetInt(args, "twin", twin.get, paAppend)
  if sbeta.isSome:
    propSetFloat(args, "sbeta", sbeta.get, paAppend)
  if tbeta.isSome:
    propSetFloat(args, "tbeta", tbeta.get, paAppend)
  if zmean.isSome:
    propSetInt(args, "zmean", zmean.get, paAppend)
  if f0beta.isSome:
    propSetFloat(args, "f0beta", f0beta.get, paAppend)
  if nlocation.isSome:
    propSetIntArray(args, "nlocation", nlocation.get, paAppend)
  if alpha.isSome:
    propSetFloat(args, "alpha", alpha.get, paAppend)
  if slocation.isSome:
    propSetFloatArray(args, "slocation", slocation.get, paAppend)
  if ssx.isSome:
    propSetFloatArray(args, "ssx", ssx.get, paAppend)
  if ssy.isSome:
    propSetFloatArray(args, "ssy", ssy.get, paAppend)
  if sst.isSome:
    propSetFloatArray(args, "sst", sst.get, paAppend)
  if ssystem.isSome:
    propSetInt(args, "ssystem", ssystem.get, paAppend)
  if planes.isSome:
    propSetIntArray(args, "planes", planes.get, paAppend)
  if opt.isSome:
    propSetInt(args, "opt", opt.get, paAppend)

  return API.invoke(plug, "DFTTest".cstring, args)        

