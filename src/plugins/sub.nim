proc ImageFile*(vsmap:ptr VSMap, file:string; id=none(int); palette=none(seq[int]); gray=none(int); info=none(int); flatten=none(int); blend=none(int); matrix=none(int); matrix_s=none(string); transfer=none(int); transfer_s=none(string); primaries=none(int); primaries_s=none(string)):ptr VSMap =
  let plug = getPluginById("biz.srsfckn.subtext")
  if plug == nil:
    raise newException(ValueError, "plugin \"sub\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq
  if tmpSeq.len != 1:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  let args = createMap()
  propSetNode(args, "clip", clip, paAppend)
  propSetData(args, "file", file, paAppend)
  if id.isSome:
    propSetInt(args, "id", id.get, paAppend)
  if palette.isSome:
    propSetIntArray(args, "palette", palette.get)
  if gray.isSome:
    propSetInt(args, "gray", gray.get, paAppend)
  if info.isSome:
    propSetInt(args, "info", info.get, paAppend)
  if flatten.isSome:
    propSetInt(args, "flatten", flatten.get, paAppend)
  if blend.isSome:
    propSetInt(args, "blend", blend.get, paAppend)
  if matrix.isSome:
    propSetInt(args, "matrix", matrix.get, paAppend)
  if matrix_s.isSome:
    propSetData(args, "matrix_s", matrix_s.get, paAppend)
  if transfer.isSome:
    propSetInt(args, "transfer", transfer.get, paAppend)
  if transfer_s.isSome:
    propSetData(args, "transfer_s", transfer_s.get, paAppend)
  if primaries.isSome:
    propSetInt(args, "primaries", primaries.get, paAppend)
  if primaries_s.isSome:
    propSetData(args, "primaries_s", primaries_s.get, paAppend)

  return API.invoke(plug, "ImageFile".cstring, args)        

proc Subtitle*(vsmap:ptr VSMap, text:string; start=none(int); `end`=none(int); debuglevel=none(int); fontdir=none(string); linespacing=none(float); margins=none(seq[int]); sar=none(float); style=none(string); blend=none(int); matrix=none(int); matrix_s=none(string); transfer=none(int); transfer_s=none(string); primaries=none(int); primaries_s=none(string)):ptr VSMap =
  let plug = getPluginById("biz.srsfckn.subtext")
  if plug == nil:
    raise newException(ValueError, "plugin \"sub\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq
  if tmpSeq.len != 1:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  let args = createMap()
  propSetNode(args, "clip", clip, paAppend)
  propSetData(args, "text", text, paAppend)
  if start.isSome:
    propSetInt(args, "start", start.get, paAppend)
  if `end`.isSome:
    propSetInt(args, "end", `end`.get, paAppend)
  if debuglevel.isSome:
    propSetInt(args, "debuglevel", debuglevel.get, paAppend)
  if fontdir.isSome:
    propSetData(args, "fontdir", fontdir.get, paAppend)
  if linespacing.isSome:
    propSetFloat(args, "linespacing", linespacing.get, paAppend)
  if margins.isSome:
    propSetIntArray(args, "margins", margins.get)
  if sar.isSome:
    propSetFloat(args, "sar", sar.get, paAppend)
  if style.isSome:
    propSetData(args, "style", style.get, paAppend)
  if blend.isSome:
    propSetInt(args, "blend", blend.get, paAppend)
  if matrix.isSome:
    propSetInt(args, "matrix", matrix.get, paAppend)
  if matrix_s.isSome:
    propSetData(args, "matrix_s", matrix_s.get, paAppend)
  if transfer.isSome:
    propSetInt(args, "transfer", transfer.get, paAppend)
  if transfer_s.isSome:
    propSetData(args, "transfer_s", transfer_s.get, paAppend)
  if primaries.isSome:
    propSetInt(args, "primaries", primaries.get, paAppend)
  if primaries_s.isSome:
    propSetData(args, "primaries_s", primaries_s.get, paAppend)

  return API.invoke(plug, "Subtitle".cstring, args)        

proc TextFile*(vsmap:ptr VSMap, file:string; charset=none(string); scale=none(float); debuglevel=none(int); fontdir=none(string); linespacing=none(float); margins=none(seq[int]); sar=none(float); style=none(string); blend=none(int); matrix=none(int); matrix_s=none(string); transfer=none(int); transfer_s=none(string); primaries=none(int); primaries_s=none(string)):ptr VSMap =
  let plug = getPluginById("biz.srsfckn.subtext")
  if plug == nil:
    raise newException(ValueError, "plugin \"sub\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq
  if tmpSeq.len != 1:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  let args = createMap()
  propSetNode(args, "clip", clip, paAppend)
  propSetData(args, "file", file, paAppend)
  if charset.isSome:
    propSetData(args, "charset", charset.get, paAppend)
  if scale.isSome:
    propSetFloat(args, "scale", scale.get, paAppend)
  if debuglevel.isSome:
    propSetInt(args, "debuglevel", debuglevel.get, paAppend)
  if fontdir.isSome:
    propSetData(args, "fontdir", fontdir.get, paAppend)
  if linespacing.isSome:
    propSetFloat(args, "linespacing", linespacing.get, paAppend)
  if margins.isSome:
    propSetIntArray(args, "margins", margins.get)
  if sar.isSome:
    propSetFloat(args, "sar", sar.get, paAppend)
  if style.isSome:
    propSetData(args, "style", style.get, paAppend)
  if blend.isSome:
    propSetInt(args, "blend", blend.get, paAppend)
  if matrix.isSome:
    propSetInt(args, "matrix", matrix.get, paAppend)
  if matrix_s.isSome:
    propSetData(args, "matrix_s", matrix_s.get, paAppend)
  if transfer.isSome:
    propSetInt(args, "transfer", transfer.get, paAppend)
  if transfer_s.isSome:
    propSetData(args, "transfer_s", transfer_s.get, paAppend)
  if primaries.isSome:
    propSetInt(args, "primaries", primaries.get, paAppend)
  if primaries_s.isSome:
    propSetData(args, "primaries_s", primaries_s.get, paAppend)

  return API.invoke(plug, "TextFile".cstring, args)        

