proc bitdepth*(vsmap:ptr VSMap; csp=none(int); bits=none(int); flt=none(int); planes=none(seq[int]); fulls=none(int); fulld=none(int); dmode=none(int); ampo=none(float); ampn=none(float); dyn=none(int); staticnoise=none(int); cpuopt=none(int); patsize=none(int)):ptr VSMap =
  let plug = getPluginById("fmtconv")
  if plug == nil:
    raise newException(ValueError, "plugin \"fmtc\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq
  if tmpSeq.len != 1:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  let args = createMap()
  propSetNode(args, "clip", clip, paAppend)
  if csp.isSome:
    propSetInt(args, "csp", csp.get, paAppend)
  if bits.isSome:
    propSetInt(args, "bits", bits.get, paAppend)
  if flt.isSome:
    propSetInt(args, "flt", flt.get, paAppend)
  if planes.isSome:
    propSetIntArray(args, "planes", planes.get)
  if fulls.isSome:
    propSetInt(args, "fulls", fulls.get, paAppend)
  if fulld.isSome:
    propSetInt(args, "fulld", fulld.get, paAppend)
  if dmode.isSome:
    propSetInt(args, "dmode", dmode.get, paAppend)
  if ampo.isSome:
    propSetFloat(args, "ampo", ampo.get, paAppend)
  if ampn.isSome:
    propSetFloat(args, "ampn", ampn.get, paAppend)
  if dyn.isSome:
    propSetInt(args, "dyn", dyn.get, paAppend)
  if staticnoise.isSome:
    propSetInt(args, "staticnoise", staticnoise.get, paAppend)
  if cpuopt.isSome:
    propSetInt(args, "cpuopt", cpuopt.get, paAppend)
  if patsize.isSome:
    propSetInt(args, "patsize", patsize.get, paAppend)

  return API.invoke(plug, "bitdepth".cstring, args)        

proc histluma*(vsmap:ptr VSMap; full=none(int); amp=none(int)):ptr VSMap =
  let plug = getPluginById("fmtconv")
  if plug == nil:
    raise newException(ValueError, "plugin \"fmtc\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq
  if tmpSeq.len != 1:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  let args = createMap()
  propSetNode(args, "clip", clip, paAppend)
  if full.isSome:
    propSetInt(args, "full", full.get, paAppend)
  if amp.isSome:
    propSetInt(args, "amp", amp.get, paAppend)

  return API.invoke(plug, "histluma".cstring, args)        

proc matrix*(vsmap:ptr VSMap; mat=none(string); mats=none(string); matd=none(string); fulls=none(int); fulld=none(int); coef=none(seq[float]); csp=none(int); col_fam=none(int); bits=none(int); singleout=none(int); cpuopt=none(int)):ptr VSMap =
  let plug = getPluginById("fmtconv")
  if plug == nil:
    raise newException(ValueError, "plugin \"fmtc\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq
  if tmpSeq.len != 1:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  let args = createMap()
  propSetNode(args, "clip", clip, paAppend)
  if mat.isSome:
    propSetData(args, "mat", mat.get, paAppend)
  if mats.isSome:
    propSetData(args, "mats", mats.get, paAppend)
  if matd.isSome:
    propSetData(args, "matd", matd.get, paAppend)
  if fulls.isSome:
    propSetInt(args, "fulls", fulls.get, paAppend)
  if fulld.isSome:
    propSetInt(args, "fulld", fulld.get, paAppend)
  if coef.isSome:
    propSetFloatArray(args, "coef", coef.get)
  if csp.isSome:
    propSetInt(args, "csp", csp.get, paAppend)
  if col_fam.isSome:
    propSetInt(args, "col_fam", col_fam.get, paAppend)
  if bits.isSome:
    propSetInt(args, "bits", bits.get, paAppend)
  if singleout.isSome:
    propSetInt(args, "singleout", singleout.get, paAppend)
  if cpuopt.isSome:
    propSetInt(args, "cpuopt", cpuopt.get, paAppend)

  return API.invoke(plug, "matrix".cstring, args)        

proc matrix2020cl*(vsmap:ptr VSMap; full=none(int); csp=none(int); bits=none(int); cpuopt=none(int)):ptr VSMap =
  let plug = getPluginById("fmtconv")
  if plug == nil:
    raise newException(ValueError, "plugin \"fmtc\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq
  if tmpSeq.len != 1:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  let args = createMap()
  propSetNode(args, "clip", clip, paAppend)
  if full.isSome:
    propSetInt(args, "full", full.get, paAppend)
  if csp.isSome:
    propSetInt(args, "csp", csp.get, paAppend)
  if bits.isSome:
    propSetInt(args, "bits", bits.get, paAppend)
  if cpuopt.isSome:
    propSetInt(args, "cpuopt", cpuopt.get, paAppend)

  return API.invoke(plug, "matrix2020cl".cstring, args)        

proc nativetostack16*(vsmap:ptr VSMap):ptr VSMap =
  let plug = getPluginById("fmtconv")
  if plug == nil:
    raise newException(ValueError, "plugin \"fmtc\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq
  if tmpSeq.len != 1:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  let args = createMap()
  propSetNode(args, "clip", clip, paAppend)

  return API.invoke(plug, "nativetostack16".cstring, args)        

proc primaries*(vsmap:ptr VSMap; rs=none(seq[float]); gs=none(seq[float]); bs=none(seq[float]); ws=none(seq[float]); rd=none(seq[float]); gd=none(seq[float]); bd=none(seq[float]); wd=none(seq[float]); prims=none(string); primd=none(string); cpuopt=none(int)):ptr VSMap =
  let plug = getPluginById("fmtconv")
  if plug == nil:
    raise newException(ValueError, "plugin \"fmtc\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq
  if tmpSeq.len != 1:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  let args = createMap()
  propSetNode(args, "clip", clip, paAppend)
  if rs.isSome:
    propSetFloatArray(args, "rs", rs.get)
  if gs.isSome:
    propSetFloatArray(args, "gs", gs.get)
  if bs.isSome:
    propSetFloatArray(args, "bs", bs.get)
  if ws.isSome:
    propSetFloatArray(args, "ws", ws.get)
  if rd.isSome:
    propSetFloatArray(args, "rd", rd.get)
  if gd.isSome:
    propSetFloatArray(args, "gd", gd.get)
  if bd.isSome:
    propSetFloatArray(args, "bd", bd.get)
  if wd.isSome:
    propSetFloatArray(args, "wd", wd.get)
  if prims.isSome:
    propSetData(args, "prims", prims.get, paAppend)
  if primd.isSome:
    propSetData(args, "primd", primd.get, paAppend)
  if cpuopt.isSome:
    propSetInt(args, "cpuopt", cpuopt.get, paAppend)

  return API.invoke(plug, "primaries".cstring, args)        

proc resample*(vsmap:ptr VSMap; w=none(int); h=none(int); sx=none(seq[float]); sy=none(seq[float]); sw=none(seq[float]); sh=none(seq[float]); scale=none(float); scaleh=none(float); scalev=none(float); kernel=none(seq[string]); kernelh=none(seq[string]); kernelv=none(seq[string]); impulse=none(seq[float]); impulseh=none(seq[float]); impulsev=none(seq[float]); taps=none(seq[int]); tapsh=none(seq[int]); tapsv=none(seq[int]); a1=none(seq[float]); a2=none(seq[float]); a3=none(seq[float]); kovrspl=none(seq[int]); fh=none(seq[float]); fv=none(seq[float]); cnorm=none(seq[int]); totalh=none(seq[float]); totalv=none(seq[float]); invks=none(seq[int]); invksh=none(seq[int]); invksv=none(seq[int]); invkstaps=none(seq[int]); invkstapsh=none(seq[int]); invkstapsv=none(seq[int]); csp=none(int); css=none(string); planes=none(seq[float]); fulls=none(int); fulld=none(int); center=none(seq[int]); cplace=none(string); cplaces=none(string); cplaced=none(string); interlaced=none(int); interlacedd=none(int); tff=none(int); tffd=none(int); flt=none(int); cpuopt=none(int)):ptr VSMap =
  let plug = getPluginById("fmtconv")
  if plug == nil:
    raise newException(ValueError, "plugin \"fmtc\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq
  if tmpSeq.len != 1:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  let args = createMap()
  propSetNode(args, "clip", clip, paAppend)
  if w.isSome:
    propSetInt(args, "w", w.get, paAppend)
  if h.isSome:
    propSetInt(args, "h", h.get, paAppend)
  if sx.isSome:
    propSetFloatArray(args, "sx", sx.get)
  if sy.isSome:
    propSetFloatArray(args, "sy", sy.get)
  if sw.isSome:
    propSetFloatArray(args, "sw", sw.get)
  if sh.isSome:
    propSetFloatArray(args, "sh", sh.get)
  if scale.isSome:
    propSetFloat(args, "scale", scale.get, paAppend)
  if scaleh.isSome:
    propSetFloat(args, "scaleh", scaleh.get, paAppend)
  if scalev.isSome:
    propSetFloat(args, "scalev", scalev.get, paAppend)
  if kernel.isSome:
    for item in kernel.get:
      propSetData(args, "kernel", item, paAppend)
  if kernelh.isSome:
    for item in kernelh.get:
      propSetData(args, "kernelh", item, paAppend)
  if kernelv.isSome:
    for item in kernelv.get:
      propSetData(args, "kernelv", item, paAppend)
  if impulse.isSome:
    propSetFloatArray(args, "impulse", impulse.get)
  if impulseh.isSome:
    propSetFloatArray(args, "impulseh", impulseh.get)
  if impulsev.isSome:
    propSetFloatArray(args, "impulsev", impulsev.get)
  if taps.isSome:
    propSetIntArray(args, "taps", taps.get)
  if tapsh.isSome:
    propSetIntArray(args, "tapsh", tapsh.get)
  if tapsv.isSome:
    propSetIntArray(args, "tapsv", tapsv.get)
  if a1.isSome:
    propSetFloatArray(args, "a1", a1.get)
  if a2.isSome:
    propSetFloatArray(args, "a2", a2.get)
  if a3.isSome:
    propSetFloatArray(args, "a3", a3.get)
  if kovrspl.isSome:
    propSetIntArray(args, "kovrspl", kovrspl.get)
  if fh.isSome:
    propSetFloatArray(args, "fh", fh.get)
  if fv.isSome:
    propSetFloatArray(args, "fv", fv.get)
  if cnorm.isSome:
    propSetIntArray(args, "cnorm", cnorm.get)
  if totalh.isSome:
    propSetFloatArray(args, "totalh", totalh.get)
  if totalv.isSome:
    propSetFloatArray(args, "totalv", totalv.get)
  if invks.isSome:
    propSetIntArray(args, "invks", invks.get)
  if invksh.isSome:
    propSetIntArray(args, "invksh", invksh.get)
  if invksv.isSome:
    propSetIntArray(args, "invksv", invksv.get)
  if invkstaps.isSome:
    propSetIntArray(args, "invkstaps", invkstaps.get)
  if invkstapsh.isSome:
    propSetIntArray(args, "invkstapsh", invkstapsh.get)
  if invkstapsv.isSome:
    propSetIntArray(args, "invkstapsv", invkstapsv.get)
  if csp.isSome:
    propSetInt(args, "csp", csp.get, paAppend)
  if css.isSome:
    propSetData(args, "css", css.get, paAppend)
  if planes.isSome:
    propSetFloatArray(args, "planes", planes.get)
  if fulls.isSome:
    propSetInt(args, "fulls", fulls.get, paAppend)
  if fulld.isSome:
    propSetInt(args, "fulld", fulld.get, paAppend)
  if center.isSome:
    propSetIntArray(args, "center", center.get)
  if cplace.isSome:
    propSetData(args, "cplace", cplace.get, paAppend)
  if cplaces.isSome:
    propSetData(args, "cplaces", cplaces.get, paAppend)
  if cplaced.isSome:
    propSetData(args, "cplaced", cplaced.get, paAppend)
  if interlaced.isSome:
    propSetInt(args, "interlaced", interlaced.get, paAppend)
  if interlacedd.isSome:
    propSetInt(args, "interlacedd", interlacedd.get, paAppend)
  if tff.isSome:
    propSetInt(args, "tff", tff.get, paAppend)
  if tffd.isSome:
    propSetInt(args, "tffd", tffd.get, paAppend)
  if flt.isSome:
    propSetInt(args, "flt", flt.get, paAppend)
  if cpuopt.isSome:
    propSetInt(args, "cpuopt", cpuopt.get, paAppend)

  return API.invoke(plug, "resample".cstring, args)        

proc stack16tonative*(vsmap:ptr VSMap):ptr VSMap =
  let plug = getPluginById("fmtconv")
  if plug == nil:
    raise newException(ValueError, "plugin \"fmtc\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq
  if tmpSeq.len != 1:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  let args = createMap()
  propSetNode(args, "clip", clip, paAppend)

  return API.invoke(plug, "stack16tonative".cstring, args)        

proc transfer*(vsmap:ptr VSMap; transs=none(seq[string]); transd=none(seq[string]); cont=none(float); gcor=none(float); bits=none(int); flt=none(int); fulls=none(int); fulld=none(int); cpuopt=none(int); blacklvl=none(float)):ptr VSMap =
  let plug = getPluginById("fmtconv")
  if plug == nil:
    raise newException(ValueError, "plugin \"fmtc\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq
  if tmpSeq.len != 1:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  let args = createMap()
  propSetNode(args, "clip", clip, paAppend)
  if transs.isSome:
    for item in transs.get:
      propSetData(args, "transs", item, paAppend)
  if transd.isSome:
    for item in transd.get:
      propSetData(args, "transd", item, paAppend)
  if cont.isSome:
    propSetFloat(args, "cont", cont.get, paAppend)
  if gcor.isSome:
    propSetFloat(args, "gcor", gcor.get, paAppend)
  if bits.isSome:
    propSetInt(args, "bits", bits.get, paAppend)
  if flt.isSome:
    propSetInt(args, "flt", flt.get, paAppend)
  if fulls.isSome:
    propSetInt(args, "fulls", fulls.get, paAppend)
  if fulld.isSome:
    propSetInt(args, "fulld", fulld.get, paAppend)
  if cpuopt.isSome:
    propSetInt(args, "cpuopt", cpuopt.get, paAppend)
  if blacklvl.isSome:
    propSetFloat(args, "blacklvl", blacklvl.get, paAppend)

  return API.invoke(plug, "transfer".cstring, args)        

