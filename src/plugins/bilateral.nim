proc Bilateral*(vsmap:ptr VSMap; `ref`= none(ptr VSNodeRef); sigmaS= none(seq[float]); sigmaR= none(seq[float]); planes= none(seq[int]); algorithm= none(seq[int]); PBFICnum= none(seq[int])):ptr VSMap =

  let plug = getPluginById("mawen1250.Bilateral")
  assert( plug != nil, "plugin \"mawen1250.Bilateral\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("clip") == 1, "the vsmap should contain one node")
  var input = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()
  args.append("input", input)
  if `ref`.isSome: args.append("ref", `ref`.get)
  if sigmaS.isSome: args.set("sigmaS", sigmaS.get)
  if sigmaR.isSome: args.set("sigmaR", sigmaR.get)
  if planes.isSome: args.set("planes", planes.get)
  if algorithm.isSome: args.set("algorithm", algorithm.get)
  if PBFICnum.isSome: args.set("PBFICnum", PBFICnum.get)

  result = API.invoke(plug, "Bilateral".cstring, args)
  API.freeMap(args)


proc Gaussian*(vsmap:ptr VSMap; sigma= none(seq[float]); sigmaV= none(seq[float])):ptr VSMap =

  let plug = getPluginById("mawen1250.Bilateral")
  assert( plug != nil, "plugin \"mawen1250.Bilateral\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("clip") == 1, "the vsmap should contain one node")
  var input = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()
  args.append("input", input)
  if sigma.isSome: args.set("sigma", sigma.get)
  if sigmaV.isSome: args.set("sigmaV", sigmaV.get)

  result = API.invoke(plug, "Gaussian".cstring, args)
  API.freeMap(args)


