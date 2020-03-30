proc Basic*(vsmap:ptr VSMap; `ref`=none(ptr VSNodeRef); profile=none(string); sigma=none(seq[float]); block_size=none(int); block_step=none(int); group_size=none(int); bm_range=none(int); bm_step=none(int); th_mse=none(float); hard_thr=none(float); matrix=none(int)):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.bm3d")
  if plug == nil:
    raise newException(ValueError, "plugin \"bm3d\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq    # Convert the VSMap into a sequence
  if tmpSeq.len == 0:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var input = tmpSeq[0].nodes[0]


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()
  args.append("input", input)
  if `ref`.isSome: args.append("ref", `ref`.get)
  if profile.isSome: args.append("profile", profile.get)
  if sigma.isSome: args.set("sigma", sigma.get)
  if block_size.isSome: args.append("block_size", block_size.get)
  if block_step.isSome: args.append("block_step", block_step.get)
  if group_size.isSome: args.append("group_size", group_size.get)
  if bm_range.isSome: args.append("bm_range", bm_range.get)
  if bm_step.isSome: args.append("bm_step", bm_step.get)
  if th_mse.isSome: args.append("th_mse", th_mse.get)
  if hard_thr.isSome: args.append("hard_thr", hard_thr.get)
  if matrix.isSome: args.append("matrix", matrix.get)

  result = API.invoke(plug, "Basic".cstring, args)
  API.freeMap(args)        

proc Final*(vsmap:ptr VSMap, `ref`:ptr VSNodeRef; profile=none(string); sigma=none(seq[float]); block_size=none(int); block_step=none(int); group_size=none(int); bm_range=none(int); bm_step=none(int); th_mse=none(float); matrix=none(int)):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.bm3d")
  if plug == nil:
    raise newException(ValueError, "plugin \"bm3d\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq    # Convert the VSMap into a sequence
  if tmpSeq.len == 0:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var input = tmpSeq[0].nodes[0]


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()
  args.append("input", input)
  args.append("ref", `ref`)
  if profile.isSome: args.append("profile", profile.get)
  if sigma.isSome: args.set("sigma", sigma.get)
  if block_size.isSome: args.append("block_size", block_size.get)
  if block_step.isSome: args.append("block_step", block_step.get)
  if group_size.isSome: args.append("group_size", group_size.get)
  if bm_range.isSome: args.append("bm_range", bm_range.get)
  if bm_step.isSome: args.append("bm_step", bm_step.get)
  if th_mse.isSome: args.append("th_mse", th_mse.get)
  if matrix.isSome: args.append("matrix", matrix.get)

  result = API.invoke(plug, "Final".cstring, args)
  API.freeMap(args)        

proc OPP2RGB*(vsmap:ptr VSMap; sample=none(int)):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.bm3d")
  if plug == nil:
    raise newException(ValueError, "plugin \"bm3d\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq    # Convert the VSMap into a sequence
  if tmpSeq.len == 0:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var input = tmpSeq[0].nodes[0]


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()
  args.append("input", input)
  if sample.isSome: args.append("sample", sample.get)

  result = API.invoke(plug, "OPP2RGB".cstring, args)
  API.freeMap(args)        

proc RGB2OPP*(vsmap:ptr VSMap; sample=none(int)):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.bm3d")
  if plug == nil:
    raise newException(ValueError, "plugin \"bm3d\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq    # Convert the VSMap into a sequence
  if tmpSeq.len == 0:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var input = tmpSeq[0].nodes[0]


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()
  args.append("input", input)
  if sample.isSome: args.append("sample", sample.get)

  result = API.invoke(plug, "RGB2OPP".cstring, args)
  API.freeMap(args)        

proc VAggregate*(vsmap:ptr VSMap; radius=none(int); sample=none(int)):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.bm3d")
  if plug == nil:
    raise newException(ValueError, "plugin \"bm3d\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq    # Convert the VSMap into a sequence
  if tmpSeq.len == 0:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var input = tmpSeq[0].nodes[0]


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()
  args.append("input", input)
  if radius.isSome: args.append("radius", radius.get)
  if sample.isSome: args.append("sample", sample.get)

  result = API.invoke(plug, "VAggregate".cstring, args)
  API.freeMap(args)        

proc VBasic*(vsmap:ptr VSMap; `ref`=none(ptr VSNodeRef); profile=none(string); sigma=none(seq[float]); radius=none(int); block_size=none(int); block_step=none(int); group_size=none(int); bm_range=none(int); bm_step=none(int); ps_num=none(int); ps_range=none(int); ps_step=none(int); th_mse=none(float); hard_thr=none(float); matrix=none(int)):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.bm3d")
  if plug == nil:
    raise newException(ValueError, "plugin \"bm3d\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq    # Convert the VSMap into a sequence
  if tmpSeq.len == 0:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var input = tmpSeq[0].nodes[0]


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()
  args.append("input", input)
  if `ref`.isSome: args.append("ref", `ref`.get)
  if profile.isSome: args.append("profile", profile.get)
  if sigma.isSome: args.set("sigma", sigma.get)
  if radius.isSome: args.append("radius", radius.get)
  if block_size.isSome: args.append("block_size", block_size.get)
  if block_step.isSome: args.append("block_step", block_step.get)
  if group_size.isSome: args.append("group_size", group_size.get)
  if bm_range.isSome: args.append("bm_range", bm_range.get)
  if bm_step.isSome: args.append("bm_step", bm_step.get)
  if ps_num.isSome: args.append("ps_num", ps_num.get)
  if ps_range.isSome: args.append("ps_range", ps_range.get)
  if ps_step.isSome: args.append("ps_step", ps_step.get)
  if th_mse.isSome: args.append("th_mse", th_mse.get)
  if hard_thr.isSome: args.append("hard_thr", hard_thr.get)
  if matrix.isSome: args.append("matrix", matrix.get)

  result = API.invoke(plug, "VBasic".cstring, args)
  API.freeMap(args)        

proc VFinal*(vsmap:ptr VSMap, `ref`:ptr VSNodeRef; profile=none(string); sigma=none(seq[float]); radius=none(int); block_size=none(int); block_step=none(int); group_size=none(int); bm_range=none(int); bm_step=none(int); ps_num=none(int); ps_range=none(int); ps_step=none(int); th_mse=none(float); matrix=none(int)):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.bm3d")
  if plug == nil:
    raise newException(ValueError, "plugin \"bm3d\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq    # Convert the VSMap into a sequence
  if tmpSeq.len == 0:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var input = tmpSeq[0].nodes[0]


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()
  args.append("input", input)
  args.append("ref", `ref`)
  if profile.isSome: args.append("profile", profile.get)
  if sigma.isSome: args.set("sigma", sigma.get)
  if radius.isSome: args.append("radius", radius.get)
  if block_size.isSome: args.append("block_size", block_size.get)
  if block_step.isSome: args.append("block_step", block_step.get)
  if group_size.isSome: args.append("group_size", group_size.get)
  if bm_range.isSome: args.append("bm_range", bm_range.get)
  if bm_step.isSome: args.append("bm_step", bm_step.get)
  if ps_num.isSome: args.append("ps_num", ps_num.get)
  if ps_range.isSome: args.append("ps_range", ps_range.get)
  if ps_step.isSome: args.append("ps_step", ps_step.get)
  if th_mse.isSome: args.append("th_mse", th_mse.get)
  if matrix.isSome: args.append("matrix", matrix.get)

  result = API.invoke(plug, "VFinal".cstring, args)
  API.freeMap(args)        

