proc bitdepth*(vsmap:ptr VSMap; csp=none(int); bits=none(int); flt=none(int); planes=none(seq[int]); fulls=none(int); fulld=none(int); dmode=none(int); ampo=none(float); ampn=none(float); dyn=none(int); staticnoise=none(int); cpuopt=none(int); patsize=none(int)):ptr VSMap =
  let plug = getPluginById("fmtconv")
  if plug == nil:
    raise newException(ValueError, "plugin \"fmtc\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq    # Convert the VSMap into a sequence
  if tmpSeq.len == 0:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()
  args.append("clip", clip)
  if csp.isSome: args.append("csp", csp.get)
  if bits.isSome: args.append("bits", bits.get)
  if flt.isSome: args.append("flt", flt.get)
  if planes.isSome: args.set("planes", planes.get)
  if fulls.isSome: args.append("fulls", fulls.get)
  if fulld.isSome: args.append("fulld", fulld.get)
  if dmode.isSome: args.append("dmode", dmode.get)
  if ampo.isSome: args.append("ampo", ampo.get)
  if ampn.isSome: args.append("ampn", ampn.get)
  if dyn.isSome: args.append("dyn", dyn.get)
  if staticnoise.isSome: args.append("staticnoise", staticnoise.get)
  if cpuopt.isSome: args.append("cpuopt", cpuopt.get)
  if patsize.isSome: args.append("patsize", patsize.get)

  result = API.invoke(plug, "bitdepth".cstring, args)
  API.freeMap(args)        

proc histluma*(vsmap:ptr VSMap; full=none(int); amp=none(int)):ptr VSMap =
  let plug = getPluginById("fmtconv")
  if plug == nil:
    raise newException(ValueError, "plugin \"fmtc\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq    # Convert the VSMap into a sequence
  if tmpSeq.len == 0:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()
  args.append("clip", clip)
  if full.isSome: args.append("full", full.get)
  if amp.isSome: args.append("amp", amp.get)

  result = API.invoke(plug, "histluma".cstring, args)
  API.freeMap(args)        

proc matrix*(vsmap:ptr VSMap; mat=none(string); mats=none(string); matd=none(string); fulls=none(int); fulld=none(int); coef=none(seq[float]); csp=none(int); col_fam=none(int); bits=none(int); singleout=none(int); cpuopt=none(int)):ptr VSMap =
  let plug = getPluginById("fmtconv")
  if plug == nil:
    raise newException(ValueError, "plugin \"fmtc\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq    # Convert the VSMap into a sequence
  if tmpSeq.len == 0:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()
  args.append("clip", clip)
  if mat.isSome: args.append("mat", mat.get)
  if mats.isSome: args.append("mats", mats.get)
  if matd.isSome: args.append("matd", matd.get)
  if fulls.isSome: args.append("fulls", fulls.get)
  if fulld.isSome: args.append("fulld", fulld.get)
  if coef.isSome: args.set("coef", coef.get)
  if csp.isSome: args.append("csp", csp.get)
  if col_fam.isSome: args.append("col_fam", col_fam.get)
  if bits.isSome: args.append("bits", bits.get)
  if singleout.isSome: args.append("singleout", singleout.get)
  if cpuopt.isSome: args.append("cpuopt", cpuopt.get)

  result = API.invoke(plug, "matrix".cstring, args)
  API.freeMap(args)        

proc matrix2020cl*(vsmap:ptr VSMap; full=none(int); csp=none(int); bits=none(int); cpuopt=none(int)):ptr VSMap =
  let plug = getPluginById("fmtconv")
  if plug == nil:
    raise newException(ValueError, "plugin \"fmtc\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq    # Convert the VSMap into a sequence
  if tmpSeq.len == 0:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()
  args.append("clip", clip)
  if full.isSome: args.append("full", full.get)
  if csp.isSome: args.append("csp", csp.get)
  if bits.isSome: args.append("bits", bits.get)
  if cpuopt.isSome: args.append("cpuopt", cpuopt.get)

  result = API.invoke(plug, "matrix2020cl".cstring, args)
  API.freeMap(args)        

proc nativetostack16*(vsmap:ptr VSMap):ptr VSMap =
  let plug = getPluginById("fmtconv")
  if plug == nil:
    raise newException(ValueError, "plugin \"fmtc\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq    # Convert the VSMap into a sequence
  if tmpSeq.len == 0:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()
  args.append("clip", clip)

  result = API.invoke(plug, "nativetostack16".cstring, args)
  API.freeMap(args)        

proc primaries*(vsmap:ptr VSMap; rs=none(seq[float]); gs=none(seq[float]); bs=none(seq[float]); ws=none(seq[float]); rd=none(seq[float]); gd=none(seq[float]); bd=none(seq[float]); wd=none(seq[float]); prims=none(string); primd=none(string); cpuopt=none(int)):ptr VSMap =
  let plug = getPluginById("fmtconv")
  if plug == nil:
    raise newException(ValueError, "plugin \"fmtc\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq    # Convert the VSMap into a sequence
  if tmpSeq.len == 0:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()
  args.append("clip", clip)
  if rs.isSome: args.set("rs", rs.get)
  if gs.isSome: args.set("gs", gs.get)
  if bs.isSome: args.set("bs", bs.get)
  if ws.isSome: args.set("ws", ws.get)
  if rd.isSome: args.set("rd", rd.get)
  if gd.isSome: args.set("gd", gd.get)
  if bd.isSome: args.set("bd", bd.get)
  if wd.isSome: args.set("wd", wd.get)
  if prims.isSome: args.append("prims", prims.get)
  if primd.isSome: args.append("primd", primd.get)
  if cpuopt.isSome: args.append("cpuopt", cpuopt.get)

  result = API.invoke(plug, "primaries".cstring, args)
  API.freeMap(args)        

proc resample*(vsmap:ptr VSMap; w=none(int); h=none(int); sx=none(seq[float]); sy=none(seq[float]); sw=none(seq[float]); sh=none(seq[float]); scale=none(float); scaleh=none(float); scalev=none(float); kernel=none(seq[string]); kernelh=none(seq[string]); kernelv=none(seq[string]); impulse=none(seq[float]); impulseh=none(seq[float]); impulsev=none(seq[float]); taps=none(seq[int]); tapsh=none(seq[int]); tapsv=none(seq[int]); a1=none(seq[float]); a2=none(seq[float]); a3=none(seq[float]); kovrspl=none(seq[int]); fh=none(seq[float]); fv=none(seq[float]); cnorm=none(seq[int]); totalh=none(seq[float]); totalv=none(seq[float]); invks=none(seq[int]); invksh=none(seq[int]); invksv=none(seq[int]); invkstaps=none(seq[int]); invkstapsh=none(seq[int]); invkstapsv=none(seq[int]); csp=none(int); css=none(string); planes=none(seq[float]); fulls=none(int); fulld=none(int); center=none(seq[int]); cplace=none(string); cplaces=none(string); cplaced=none(string); interlaced=none(int); interlacedd=none(int); tff=none(int); tffd=none(int); flt=none(int); cpuopt=none(int)):ptr VSMap =
  let plug = getPluginById("fmtconv")
  if plug == nil:
    raise newException(ValueError, "plugin \"fmtc\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq    # Convert the VSMap into a sequence
  if tmpSeq.len == 0:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()
  args.append("clip", clip)
  if w.isSome: args.append("w", w.get)
  if h.isSome: args.append("h", h.get)
  if sx.isSome: args.set("sx", sx.get)
  if sy.isSome: args.set("sy", sy.get)
  if sw.isSome: args.set("sw", sw.get)
  if sh.isSome: args.set("sh", sh.get)
  if scale.isSome: args.append("scale", scale.get)
  if scaleh.isSome: args.append("scaleh", scaleh.get)
  if scalev.isSome: args.append("scalev", scalev.get)
  if kernel.isSome:
    for item in kernel.get:
      args.append("kernel", item)
  if kernelh.isSome:
    for item in kernelh.get:
      args.append("kernelh", item)
  if kernelv.isSome:
    for item in kernelv.get:
      args.append("kernelv", item)
  if impulse.isSome: args.set("impulse", impulse.get)
  if impulseh.isSome: args.set("impulseh", impulseh.get)
  if impulsev.isSome: args.set("impulsev", impulsev.get)
  if taps.isSome: args.set("taps", taps.get)
  if tapsh.isSome: args.set("tapsh", tapsh.get)
  if tapsv.isSome: args.set("tapsv", tapsv.get)
  if a1.isSome: args.set("a1", a1.get)
  if a2.isSome: args.set("a2", a2.get)
  if a3.isSome: args.set("a3", a3.get)
  if kovrspl.isSome: args.set("kovrspl", kovrspl.get)
  if fh.isSome: args.set("fh", fh.get)
  if fv.isSome: args.set("fv", fv.get)
  if cnorm.isSome: args.set("cnorm", cnorm.get)
  if totalh.isSome: args.set("totalh", totalh.get)
  if totalv.isSome: args.set("totalv", totalv.get)
  if invks.isSome: args.set("invks", invks.get)
  if invksh.isSome: args.set("invksh", invksh.get)
  if invksv.isSome: args.set("invksv", invksv.get)
  if invkstaps.isSome: args.set("invkstaps", invkstaps.get)
  if invkstapsh.isSome: args.set("invkstapsh", invkstapsh.get)
  if invkstapsv.isSome: args.set("invkstapsv", invkstapsv.get)
  if csp.isSome: args.append("csp", csp.get)
  if css.isSome: args.append("css", css.get)
  if planes.isSome: args.set("planes", planes.get)
  if fulls.isSome: args.append("fulls", fulls.get)
  if fulld.isSome: args.append("fulld", fulld.get)
  if center.isSome: args.set("center", center.get)
  if cplace.isSome: args.append("cplace", cplace.get)
  if cplaces.isSome: args.append("cplaces", cplaces.get)
  if cplaced.isSome: args.append("cplaced", cplaced.get)
  if interlaced.isSome: args.append("interlaced", interlaced.get)
  if interlacedd.isSome: args.append("interlacedd", interlacedd.get)
  if tff.isSome: args.append("tff", tff.get)
  if tffd.isSome: args.append("tffd", tffd.get)
  if flt.isSome: args.append("flt", flt.get)
  if cpuopt.isSome: args.append("cpuopt", cpuopt.get)

  result = API.invoke(plug, "resample".cstring, args)
  API.freeMap(args)        

proc stack16tonative*(vsmap:ptr VSMap):ptr VSMap =
  let plug = getPluginById("fmtconv")
  if plug == nil:
    raise newException(ValueError, "plugin \"fmtc\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq    # Convert the VSMap into a sequence
  if tmpSeq.len == 0:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()
  args.append("clip", clip)

  result = API.invoke(plug, "stack16tonative".cstring, args)
  API.freeMap(args)        

proc transfer*(vsmap:ptr VSMap; transs=none(seq[string]); transd=none(seq[string]); cont=none(float); gcor=none(float); bits=none(int); flt=none(int); fulls=none(int); fulld=none(int); cpuopt=none(int); blacklvl=none(float)):ptr VSMap =
  let plug = getPluginById("fmtconv")
  if plug == nil:
    raise newException(ValueError, "plugin \"fmtc\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq    # Convert the VSMap into a sequence
  if tmpSeq.len == 0:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()
  args.append("clip", clip)
  if transs.isSome:
    for item in transs.get:
      args.append("transs", item)
  if transd.isSome:
    for item in transd.get:
      args.append("transd", item)
  if cont.isSome: args.append("cont", cont.get)
  if gcor.isSome: args.append("gcor", gcor.get)
  if bits.isSome: args.append("bits", bits.get)
  if flt.isSome: args.append("flt", flt.get)
  if fulls.isSome: args.append("fulls", fulls.get)
  if fulld.isSome: args.append("fulld", fulld.get)
  if cpuopt.isSome: args.append("cpuopt", cpuopt.get)
  if blacklvl.isSome: args.append("blacklvl", blacklvl.get)

  result = API.invoke(plug, "transfer".cstring, args)
  API.freeMap(args)        

