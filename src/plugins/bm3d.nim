proc Basic(input:ptr VSNodeRef; ref=none(ptr VSNodeRef); profile=none(string); sigma=none(seq[float]); block_size=none(int); block_step=none(int); group_size=none(int); bm_range=none(int); bm_step=none(int); th_mse=none(float); hard_thr=none(float); matrix=none(int)):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.bm3d")
  let args = createMap()
  propSetNode(args, "input", input, paAppend)
  if ref.isSome:
    propSetNode(args, "ref", ref.get, paAppend)
  if profile.isSome:
    propSetData(args, "profile", profile.get, paAppend)
  if sigma.isSome:
    propSetFloatArray(args, "sigma", sigma.get, paAppend)
  if block_size.isSome:
    propSetInt(args, "block_size", block_size.get, paAppend)
  if block_step.isSome:
    propSetInt(args, "block_step", block_step.get, paAppend)
  if group_size.isSome:
    propSetInt(args, "group_size", group_size.get, paAppend)
  if bm_range.isSome:
    propSetInt(args, "bm_range", bm_range.get, paAppend)
  if bm_step.isSome:
    propSetInt(args, "bm_step", bm_step.get, paAppend)
  if th_mse.isSome:
    propSetFloat(args, "th_mse", th_mse.get, paAppend)
  if hard_thr.isSome:
    propSetFloat(args, "hard_thr", hard_thr.get, paAppend)
  if matrix.isSome:
    propSetInt(args, "matrix", matrix.get, paAppend)

  return API.invoke(plug, "Basic".cstring, args)        

proc Final(input:ptr VSNodeRef, ref:ptr VSNodeRef; profile=none(string); sigma=none(seq[float]); block_size=none(int); block_step=none(int); group_size=none(int); bm_range=none(int); bm_step=none(int); th_mse=none(float); matrix=none(int)):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.bm3d")
  let args = createMap()
  propSetNode(args, "input", input, paAppend)
  propSetNode(args, "ref", ref, paAppend)
  if profile.isSome:
    propSetData(args, "profile", profile.get, paAppend)
  if sigma.isSome:
    propSetFloatArray(args, "sigma", sigma.get, paAppend)
  if block_size.isSome:
    propSetInt(args, "block_size", block_size.get, paAppend)
  if block_step.isSome:
    propSetInt(args, "block_step", block_step.get, paAppend)
  if group_size.isSome:
    propSetInt(args, "group_size", group_size.get, paAppend)
  if bm_range.isSome:
    propSetInt(args, "bm_range", bm_range.get, paAppend)
  if bm_step.isSome:
    propSetInt(args, "bm_step", bm_step.get, paAppend)
  if th_mse.isSome:
    propSetFloat(args, "th_mse", th_mse.get, paAppend)
  if matrix.isSome:
    propSetInt(args, "matrix", matrix.get, paAppend)

  return API.invoke(plug, "Final".cstring, args)        

proc OPP2RGB(input:ptr VSNodeRef; sample=none(int)):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.bm3d")
  let args = createMap()
  propSetNode(args, "input", input, paAppend)
  if sample.isSome:
    propSetInt(args, "sample", sample.get, paAppend)

  return API.invoke(plug, "OPP2RGB".cstring, args)        

proc RGB2OPP(input:ptr VSNodeRef; sample=none(int)):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.bm3d")
  let args = createMap()
  propSetNode(args, "input", input, paAppend)
  if sample.isSome:
    propSetInt(args, "sample", sample.get, paAppend)

  return API.invoke(plug, "RGB2OPP".cstring, args)        

proc VAggregate(input:ptr VSNodeRef; radius=none(int); sample=none(int)):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.bm3d")
  let args = createMap()
  propSetNode(args, "input", input, paAppend)
  if radius.isSome:
    propSetInt(args, "radius", radius.get, paAppend)
  if sample.isSome:
    propSetInt(args, "sample", sample.get, paAppend)

  return API.invoke(plug, "VAggregate".cstring, args)        

proc VBasic(input:ptr VSNodeRef; ref=none(ptr VSNodeRef); profile=none(string); sigma=none(seq[float]); radius=none(int); block_size=none(int); block_step=none(int); group_size=none(int); bm_range=none(int); bm_step=none(int); ps_num=none(int); ps_range=none(int); ps_step=none(int); th_mse=none(float); hard_thr=none(float); matrix=none(int)):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.bm3d")
  let args = createMap()
  propSetNode(args, "input", input, paAppend)
  if ref.isSome:
    propSetNode(args, "ref", ref.get, paAppend)
  if profile.isSome:
    propSetData(args, "profile", profile.get, paAppend)
  if sigma.isSome:
    propSetFloatArray(args, "sigma", sigma.get, paAppend)
  if radius.isSome:
    propSetInt(args, "radius", radius.get, paAppend)
  if block_size.isSome:
    propSetInt(args, "block_size", block_size.get, paAppend)
  if block_step.isSome:
    propSetInt(args, "block_step", block_step.get, paAppend)
  if group_size.isSome:
    propSetInt(args, "group_size", group_size.get, paAppend)
  if bm_range.isSome:
    propSetInt(args, "bm_range", bm_range.get, paAppend)
  if bm_step.isSome:
    propSetInt(args, "bm_step", bm_step.get, paAppend)
  if ps_num.isSome:
    propSetInt(args, "ps_num", ps_num.get, paAppend)
  if ps_range.isSome:
    propSetInt(args, "ps_range", ps_range.get, paAppend)
  if ps_step.isSome:
    propSetInt(args, "ps_step", ps_step.get, paAppend)
  if th_mse.isSome:
    propSetFloat(args, "th_mse", th_mse.get, paAppend)
  if hard_thr.isSome:
    propSetFloat(args, "hard_thr", hard_thr.get, paAppend)
  if matrix.isSome:
    propSetInt(args, "matrix", matrix.get, paAppend)

  return API.invoke(plug, "VBasic".cstring, args)        

proc VFinal(input:ptr VSNodeRef, ref:ptr VSNodeRef; profile=none(string); sigma=none(seq[float]); radius=none(int); block_size=none(int); block_step=none(int); group_size=none(int); bm_range=none(int); bm_step=none(int); ps_num=none(int); ps_range=none(int); ps_step=none(int); th_mse=none(float); matrix=none(int)):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.bm3d")
  let args = createMap()
  propSetNode(args, "input", input, paAppend)
  propSetNode(args, "ref", ref, paAppend)
  if profile.isSome:
    propSetData(args, "profile", profile.get, paAppend)
  if sigma.isSome:
    propSetFloatArray(args, "sigma", sigma.get, paAppend)
  if radius.isSome:
    propSetInt(args, "radius", radius.get, paAppend)
  if block_size.isSome:
    propSetInt(args, "block_size", block_size.get, paAppend)
  if block_step.isSome:
    propSetInt(args, "block_step", block_step.get, paAppend)
  if group_size.isSome:
    propSetInt(args, "group_size", group_size.get, paAppend)
  if bm_range.isSome:
    propSetInt(args, "bm_range", bm_range.get, paAppend)
  if bm_step.isSome:
    propSetInt(args, "bm_step", bm_step.get, paAppend)
  if ps_num.isSome:
    propSetInt(args, "ps_num", ps_num.get, paAppend)
  if ps_range.isSome:
    propSetInt(args, "ps_range", ps_range.get, paAppend)
  if ps_step.isSome:
    propSetInt(args, "ps_step", ps_step.get, paAppend)
  if th_mse.isSome:
    propSetFloat(args, "th_mse", th_mse.get, paAppend)
  if matrix.isSome:
    propSetInt(args, "matrix", matrix.get, paAppend)

  return API.invoke(plug, "VFinal".cstring, args)        

