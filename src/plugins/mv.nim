proc Analyse*(vsmap:ptr VSMap; blksize=none(int); blksizev=none(int); levels=none(int); search=none(int); searchparam=none(int); pelsearch=none(int); isb=none(int); lambda=none(int); chroma=none(int); delta=none(int); truemotion=none(int); lsad=none(int); plevel=none(int); global=none(int); pnew=none(int); pzero=none(int); pglobal=none(int); overlap=none(int); overlapv=none(int); divide=none(int); badsad=none(int); badrange=none(int); opt=none(int); meander=none(int); trymany=none(int); fields=none(int); tff=none(int); search_coarse=none(int); dct=none(int)):ptr VSMap =
  let plug = getPluginById("com.nodame.mvtools")
  if plug == nil:
    raise newException(ValueError, "plugin \"mv\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq    # Convert the VSMap into a sequence
  if tmpSeq.len == 0:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var super = tmpSeq[0].nodes[0]


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()
  args.append("super", super)
  if blksize.isSome: args.append("blksize", blksize.get)
  if blksizev.isSome: args.append("blksizev", blksizev.get)
  if levels.isSome: args.append("levels", levels.get)
  if search.isSome: args.append("search", search.get)
  if searchparam.isSome: args.append("searchparam", searchparam.get)
  if pelsearch.isSome: args.append("pelsearch", pelsearch.get)
  if isb.isSome: args.append("isb", isb.get)
  if lambda.isSome: args.append("lambda", lambda.get)
  if chroma.isSome: args.append("chroma", chroma.get)
  if delta.isSome: args.append("delta", delta.get)
  if truemotion.isSome: args.append("truemotion", truemotion.get)
  if lsad.isSome: args.append("lsad", lsad.get)
  if plevel.isSome: args.append("plevel", plevel.get)
  if global.isSome: args.append("global", global.get)
  if pnew.isSome: args.append("pnew", pnew.get)
  if pzero.isSome: args.append("pzero", pzero.get)
  if pglobal.isSome: args.append("pglobal", pglobal.get)
  if overlap.isSome: args.append("overlap", overlap.get)
  if overlapv.isSome: args.append("overlapv", overlapv.get)
  if divide.isSome: args.append("divide", divide.get)
  if badsad.isSome: args.append("badsad", badsad.get)
  if badrange.isSome: args.append("badrange", badrange.get)
  if opt.isSome: args.append("opt", opt.get)
  if meander.isSome: args.append("meander", meander.get)
  if trymany.isSome: args.append("trymany", trymany.get)
  if fields.isSome: args.append("fields", fields.get)
  if tff.isSome: args.append("tff", tff.get)
  if search_coarse.isSome: args.append("search_coarse", search_coarse.get)
  if dct.isSome: args.append("dct", dct.get)

  return API.invoke(plug, "Analyse".cstring, args)        

proc BlockFPS*(vsmap:ptr VSMap, super:ptr VSNodeRef, mvbw:ptr VSNodeRef, mvfw:ptr VSNodeRef; num=none(int); den=none(int); mode=none(int); ml=none(float); blend=none(int); thscd1=none(int); thscd2=none(int); opt=none(int)):ptr VSMap =
  let plug = getPluginById("com.nodame.mvtools")
  if plug == nil:
    raise newException(ValueError, "plugin \"mv\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq    # Convert the VSMap into a sequence
  if tmpSeq.len == 0:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()
  args.append("clip", clip)
  args.append("super", super)
  args.append("mvbw", mvbw)
  args.append("mvfw", mvfw)
  if num.isSome: args.append("num", num.get)
  if den.isSome: args.append("den", den.get)
  if mode.isSome: args.append("mode", mode.get)
  if ml.isSome: args.append("ml", ml.get)
  if blend.isSome: args.append("blend", blend.get)
  if thscd1.isSome: args.append("thscd1", thscd1.get)
  if thscd2.isSome: args.append("thscd2", thscd2.get)
  if opt.isSome: args.append("opt", opt.get)

  return API.invoke(plug, "BlockFPS".cstring, args)        

proc Compensate*(vsmap:ptr VSMap, super:ptr VSNodeRef, vectors:ptr VSNodeRef; scbehavior=none(int); thsad=none(int); fields=none(int); time=none(float); thscd1=none(int); thscd2=none(int); opt=none(int); tff=none(int)):ptr VSMap =
  let plug = getPluginById("com.nodame.mvtools")
  if plug == nil:
    raise newException(ValueError, "plugin \"mv\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq    # Convert the VSMap into a sequence
  if tmpSeq.len == 0:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()
  args.append("clip", clip)
  args.append("super", super)
  args.append("vectors", vectors)
  if scbehavior.isSome: args.append("scbehavior", scbehavior.get)
  if thsad.isSome: args.append("thsad", thsad.get)
  if fields.isSome: args.append("fields", fields.get)
  if time.isSome: args.append("time", time.get)
  if thscd1.isSome: args.append("thscd1", thscd1.get)
  if thscd2.isSome: args.append("thscd2", thscd2.get)
  if opt.isSome: args.append("opt", opt.get)
  if tff.isSome: args.append("tff", tff.get)

  return API.invoke(plug, "Compensate".cstring, args)        

proc Degrain1*(vsmap:ptr VSMap, super:ptr VSNodeRef, mvbw:ptr VSNodeRef, mvfw:ptr VSNodeRef; thsad=none(int); thsadc=none(int); plane=none(int); limit=none(int); limitc=none(int); thscd1=none(int); thscd2=none(int); opt=none(int)):ptr VSMap =
  let plug = getPluginById("com.nodame.mvtools")
  if plug == nil:
    raise newException(ValueError, "plugin \"mv\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq    # Convert the VSMap into a sequence
  if tmpSeq.len == 0:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()
  args.append("clip", clip)
  args.append("super", super)
  args.append("mvbw", mvbw)
  args.append("mvfw", mvfw)
  if thsad.isSome: args.append("thsad", thsad.get)
  if thsadc.isSome: args.append("thsadc", thsadc.get)
  if plane.isSome: args.append("plane", plane.get)
  if limit.isSome: args.append("limit", limit.get)
  if limitc.isSome: args.append("limitc", limitc.get)
  if thscd1.isSome: args.append("thscd1", thscd1.get)
  if thscd2.isSome: args.append("thscd2", thscd2.get)
  if opt.isSome: args.append("opt", opt.get)

  return API.invoke(plug, "Degrain1".cstring, args)        

proc Degrain2*(vsmap:ptr VSMap, super:ptr VSNodeRef, mvbw:ptr VSNodeRef, mvfw:ptr VSNodeRef, mvbw2:ptr VSNodeRef, mvfw2:ptr VSNodeRef; thsad=none(int); thsadc=none(int); plane=none(int); limit=none(int); limitc=none(int); thscd1=none(int); thscd2=none(int); opt=none(int)):ptr VSMap =
  let plug = getPluginById("com.nodame.mvtools")
  if plug == nil:
    raise newException(ValueError, "plugin \"mv\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq    # Convert the VSMap into a sequence
  if tmpSeq.len == 0:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()
  args.append("clip", clip)
  args.append("super", super)
  args.append("mvbw", mvbw)
  args.append("mvfw", mvfw)
  args.append("mvbw2", mvbw2)
  args.append("mvfw2", mvfw2)
  if thsad.isSome: args.append("thsad", thsad.get)
  if thsadc.isSome: args.append("thsadc", thsadc.get)
  if plane.isSome: args.append("plane", plane.get)
  if limit.isSome: args.append("limit", limit.get)
  if limitc.isSome: args.append("limitc", limitc.get)
  if thscd1.isSome: args.append("thscd1", thscd1.get)
  if thscd2.isSome: args.append("thscd2", thscd2.get)
  if opt.isSome: args.append("opt", opt.get)

  return API.invoke(plug, "Degrain2".cstring, args)        

proc Degrain3*(vsmap:ptr VSMap, super:ptr VSNodeRef, mvbw:ptr VSNodeRef, mvfw:ptr VSNodeRef, mvbw2:ptr VSNodeRef, mvfw2:ptr VSNodeRef, mvbw3:ptr VSNodeRef, mvfw3:ptr VSNodeRef; thsad=none(int); thsadc=none(int); plane=none(int); limit=none(int); limitc=none(int); thscd1=none(int); thscd2=none(int); opt=none(int)):ptr VSMap =
  let plug = getPluginById("com.nodame.mvtools")
  if plug == nil:
    raise newException(ValueError, "plugin \"mv\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq    # Convert the VSMap into a sequence
  if tmpSeq.len == 0:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()
  args.append("clip", clip)
  args.append("super", super)
  args.append("mvbw", mvbw)
  args.append("mvfw", mvfw)
  args.append("mvbw2", mvbw2)
  args.append("mvfw2", mvfw2)
  args.append("mvbw3", mvbw3)
  args.append("mvfw3", mvfw3)
  if thsad.isSome: args.append("thsad", thsad.get)
  if thsadc.isSome: args.append("thsadc", thsadc.get)
  if plane.isSome: args.append("plane", plane.get)
  if limit.isSome: args.append("limit", limit.get)
  if limitc.isSome: args.append("limitc", limitc.get)
  if thscd1.isSome: args.append("thscd1", thscd1.get)
  if thscd2.isSome: args.append("thscd2", thscd2.get)
  if opt.isSome: args.append("opt", opt.get)

  return API.invoke(plug, "Degrain3".cstring, args)        

proc DepanAnalyse*(vsmap:ptr VSMap, vectors:ptr VSNodeRef; mask=none(ptr VSNodeRef); zoom=none(int); rot=none(int); pixaspect=none(float); error=none(float); info=none(int); wrong=none(float); zerow=none(float); thscd1=none(int); thscd2=none(int); fields=none(int); tff=none(int)):ptr VSMap =
  let plug = getPluginById("com.nodame.mvtools")
  if plug == nil:
    raise newException(ValueError, "plugin \"mv\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq    # Convert the VSMap into a sequence
  if tmpSeq.len == 0:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()
  args.append("clip", clip)
  args.append("vectors", vectors)
  if mask.isSome: args.append("mask", mask.get)
  if zoom.isSome: args.append("zoom", zoom.get)
  if rot.isSome: args.append("rot", rot.get)
  if pixaspect.isSome: args.append("pixaspect", pixaspect.get)
  if error.isSome: args.append("error", error.get)
  if info.isSome: args.append("info", info.get)
  if wrong.isSome: args.append("wrong", wrong.get)
  if zerow.isSome: args.append("zerow", zerow.get)
  if thscd1.isSome: args.append("thscd1", thscd1.get)
  if thscd2.isSome: args.append("thscd2", thscd2.get)
  if fields.isSome: args.append("fields", fields.get)
  if tff.isSome: args.append("tff", tff.get)

  return API.invoke(plug, "DepanAnalyse".cstring, args)        

proc DepanCompensate*(vsmap:ptr VSMap, data:ptr VSNodeRef; offset=none(float); subpixel=none(int); pixaspect=none(float); matchfields=none(int); mirror=none(int); blur=none(int); info=none(int); fields=none(int); tff=none(int)):ptr VSMap =
  let plug = getPluginById("com.nodame.mvtools")
  if plug == nil:
    raise newException(ValueError, "plugin \"mv\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq    # Convert the VSMap into a sequence
  if tmpSeq.len == 0:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()
  args.append("clip", clip)
  args.append("data", data)
  if offset.isSome: args.append("offset", offset.get)
  if subpixel.isSome: args.append("subpixel", subpixel.get)
  if pixaspect.isSome: args.append("pixaspect", pixaspect.get)
  if matchfields.isSome: args.append("matchfields", matchfields.get)
  if mirror.isSome: args.append("mirror", mirror.get)
  if blur.isSome: args.append("blur", blur.get)
  if info.isSome: args.append("info", info.get)
  if fields.isSome: args.append("fields", fields.get)
  if tff.isSome: args.append("tff", tff.get)

  return API.invoke(plug, "DepanCompensate".cstring, args)        

proc DepanEstimate*(vsmap:ptr VSMap; trust=none(float); winx=none(int); winy=none(int); wleft=none(int); wtop=none(int); dxmax=none(int); dymax=none(int); zoommax=none(float); stab=none(float); pixaspect=none(float); info=none(int); show=none(int); fields=none(int); tff=none(int)):ptr VSMap =
  let plug = getPluginById("com.nodame.mvtools")
  if plug == nil:
    raise newException(ValueError, "plugin \"mv\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq    # Convert the VSMap into a sequence
  if tmpSeq.len == 0:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()
  args.append("clip", clip)
  if trust.isSome: args.append("trust", trust.get)
  if winx.isSome: args.append("winx", winx.get)
  if winy.isSome: args.append("winy", winy.get)
  if wleft.isSome: args.append("wleft", wleft.get)
  if wtop.isSome: args.append("wtop", wtop.get)
  if dxmax.isSome: args.append("dxmax", dxmax.get)
  if dymax.isSome: args.append("dymax", dymax.get)
  if zoommax.isSome: args.append("zoommax", zoommax.get)
  if stab.isSome: args.append("stab", stab.get)
  if pixaspect.isSome: args.append("pixaspect", pixaspect.get)
  if info.isSome: args.append("info", info.get)
  if show.isSome: args.append("show", show.get)
  if fields.isSome: args.append("fields", fields.get)
  if tff.isSome: args.append("tff", tff.get)

  return API.invoke(plug, "DepanEstimate".cstring, args)        

proc DepanStabilise*(vsmap:ptr VSMap, data:ptr VSNodeRef; cutoff=none(float); damping=none(float); initzoom=none(float); addzoom=none(int); prev=none(int); next=none(int); mirror=none(int); blur=none(int); dxmax=none(float); dymax=none(float); zoommax=none(float); rotmax=none(float); subpixel=none(int); pixaspect=none(float); fitlast=none(int); tzoom=none(float); info=none(int); `method`=none(int); fields=none(int)):ptr VSMap =
  let plug = getPluginById("com.nodame.mvtools")
  if plug == nil:
    raise newException(ValueError, "plugin \"mv\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq    # Convert the VSMap into a sequence
  if tmpSeq.len == 0:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()
  args.append("clip", clip)
  args.append("data", data)
  if cutoff.isSome: args.append("cutoff", cutoff.get)
  if damping.isSome: args.append("damping", damping.get)
  if initzoom.isSome: args.append("initzoom", initzoom.get)
  if addzoom.isSome: args.append("addzoom", addzoom.get)
  if prev.isSome: args.append("prev", prev.get)
  if next.isSome: args.append("next", next.get)
  if mirror.isSome: args.append("mirror", mirror.get)
  if blur.isSome: args.append("blur", blur.get)
  if dxmax.isSome: args.append("dxmax", dxmax.get)
  if dymax.isSome: args.append("dymax", dymax.get)
  if zoommax.isSome: args.append("zoommax", zoommax.get)
  if rotmax.isSome: args.append("rotmax", rotmax.get)
  if subpixel.isSome: args.append("subpixel", subpixel.get)
  if pixaspect.isSome: args.append("pixaspect", pixaspect.get)
  if fitlast.isSome: args.append("fitlast", fitlast.get)
  if tzoom.isSome: args.append("tzoom", tzoom.get)
  if info.isSome: args.append("info", info.get)
  if `method`.isSome: args.append("method", `method`.get)
  if fields.isSome: args.append("fields", fields.get)

  return API.invoke(plug, "DepanStabilise".cstring, args)        

proc Finest*(vsmap:ptr VSMap; opt=none(int)):ptr VSMap =
  let plug = getPluginById("com.nodame.mvtools")
  if plug == nil:
    raise newException(ValueError, "plugin \"mv\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq    # Convert the VSMap into a sequence
  if tmpSeq.len == 0:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var super = tmpSeq[0].nodes[0]


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()
  args.append("super", super)
  if opt.isSome: args.append("opt", opt.get)

  return API.invoke(plug, "Finest".cstring, args)        

proc Flow*(vsmap:ptr VSMap, super:ptr VSNodeRef, vectors:ptr VSNodeRef; time=none(float); mode=none(int); fields=none(int); thscd1=none(int); thscd2=none(int); opt=none(int); tff=none(int)):ptr VSMap =
  let plug = getPluginById("com.nodame.mvtools")
  if plug == nil:
    raise newException(ValueError, "plugin \"mv\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq    # Convert the VSMap into a sequence
  if tmpSeq.len == 0:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()
  args.append("clip", clip)
  args.append("super", super)
  args.append("vectors", vectors)
  if time.isSome: args.append("time", time.get)
  if mode.isSome: args.append("mode", mode.get)
  if fields.isSome: args.append("fields", fields.get)
  if thscd1.isSome: args.append("thscd1", thscd1.get)
  if thscd2.isSome: args.append("thscd2", thscd2.get)
  if opt.isSome: args.append("opt", opt.get)
  if tff.isSome: args.append("tff", tff.get)

  return API.invoke(plug, "Flow".cstring, args)        

proc FlowBlur*(vsmap:ptr VSMap, super:ptr VSNodeRef, mvbw:ptr VSNodeRef, mvfw:ptr VSNodeRef; blur=none(float); prec=none(int); thscd1=none(int); thscd2=none(int); opt=none(int)):ptr VSMap =
  let plug = getPluginById("com.nodame.mvtools")
  if plug == nil:
    raise newException(ValueError, "plugin \"mv\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq    # Convert the VSMap into a sequence
  if tmpSeq.len == 0:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()
  args.append("clip", clip)
  args.append("super", super)
  args.append("mvbw", mvbw)
  args.append("mvfw", mvfw)
  if blur.isSome: args.append("blur", blur.get)
  if prec.isSome: args.append("prec", prec.get)
  if thscd1.isSome: args.append("thscd1", thscd1.get)
  if thscd2.isSome: args.append("thscd2", thscd2.get)
  if opt.isSome: args.append("opt", opt.get)

  return API.invoke(plug, "FlowBlur".cstring, args)        

proc FlowFPS*(vsmap:ptr VSMap, super:ptr VSNodeRef, mvbw:ptr VSNodeRef, mvfw:ptr VSNodeRef; num=none(int); den=none(int); mask=none(int); ml=none(float); blend=none(int); thscd1=none(int); thscd2=none(int); opt=none(int)):ptr VSMap =
  let plug = getPluginById("com.nodame.mvtools")
  if plug == nil:
    raise newException(ValueError, "plugin \"mv\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq    # Convert the VSMap into a sequence
  if tmpSeq.len == 0:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()
  args.append("clip", clip)
  args.append("super", super)
  args.append("mvbw", mvbw)
  args.append("mvfw", mvfw)
  if num.isSome: args.append("num", num.get)
  if den.isSome: args.append("den", den.get)
  if mask.isSome: args.append("mask", mask.get)
  if ml.isSome: args.append("ml", ml.get)
  if blend.isSome: args.append("blend", blend.get)
  if thscd1.isSome: args.append("thscd1", thscd1.get)
  if thscd2.isSome: args.append("thscd2", thscd2.get)
  if opt.isSome: args.append("opt", opt.get)

  return API.invoke(plug, "FlowFPS".cstring, args)        

proc FlowInter*(vsmap:ptr VSMap, super:ptr VSNodeRef, mvbw:ptr VSNodeRef, mvfw:ptr VSNodeRef; time=none(float); ml=none(float); blend=none(int); thscd1=none(int); thscd2=none(int); opt=none(int)):ptr VSMap =
  let plug = getPluginById("com.nodame.mvtools")
  if plug == nil:
    raise newException(ValueError, "plugin \"mv\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq    # Convert the VSMap into a sequence
  if tmpSeq.len == 0:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()
  args.append("clip", clip)
  args.append("super", super)
  args.append("mvbw", mvbw)
  args.append("mvfw", mvfw)
  if time.isSome: args.append("time", time.get)
  if ml.isSome: args.append("ml", ml.get)
  if blend.isSome: args.append("blend", blend.get)
  if thscd1.isSome: args.append("thscd1", thscd1.get)
  if thscd2.isSome: args.append("thscd2", thscd2.get)
  if opt.isSome: args.append("opt", opt.get)

  return API.invoke(plug, "FlowInter".cstring, args)        

proc Mask*(vsmap:ptr VSMap, vectors:ptr VSNodeRef; ml=none(float); gamma=none(float); kind=none(int); time=none(float); ysc=none(int); thscd1=none(int); thscd2=none(int); opt=none(int)):ptr VSMap =
  let plug = getPluginById("com.nodame.mvtools")
  if plug == nil:
    raise newException(ValueError, "plugin \"mv\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq    # Convert the VSMap into a sequence
  if tmpSeq.len == 0:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()
  args.append("clip", clip)
  args.append("vectors", vectors)
  if ml.isSome: args.append("ml", ml.get)
  if gamma.isSome: args.append("gamma", gamma.get)
  if kind.isSome: args.append("kind", kind.get)
  if time.isSome: args.append("time", time.get)
  if ysc.isSome: args.append("ysc", ysc.get)
  if thscd1.isSome: args.append("thscd1", thscd1.get)
  if thscd2.isSome: args.append("thscd2", thscd2.get)
  if opt.isSome: args.append("opt", opt.get)

  return API.invoke(plug, "Mask".cstring, args)        

proc Recalculate*(vsmap:ptr VSMap, vectors:ptr VSNodeRef; thsad=none(int); smooth=none(int); blksize=none(int); blksizev=none(int); search=none(int); searchparam=none(int); lambda=none(int); chroma=none(int); truemotion=none(int); pnew=none(int); overlap=none(int); overlapv=none(int); divide=none(int); opt=none(int); meander=none(int); fields=none(int); tff=none(int); dct=none(int)):ptr VSMap =
  let plug = getPluginById("com.nodame.mvtools")
  if plug == nil:
    raise newException(ValueError, "plugin \"mv\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq    # Convert the VSMap into a sequence
  if tmpSeq.len == 0:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var super = tmpSeq[0].nodes[0]


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()
  args.append("super", super)
  args.append("vectors", vectors)
  if thsad.isSome: args.append("thsad", thsad.get)
  if smooth.isSome: args.append("smooth", smooth.get)
  if blksize.isSome: args.append("blksize", blksize.get)
  if blksizev.isSome: args.append("blksizev", blksizev.get)
  if search.isSome: args.append("search", search.get)
  if searchparam.isSome: args.append("searchparam", searchparam.get)
  if lambda.isSome: args.append("lambda", lambda.get)
  if chroma.isSome: args.append("chroma", chroma.get)
  if truemotion.isSome: args.append("truemotion", truemotion.get)
  if pnew.isSome: args.append("pnew", pnew.get)
  if overlap.isSome: args.append("overlap", overlap.get)
  if overlapv.isSome: args.append("overlapv", overlapv.get)
  if divide.isSome: args.append("divide", divide.get)
  if opt.isSome: args.append("opt", opt.get)
  if meander.isSome: args.append("meander", meander.get)
  if fields.isSome: args.append("fields", fields.get)
  if tff.isSome: args.append("tff", tff.get)
  if dct.isSome: args.append("dct", dct.get)

  return API.invoke(plug, "Recalculate".cstring, args)        

proc SCDetection*(vsmap:ptr VSMap, vectors:ptr VSNodeRef; thscd1=none(int); thscd2=none(int)):ptr VSMap =
  let plug = getPluginById("com.nodame.mvtools")
  if plug == nil:
    raise newException(ValueError, "plugin \"mv\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq    # Convert the VSMap into a sequence
  if tmpSeq.len == 0:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()
  args.append("clip", clip)
  args.append("vectors", vectors)
  if thscd1.isSome: args.append("thscd1", thscd1.get)
  if thscd2.isSome: args.append("thscd2", thscd2.get)

  return API.invoke(plug, "SCDetection".cstring, args)        

proc Super*(vsmap:ptr VSMap; hpad=none(int); vpad=none(int); pel=none(int); levels=none(int); chroma=none(int); sharp=none(int); rfilter=none(int); pelclip=none(ptr VSNodeRef); opt=none(int)):ptr VSMap =
  let plug = getPluginById("com.nodame.mvtools")
  if plug == nil:
    raise newException(ValueError, "plugin \"mv\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq    # Convert the VSMap into a sequence
  if tmpSeq.len == 0:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()
  args.append("clip", clip)
  if hpad.isSome: args.append("hpad", hpad.get)
  if vpad.isSome: args.append("vpad", vpad.get)
  if pel.isSome: args.append("pel", pel.get)
  if levels.isSome: args.append("levels", levels.get)
  if chroma.isSome: args.append("chroma", chroma.get)
  if sharp.isSome: args.append("sharp", sharp.get)
  if rfilter.isSome: args.append("rfilter", rfilter.get)
  if pelclip.isSome: args.append("pelclip", pelclip.get)
  if opt.isSome: args.append("opt", opt.get)

  return API.invoke(plug, "Super".cstring, args)        

