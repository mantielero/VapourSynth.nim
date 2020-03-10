proc Bilateral(input:ptr VSNodeRef; ref=none(ptr VSNodeRef); sigmaS=none(seq[float]); sigmaR=none(seq[float]); planes=none(seq[int]); algorithm=none(seq[int]); PBFICnum=none(seq[int])):ptr VSMap =
  let plug = getPluginById("mawen1250.Bilateral")
  let args = createMap()
  propSetNode(args, "input", input, paAppend)
  if ref.isSome:
    propSetNode(args, "ref", ref.get, paAppend)
  if sigmaS.isSome:
    propSetFloatArray(args, "sigmaS", sigmaS.get, paAppend)
  if sigmaR.isSome:
    propSetFloatArray(args, "sigmaR", sigmaR.get, paAppend)
  if planes.isSome:
    propSetIntArray(args, "planes", planes.get, paAppend)
  if algorithm.isSome:
    propSetIntArray(args, "algorithm", algorithm.get, paAppend)
  if PBFICnum.isSome:
    propSetIntArray(args, "PBFICnum", PBFICnum.get, paAppend)

  return API.invoke(plug, "Bilateral".cstring, args)        

proc Gaussian(input:ptr VSNodeRef; sigma=none(seq[float]); sigmaV=none(seq[float])):ptr VSMap =
  let plug = getPluginById("mawen1250.Bilateral")
  let args = createMap()
  propSetNode(args, "input", input, paAppend)
  if sigma.isSome:
    propSetFloatArray(args, "sigma", sigma.get, paAppend)
  if sigmaV.isSome:
    propSetFloatArray(args, "sigmaV", sigmaV.get, paAppend)

  return API.invoke(plug, "Gaussian".cstring, args)        

