proc Analyse(super:ptr VSNodeRef; blksize=none(int); blksizev=none(int); levels=none(int); search=none(int); searchparam=none(int); pelsearch=none(int); isb=none(int); lambda=none(int); chroma=none(int); delta=none(int); truemotion=none(int); lsad=none(int); plevel=none(int); global=none(int); pnew=none(int); pzero=none(int); pglobal=none(int); overlap=none(int); overlapv=none(int); divide=none(int); badsad=none(int); badrange=none(int); opt=none(int); meander=none(int); trymany=none(int); fields=none(int); tff=none(int); search_coarse=none(int); dct=none(int)):ptr VSMap =
  let plug = getPluginById("com.nodame.mvtools")
  let args = createMap()
  propSetNode(args, "super", super, paAppend)
  if blksize.isSome:
    propSetInt(args, "blksize", blksize.get, paAppend)
  if blksizev.isSome:
    propSetInt(args, "blksizev", blksizev.get, paAppend)
  if levels.isSome:
    propSetInt(args, "levels", levels.get, paAppend)
  if search.isSome:
    propSetInt(args, "search", search.get, paAppend)
  if searchparam.isSome:
    propSetInt(args, "searchparam", searchparam.get, paAppend)
  if pelsearch.isSome:
    propSetInt(args, "pelsearch", pelsearch.get, paAppend)
  if isb.isSome:
    propSetInt(args, "isb", isb.get, paAppend)
  if lambda.isSome:
    propSetInt(args, "lambda", lambda.get, paAppend)
  if chroma.isSome:
    propSetInt(args, "chroma", chroma.get, paAppend)
  if delta.isSome:
    propSetInt(args, "delta", delta.get, paAppend)
  if truemotion.isSome:
    propSetInt(args, "truemotion", truemotion.get, paAppend)
  if lsad.isSome:
    propSetInt(args, "lsad", lsad.get, paAppend)
  if plevel.isSome:
    propSetInt(args, "plevel", plevel.get, paAppend)
  if global.isSome:
    propSetInt(args, "global", global.get, paAppend)
  if pnew.isSome:
    propSetInt(args, "pnew", pnew.get, paAppend)
  if pzero.isSome:
    propSetInt(args, "pzero", pzero.get, paAppend)
  if pglobal.isSome:
    propSetInt(args, "pglobal", pglobal.get, paAppend)
  if overlap.isSome:
    propSetInt(args, "overlap", overlap.get, paAppend)
  if overlapv.isSome:
    propSetInt(args, "overlapv", overlapv.get, paAppend)
  if divide.isSome:
    propSetInt(args, "divide", divide.get, paAppend)
  if badsad.isSome:
    propSetInt(args, "badsad", badsad.get, paAppend)
  if badrange.isSome:
    propSetInt(args, "badrange", badrange.get, paAppend)
  if opt.isSome:
    propSetInt(args, "opt", opt.get, paAppend)
  if meander.isSome:
    propSetInt(args, "meander", meander.get, paAppend)
  if trymany.isSome:
    propSetInt(args, "trymany", trymany.get, paAppend)
  if fields.isSome:
    propSetInt(args, "fields", fields.get, paAppend)
  if tff.isSome:
    propSetInt(args, "tff", tff.get, paAppend)
  if search_coarse.isSome:
    propSetInt(args, "search_coarse", search_coarse.get, paAppend)
  if dct.isSome:
    propSetInt(args, "dct", dct.get, paAppend)

  return API.invoke(plug, "Analyse".cstring, args)        

proc BlockFPS(clip:ptr VSNodeRef, super:ptr VSNodeRef, mvbw:ptr VSNodeRef, mvfw:ptr VSNodeRef; num=none(int); den=none(int); mode=none(int); ml=none(float); blend=none(int); thscd1=none(int); thscd2=none(int); opt=none(int)):ptr VSMap =
  let plug = getPluginById("com.nodame.mvtools")
  let args = createMap()
  propSetNode(args, "clip", clip, paAppend)
  propSetNode(args, "super", super, paAppend)
  propSetNode(args, "mvbw", mvbw, paAppend)
  propSetNode(args, "mvfw", mvfw, paAppend)
  if num.isSome:
    propSetInt(args, "num", num.get, paAppend)
  if den.isSome:
    propSetInt(args, "den", den.get, paAppend)
  if mode.isSome:
    propSetInt(args, "mode", mode.get, paAppend)
  if ml.isSome:
    propSetFloat(args, "ml", ml.get, paAppend)
  if blend.isSome:
    propSetInt(args, "blend", blend.get, paAppend)
  if thscd1.isSome:
    propSetInt(args, "thscd1", thscd1.get, paAppend)
  if thscd2.isSome:
    propSetInt(args, "thscd2", thscd2.get, paAppend)
  if opt.isSome:
    propSetInt(args, "opt", opt.get, paAppend)

  return API.invoke(plug, "BlockFPS".cstring, args)        

proc Compensate(clip:ptr VSNodeRef, super:ptr VSNodeRef, vectors:ptr VSNodeRef; scbehavior=none(int); thsad=none(int); fields=none(int); time=none(float); thscd1=none(int); thscd2=none(int); opt=none(int); tff=none(int)):ptr VSMap =
  let plug = getPluginById("com.nodame.mvtools")
  let args = createMap()
  propSetNode(args, "clip", clip, paAppend)
  propSetNode(args, "super", super, paAppend)
  propSetNode(args, "vectors", vectors, paAppend)
  if scbehavior.isSome:
    propSetInt(args, "scbehavior", scbehavior.get, paAppend)
  if thsad.isSome:
    propSetInt(args, "thsad", thsad.get, paAppend)
  if fields.isSome:
    propSetInt(args, "fields", fields.get, paAppend)
  if time.isSome:
    propSetFloat(args, "time", time.get, paAppend)
  if thscd1.isSome:
    propSetInt(args, "thscd1", thscd1.get, paAppend)
  if thscd2.isSome:
    propSetInt(args, "thscd2", thscd2.get, paAppend)
  if opt.isSome:
    propSetInt(args, "opt", opt.get, paAppend)
  if tff.isSome:
    propSetInt(args, "tff", tff.get, paAppend)

  return API.invoke(plug, "Compensate".cstring, args)        

proc Degrain1(clip:ptr VSNodeRef, super:ptr VSNodeRef, mvbw:ptr VSNodeRef, mvfw:ptr VSNodeRef; thsad=none(int); thsadc=none(int); plane=none(int); limit=none(int); limitc=none(int); thscd1=none(int); thscd2=none(int); opt=none(int)):ptr VSMap =
  let plug = getPluginById("com.nodame.mvtools")
  let args = createMap()
  propSetNode(args, "clip", clip, paAppend)
  propSetNode(args, "super", super, paAppend)
  propSetNode(args, "mvbw", mvbw, paAppend)
  propSetNode(args, "mvfw", mvfw, paAppend)
  if thsad.isSome:
    propSetInt(args, "thsad", thsad.get, paAppend)
  if thsadc.isSome:
    propSetInt(args, "thsadc", thsadc.get, paAppend)
  if plane.isSome:
    propSetInt(args, "plane", plane.get, paAppend)
  if limit.isSome:
    propSetInt(args, "limit", limit.get, paAppend)
  if limitc.isSome:
    propSetInt(args, "limitc", limitc.get, paAppend)
  if thscd1.isSome:
    propSetInt(args, "thscd1", thscd1.get, paAppend)
  if thscd2.isSome:
    propSetInt(args, "thscd2", thscd2.get, paAppend)
  if opt.isSome:
    propSetInt(args, "opt", opt.get, paAppend)

  return API.invoke(plug, "Degrain1".cstring, args)        

proc Degrain2(clip:ptr VSNodeRef, super:ptr VSNodeRef, mvbw:ptr VSNodeRef, mvfw:ptr VSNodeRef, mvbw2:ptr VSNodeRef, mvfw2:ptr VSNodeRef; thsad=none(int); thsadc=none(int); plane=none(int); limit=none(int); limitc=none(int); thscd1=none(int); thscd2=none(int); opt=none(int)):ptr VSMap =
  let plug = getPluginById("com.nodame.mvtools")
  let args = createMap()
  propSetNode(args, "clip", clip, paAppend)
  propSetNode(args, "super", super, paAppend)
  propSetNode(args, "mvbw", mvbw, paAppend)
  propSetNode(args, "mvfw", mvfw, paAppend)
  propSetNode(args, "mvbw2", mvbw2, paAppend)
  propSetNode(args, "mvfw2", mvfw2, paAppend)
  if thsad.isSome:
    propSetInt(args, "thsad", thsad.get, paAppend)
  if thsadc.isSome:
    propSetInt(args, "thsadc", thsadc.get, paAppend)
  if plane.isSome:
    propSetInt(args, "plane", plane.get, paAppend)
  if limit.isSome:
    propSetInt(args, "limit", limit.get, paAppend)
  if limitc.isSome:
    propSetInt(args, "limitc", limitc.get, paAppend)
  if thscd1.isSome:
    propSetInt(args, "thscd1", thscd1.get, paAppend)
  if thscd2.isSome:
    propSetInt(args, "thscd2", thscd2.get, paAppend)
  if opt.isSome:
    propSetInt(args, "opt", opt.get, paAppend)

  return API.invoke(plug, "Degrain2".cstring, args)        

proc Degrain3(clip:ptr VSNodeRef, super:ptr VSNodeRef, mvbw:ptr VSNodeRef, mvfw:ptr VSNodeRef, mvbw2:ptr VSNodeRef, mvfw2:ptr VSNodeRef, mvbw3:ptr VSNodeRef, mvfw3:ptr VSNodeRef; thsad=none(int); thsadc=none(int); plane=none(int); limit=none(int); limitc=none(int); thscd1=none(int); thscd2=none(int); opt=none(int)):ptr VSMap =
  let plug = getPluginById("com.nodame.mvtools")
  let args = createMap()
  propSetNode(args, "clip", clip, paAppend)
  propSetNode(args, "super", super, paAppend)
  propSetNode(args, "mvbw", mvbw, paAppend)
  propSetNode(args, "mvfw", mvfw, paAppend)
  propSetNode(args, "mvbw2", mvbw2, paAppend)
  propSetNode(args, "mvfw2", mvfw2, paAppend)
  propSetNode(args, "mvbw3", mvbw3, paAppend)
  propSetNode(args, "mvfw3", mvfw3, paAppend)
  if thsad.isSome:
    propSetInt(args, "thsad", thsad.get, paAppend)
  if thsadc.isSome:
    propSetInt(args, "thsadc", thsadc.get, paAppend)
  if plane.isSome:
    propSetInt(args, "plane", plane.get, paAppend)
  if limit.isSome:
    propSetInt(args, "limit", limit.get, paAppend)
  if limitc.isSome:
    propSetInt(args, "limitc", limitc.get, paAppend)
  if thscd1.isSome:
    propSetInt(args, "thscd1", thscd1.get, paAppend)
  if thscd2.isSome:
    propSetInt(args, "thscd2", thscd2.get, paAppend)
  if opt.isSome:
    propSetInt(args, "opt", opt.get, paAppend)

  return API.invoke(plug, "Degrain3".cstring, args)        

proc DepanAnalyse(clip:ptr VSNodeRef, vectors:ptr VSNodeRef; mask=none(ptr VSNodeRef); zoom=none(int); rot=none(int); pixaspect=none(float); error=none(float); info=none(int); wrong=none(float); zerow=none(float); thscd1=none(int); thscd2=none(int); fields=none(int); tff=none(int)):ptr VSMap =
  let plug = getPluginById("com.nodame.mvtools")
  let args = createMap()
  propSetNode(args, "clip", clip, paAppend)
  propSetNode(args, "vectors", vectors, paAppend)
  if mask.isSome:
    propSetNode(args, "mask", mask.get, paAppend)
  if zoom.isSome:
    propSetInt(args, "zoom", zoom.get, paAppend)
  if rot.isSome:
    propSetInt(args, "rot", rot.get, paAppend)
  if pixaspect.isSome:
    propSetFloat(args, "pixaspect", pixaspect.get, paAppend)
  if error.isSome:
    propSetFloat(args, "error", error.get, paAppend)
  if info.isSome:
    propSetInt(args, "info", info.get, paAppend)
  if wrong.isSome:
    propSetFloat(args, "wrong", wrong.get, paAppend)
  if zerow.isSome:
    propSetFloat(args, "zerow", zerow.get, paAppend)
  if thscd1.isSome:
    propSetInt(args, "thscd1", thscd1.get, paAppend)
  if thscd2.isSome:
    propSetInt(args, "thscd2", thscd2.get, paAppend)
  if fields.isSome:
    propSetInt(args, "fields", fields.get, paAppend)
  if tff.isSome:
    propSetInt(args, "tff", tff.get, paAppend)

  return API.invoke(plug, "DepanAnalyse".cstring, args)        

proc DepanCompensate(clip:ptr VSNodeRef, data:ptr VSNodeRef; offset=none(float); subpixel=none(int); pixaspect=none(float); matchfields=none(int); mirror=none(int); blur=none(int); info=none(int); fields=none(int); tff=none(int)):ptr VSMap =
  let plug = getPluginById("com.nodame.mvtools")
  let args = createMap()
  propSetNode(args, "clip", clip, paAppend)
  propSetNode(args, "data", data, paAppend)
  if offset.isSome:
    propSetFloat(args, "offset", offset.get, paAppend)
  if subpixel.isSome:
    propSetInt(args, "subpixel", subpixel.get, paAppend)
  if pixaspect.isSome:
    propSetFloat(args, "pixaspect", pixaspect.get, paAppend)
  if matchfields.isSome:
    propSetInt(args, "matchfields", matchfields.get, paAppend)
  if mirror.isSome:
    propSetInt(args, "mirror", mirror.get, paAppend)
  if blur.isSome:
    propSetInt(args, "blur", blur.get, paAppend)
  if info.isSome:
    propSetInt(args, "info", info.get, paAppend)
  if fields.isSome:
    propSetInt(args, "fields", fields.get, paAppend)
  if tff.isSome:
    propSetInt(args, "tff", tff.get, paAppend)

  return API.invoke(plug, "DepanCompensate".cstring, args)        

proc DepanEstimate(clip:ptr VSNodeRef; trust=none(float); winx=none(int); winy=none(int); wleft=none(int); wtop=none(int); dxmax=none(int); dymax=none(int); zoommax=none(float); stab=none(float); pixaspect=none(float); info=none(int); show=none(int); fields=none(int); tff=none(int)):ptr VSMap =
  let plug = getPluginById("com.nodame.mvtools")
  let args = createMap()
  propSetNode(args, "clip", clip, paAppend)
  if trust.isSome:
    propSetFloat(args, "trust", trust.get, paAppend)
  if winx.isSome:
    propSetInt(args, "winx", winx.get, paAppend)
  if winy.isSome:
    propSetInt(args, "winy", winy.get, paAppend)
  if wleft.isSome:
    propSetInt(args, "wleft", wleft.get, paAppend)
  if wtop.isSome:
    propSetInt(args, "wtop", wtop.get, paAppend)
  if dxmax.isSome:
    propSetInt(args, "dxmax", dxmax.get, paAppend)
  if dymax.isSome:
    propSetInt(args, "dymax", dymax.get, paAppend)
  if zoommax.isSome:
    propSetFloat(args, "zoommax", zoommax.get, paAppend)
  if stab.isSome:
    propSetFloat(args, "stab", stab.get, paAppend)
  if pixaspect.isSome:
    propSetFloat(args, "pixaspect", pixaspect.get, paAppend)
  if info.isSome:
    propSetInt(args, "info", info.get, paAppend)
  if show.isSome:
    propSetInt(args, "show", show.get, paAppend)
  if fields.isSome:
    propSetInt(args, "fields", fields.get, paAppend)
  if tff.isSome:
    propSetInt(args, "tff", tff.get, paAppend)

  return API.invoke(plug, "DepanEstimate".cstring, args)        

proc DepanStabilise(clip:ptr VSNodeRef, data:ptr VSNodeRef; cutoff=none(float); damping=none(float); initzoom=none(float); addzoom=none(int); prev=none(int); next=none(int); mirror=none(int); blur=none(int); dxmax=none(float); dymax=none(float); zoommax=none(float); rotmax=none(float); subpixel=none(int); pixaspect=none(float); fitlast=none(int); tzoom=none(float); info=none(int); method=none(int); fields=none(int)):ptr VSMap =
  let plug = getPluginById("com.nodame.mvtools")
  let args = createMap()
  propSetNode(args, "clip", clip, paAppend)
  propSetNode(args, "data", data, paAppend)
  if cutoff.isSome:
    propSetFloat(args, "cutoff", cutoff.get, paAppend)
  if damping.isSome:
    propSetFloat(args, "damping", damping.get, paAppend)
  if initzoom.isSome:
    propSetFloat(args, "initzoom", initzoom.get, paAppend)
  if addzoom.isSome:
    propSetInt(args, "addzoom", addzoom.get, paAppend)
  if prev.isSome:
    propSetInt(args, "prev", prev.get, paAppend)
  if next.isSome:
    propSetInt(args, "next", next.get, paAppend)
  if mirror.isSome:
    propSetInt(args, "mirror", mirror.get, paAppend)
  if blur.isSome:
    propSetInt(args, "blur", blur.get, paAppend)
  if dxmax.isSome:
    propSetFloat(args, "dxmax", dxmax.get, paAppend)
  if dymax.isSome:
    propSetFloat(args, "dymax", dymax.get, paAppend)
  if zoommax.isSome:
    propSetFloat(args, "zoommax", zoommax.get, paAppend)
  if rotmax.isSome:
    propSetFloat(args, "rotmax", rotmax.get, paAppend)
  if subpixel.isSome:
    propSetInt(args, "subpixel", subpixel.get, paAppend)
  if pixaspect.isSome:
    propSetFloat(args, "pixaspect", pixaspect.get, paAppend)
  if fitlast.isSome:
    propSetInt(args, "fitlast", fitlast.get, paAppend)
  if tzoom.isSome:
    propSetFloat(args, "tzoom", tzoom.get, paAppend)
  if info.isSome:
    propSetInt(args, "info", info.get, paAppend)
  if method.isSome:
    propSetInt(args, "method", method.get, paAppend)
  if fields.isSome:
    propSetInt(args, "fields", fields.get, paAppend)

  return API.invoke(plug, "DepanStabilise".cstring, args)        

proc Finest(super:ptr VSNodeRef; opt=none(int)):ptr VSMap =
  let plug = getPluginById("com.nodame.mvtools")
  let args = createMap()
  propSetNode(args, "super", super, paAppend)
  if opt.isSome:
    propSetInt(args, "opt", opt.get, paAppend)

  return API.invoke(plug, "Finest".cstring, args)        

proc Flow(clip:ptr VSNodeRef, super:ptr VSNodeRef, vectors:ptr VSNodeRef; time=none(float); mode=none(int); fields=none(int); thscd1=none(int); thscd2=none(int); opt=none(int); tff=none(int)):ptr VSMap =
  let plug = getPluginById("com.nodame.mvtools")
  let args = createMap()
  propSetNode(args, "clip", clip, paAppend)
  propSetNode(args, "super", super, paAppend)
  propSetNode(args, "vectors", vectors, paAppend)
  if time.isSome:
    propSetFloat(args, "time", time.get, paAppend)
  if mode.isSome:
    propSetInt(args, "mode", mode.get, paAppend)
  if fields.isSome:
    propSetInt(args, "fields", fields.get, paAppend)
  if thscd1.isSome:
    propSetInt(args, "thscd1", thscd1.get, paAppend)
  if thscd2.isSome:
    propSetInt(args, "thscd2", thscd2.get, paAppend)
  if opt.isSome:
    propSetInt(args, "opt", opt.get, paAppend)
  if tff.isSome:
    propSetInt(args, "tff", tff.get, paAppend)

  return API.invoke(plug, "Flow".cstring, args)        

proc FlowBlur(clip:ptr VSNodeRef, super:ptr VSNodeRef, mvbw:ptr VSNodeRef, mvfw:ptr VSNodeRef; blur=none(float); prec=none(int); thscd1=none(int); thscd2=none(int); opt=none(int)):ptr VSMap =
  let plug = getPluginById("com.nodame.mvtools")
  let args = createMap()
  propSetNode(args, "clip", clip, paAppend)
  propSetNode(args, "super", super, paAppend)
  propSetNode(args, "mvbw", mvbw, paAppend)
  propSetNode(args, "mvfw", mvfw, paAppend)
  if blur.isSome:
    propSetFloat(args, "blur", blur.get, paAppend)
  if prec.isSome:
    propSetInt(args, "prec", prec.get, paAppend)
  if thscd1.isSome:
    propSetInt(args, "thscd1", thscd1.get, paAppend)
  if thscd2.isSome:
    propSetInt(args, "thscd2", thscd2.get, paAppend)
  if opt.isSome:
    propSetInt(args, "opt", opt.get, paAppend)

  return API.invoke(plug, "FlowBlur".cstring, args)        

proc FlowFPS(clip:ptr VSNodeRef, super:ptr VSNodeRef, mvbw:ptr VSNodeRef, mvfw:ptr VSNodeRef; num=none(int); den=none(int); mask=none(int); ml=none(float); blend=none(int); thscd1=none(int); thscd2=none(int); opt=none(int)):ptr VSMap =
  let plug = getPluginById("com.nodame.mvtools")
  let args = createMap()
  propSetNode(args, "clip", clip, paAppend)
  propSetNode(args, "super", super, paAppend)
  propSetNode(args, "mvbw", mvbw, paAppend)
  propSetNode(args, "mvfw", mvfw, paAppend)
  if num.isSome:
    propSetInt(args, "num", num.get, paAppend)
  if den.isSome:
    propSetInt(args, "den", den.get, paAppend)
  if mask.isSome:
    propSetInt(args, "mask", mask.get, paAppend)
  if ml.isSome:
    propSetFloat(args, "ml", ml.get, paAppend)
  if blend.isSome:
    propSetInt(args, "blend", blend.get, paAppend)
  if thscd1.isSome:
    propSetInt(args, "thscd1", thscd1.get, paAppend)
  if thscd2.isSome:
    propSetInt(args, "thscd2", thscd2.get, paAppend)
  if opt.isSome:
    propSetInt(args, "opt", opt.get, paAppend)

  return API.invoke(plug, "FlowFPS".cstring, args)        

proc FlowInter(clip:ptr VSNodeRef, super:ptr VSNodeRef, mvbw:ptr VSNodeRef, mvfw:ptr VSNodeRef; time=none(float); ml=none(float); blend=none(int); thscd1=none(int); thscd2=none(int); opt=none(int)):ptr VSMap =
  let plug = getPluginById("com.nodame.mvtools")
  let args = createMap()
  propSetNode(args, "clip", clip, paAppend)
  propSetNode(args, "super", super, paAppend)
  propSetNode(args, "mvbw", mvbw, paAppend)
  propSetNode(args, "mvfw", mvfw, paAppend)
  if time.isSome:
    propSetFloat(args, "time", time.get, paAppend)
  if ml.isSome:
    propSetFloat(args, "ml", ml.get, paAppend)
  if blend.isSome:
    propSetInt(args, "blend", blend.get, paAppend)
  if thscd1.isSome:
    propSetInt(args, "thscd1", thscd1.get, paAppend)
  if thscd2.isSome:
    propSetInt(args, "thscd2", thscd2.get, paAppend)
  if opt.isSome:
    propSetInt(args, "opt", opt.get, paAppend)

  return API.invoke(plug, "FlowInter".cstring, args)        

proc Mask(clip:ptr VSNodeRef, vectors:ptr VSNodeRef; ml=none(float); gamma=none(float); kind=none(int); time=none(float); ysc=none(int); thscd1=none(int); thscd2=none(int); opt=none(int)):ptr VSMap =
  let plug = getPluginById("com.nodame.mvtools")
  let args = createMap()
  propSetNode(args, "clip", clip, paAppend)
  propSetNode(args, "vectors", vectors, paAppend)
  if ml.isSome:
    propSetFloat(args, "ml", ml.get, paAppend)
  if gamma.isSome:
    propSetFloat(args, "gamma", gamma.get, paAppend)
  if kind.isSome:
    propSetInt(args, "kind", kind.get, paAppend)
  if time.isSome:
    propSetFloat(args, "time", time.get, paAppend)
  if ysc.isSome:
    propSetInt(args, "ysc", ysc.get, paAppend)
  if thscd1.isSome:
    propSetInt(args, "thscd1", thscd1.get, paAppend)
  if thscd2.isSome:
    propSetInt(args, "thscd2", thscd2.get, paAppend)
  if opt.isSome:
    propSetInt(args, "opt", opt.get, paAppend)

  return API.invoke(plug, "Mask".cstring, args)        

proc Recalculate(super:ptr VSNodeRef, vectors:ptr VSNodeRef; thsad=none(int); smooth=none(int); blksize=none(int); blksizev=none(int); search=none(int); searchparam=none(int); lambda=none(int); chroma=none(int); truemotion=none(int); pnew=none(int); overlap=none(int); overlapv=none(int); divide=none(int); opt=none(int); meander=none(int); fields=none(int); tff=none(int); dct=none(int)):ptr VSMap =
  let plug = getPluginById("com.nodame.mvtools")
  let args = createMap()
  propSetNode(args, "super", super, paAppend)
  propSetNode(args, "vectors", vectors, paAppend)
  if thsad.isSome:
    propSetInt(args, "thsad", thsad.get, paAppend)
  if smooth.isSome:
    propSetInt(args, "smooth", smooth.get, paAppend)
  if blksize.isSome:
    propSetInt(args, "blksize", blksize.get, paAppend)
  if blksizev.isSome:
    propSetInt(args, "blksizev", blksizev.get, paAppend)
  if search.isSome:
    propSetInt(args, "search", search.get, paAppend)
  if searchparam.isSome:
    propSetInt(args, "searchparam", searchparam.get, paAppend)
  if lambda.isSome:
    propSetInt(args, "lambda", lambda.get, paAppend)
  if chroma.isSome:
    propSetInt(args, "chroma", chroma.get, paAppend)
  if truemotion.isSome:
    propSetInt(args, "truemotion", truemotion.get, paAppend)
  if pnew.isSome:
    propSetInt(args, "pnew", pnew.get, paAppend)
  if overlap.isSome:
    propSetInt(args, "overlap", overlap.get, paAppend)
  if overlapv.isSome:
    propSetInt(args, "overlapv", overlapv.get, paAppend)
  if divide.isSome:
    propSetInt(args, "divide", divide.get, paAppend)
  if opt.isSome:
    propSetInt(args, "opt", opt.get, paAppend)
  if meander.isSome:
    propSetInt(args, "meander", meander.get, paAppend)
  if fields.isSome:
    propSetInt(args, "fields", fields.get, paAppend)
  if tff.isSome:
    propSetInt(args, "tff", tff.get, paAppend)
  if dct.isSome:
    propSetInt(args, "dct", dct.get, paAppend)

  return API.invoke(plug, "Recalculate".cstring, args)        

proc SCDetection(clip:ptr VSNodeRef, vectors:ptr VSNodeRef; thscd1=none(int); thscd2=none(int)):ptr VSMap =
  let plug = getPluginById("com.nodame.mvtools")
  let args = createMap()
  propSetNode(args, "clip", clip, paAppend)
  propSetNode(args, "vectors", vectors, paAppend)
  if thscd1.isSome:
    propSetInt(args, "thscd1", thscd1.get, paAppend)
  if thscd2.isSome:
    propSetInt(args, "thscd2", thscd2.get, paAppend)

  return API.invoke(plug, "SCDetection".cstring, args)        

proc Super(clip:ptr VSNodeRef; hpad=none(int); vpad=none(int); pel=none(int); levels=none(int); chroma=none(int); sharp=none(int); rfilter=none(int); pelclip=none(ptr VSNodeRef); opt=none(int)):ptr VSMap =
  let plug = getPluginById("com.nodame.mvtools")
  let args = createMap()
  propSetNode(args, "clip", clip, paAppend)
  if hpad.isSome:
    propSetInt(args, "hpad", hpad.get, paAppend)
  if vpad.isSome:
    propSetInt(args, "vpad", vpad.get, paAppend)
  if pel.isSome:
    propSetInt(args, "pel", pel.get, paAppend)
  if levels.isSome:
    propSetInt(args, "levels", levels.get, paAppend)
  if chroma.isSome:
    propSetInt(args, "chroma", chroma.get, paAppend)
  if sharp.isSome:
    propSetInt(args, "sharp", sharp.get, paAppend)
  if rfilter.isSome:
    propSetInt(args, "rfilter", rfilter.get, paAppend)
  if pelclip.isSome:
    propSetNode(args, "pelclip", pelclip.get, paAppend)
  if opt.isSome:
    propSetInt(args, "opt", opt.get, paAppend)

  return API.invoke(plug, "Super".cstring, args)        

