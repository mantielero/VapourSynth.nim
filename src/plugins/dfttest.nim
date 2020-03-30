proc DFTTest*(vsmap:ptr VSMap; ftype=none(int); sigma=none(float); sigma2=none(float); pmin=none(float); pmax=none(float); sbsize=none(int); smode=none(int); sosize=none(int); tbsize=none(int); tmode=none(int); tosize=none(int); swin=none(int); twin=none(int); sbeta=none(float); tbeta=none(float); zmean=none(int); f0beta=none(float); nlocation=none(seq[int]); alpha=none(float); slocation=none(seq[float]); ssx=none(seq[float]); ssy=none(seq[float]); sst=none(seq[float]); ssystem=none(int); planes=none(seq[int]); opt=none(int)):ptr VSMap =
  let plug = getPluginById("com.holywu.dfttest")
  if plug == nil:
    raise newException(ValueError, "plugin \"dfttest\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq    # Convert the VSMap into a sequence
  if tmpSeq.len == 0:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()
  args.append("clip", clip)
  if ftype.isSome: args.append("ftype", ftype.get)
  if sigma.isSome: args.append("sigma", sigma.get)
  if sigma2.isSome: args.append("sigma2", sigma2.get)
  if pmin.isSome: args.append("pmin", pmin.get)
  if pmax.isSome: args.append("pmax", pmax.get)
  if sbsize.isSome: args.append("sbsize", sbsize.get)
  if smode.isSome: args.append("smode", smode.get)
  if sosize.isSome: args.append("sosize", sosize.get)
  if tbsize.isSome: args.append("tbsize", tbsize.get)
  if tmode.isSome: args.append("tmode", tmode.get)
  if tosize.isSome: args.append("tosize", tosize.get)
  if swin.isSome: args.append("swin", swin.get)
  if twin.isSome: args.append("twin", twin.get)
  if sbeta.isSome: args.append("sbeta", sbeta.get)
  if tbeta.isSome: args.append("tbeta", tbeta.get)
  if zmean.isSome: args.append("zmean", zmean.get)
  if f0beta.isSome: args.append("f0beta", f0beta.get)
  if nlocation.isSome: args.set("nlocation", nlocation.get)
  if alpha.isSome: args.append("alpha", alpha.get)
  if slocation.isSome: args.set("slocation", slocation.get)
  if ssx.isSome: args.set("ssx", ssx.get)
  if ssy.isSome: args.set("ssy", ssy.get)
  if sst.isSome: args.set("sst", sst.get)
  if ssystem.isSome: args.append("ssystem", ssystem.get)
  if planes.isSome: args.set("planes", planes.get)
  if opt.isSome: args.append("opt", opt.get)

  result = API.invoke(plug, "DFTTest".cstring, args)
  API.freeMap(args)        

