proc Bilateral*(vsmap:ptr VSMap; `ref`=none(ptr VSNodeRef); sigmaS=none(seq[float]); sigmaR=none(seq[float]); planes=none(seq[int]); algorithm=none(seq[int]); PBFICnum=none(seq[int])):ptr VSMap =
  let plug = getPluginById("mawen1250.Bilateral")
  if plug == nil:
    raise newException(ValueError, "plugin \"bilateral\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq
  if tmpSeq.len != 1:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var input = tmpSeq[0].nodes[0]


  let args = createMap()
  propSetNode(args, "input", input, paAppend)
  if `ref`.isSome:
    propSetNode(args, "ref", `ref`.get, paAppend)
  if sigmaS.isSome:
    propSetFloatArray(args, "sigmaS", sigmaS.get)
  if sigmaR.isSome:
    propSetFloatArray(args, "sigmaR", sigmaR.get)
  if planes.isSome:
    propSetIntArray(args, "planes", planes.get)
  if algorithm.isSome:
    propSetIntArray(args, "algorithm", algorithm.get)
  if PBFICnum.isSome:
    propSetIntArray(args, "PBFICnum", PBFICnum.get)

  return API.invoke(plug, "Bilateral".cstring, args)        

proc Gaussian*(vsmap:ptr VSMap; sigma=none(seq[float]); sigmaV=none(seq[float])):ptr VSMap =
  let plug = getPluginById("mawen1250.Bilateral")
  if plug == nil:
    raise newException(ValueError, "plugin \"bilateral\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq
  if tmpSeq.len != 1:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var input = tmpSeq[0].nodes[0]


  let args = createMap()
  propSetNode(args, "input", input, paAppend)
  if sigma.isSome:
    propSetFloatArray(args, "sigma", sigma.get)
  if sigmaV.isSome:
    propSetFloatArray(args, "sigmaV", sigmaV.get)

  return API.invoke(plug, "Gaussian".cstring, args)        

