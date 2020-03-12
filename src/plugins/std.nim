proc AddBorders*(vsmap:ptr VSMap; left=none(int); right=none(int); top=none(int); bottom=none(int); color=none(seq[float])):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.std")
  if plug == nil:
    raise newException(ValueError, "plugin \"std\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq
  if tmpSeq.len != 1:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  let args = createMap()
  propSetNode(args, "clip", clip, paAppend)
  if left.isSome:
    propSetInt(args, "left", left.get, paAppend)
  if right.isSome:
    propSetInt(args, "right", right.get, paAppend)
  if top.isSome:
    propSetInt(args, "top", top.get, paAppend)
  if bottom.isSome:
    propSetInt(args, "bottom", bottom.get, paAppend)
  if color.isSome:
    propSetFloatArray(args, "color", color.get)

  return API.invoke(plug, "AddBorders".cstring, args)        

proc AssumeFPS*(vsmap:ptr VSMap; src=none(ptr VSNodeRef); fpsnum=none(int); fpsden=none(int)):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.std")
  if plug == nil:
    raise newException(ValueError, "plugin \"std\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq
  if tmpSeq.len != 1:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  let args = createMap()
  propSetNode(args, "clip", clip, paAppend)
  if src.isSome:
    propSetNode(args, "src", src.get, paAppend)
  if fpsnum.isSome:
    propSetInt(args, "fpsnum", fpsnum.get, paAppend)
  if fpsden.isSome:
    propSetInt(args, "fpsden", fpsden.get, paAppend)

  return API.invoke(plug, "AssumeFPS".cstring, args)        

proc Binarize*(vsmap:ptr VSMap; threshold=none(seq[float]); v0=none(seq[float]); v1=none(seq[float]); planes=none(seq[int])):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.std")
  if plug == nil:
    raise newException(ValueError, "plugin \"std\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq
  if tmpSeq.len != 1:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  let args = createMap()
  propSetNode(args, "clip", clip, paAppend)
  if threshold.isSome:
    propSetFloatArray(args, "threshold", threshold.get)
  if v0.isSome:
    propSetFloatArray(args, "v0", v0.get)
  if v1.isSome:
    propSetFloatArray(args, "v1", v1.get)
  if planes.isSome:
    propSetIntArray(args, "planes", planes.get)

  return API.invoke(plug, "Binarize".cstring, args)        

proc BlankClip*(vsmap:ptr VSMap; width=none(int); height=none(int); format=none(int); length=none(int); fpsnum=none(int); fpsden=none(int); color=none(seq[float]); keep=none(int)):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.std")
  if plug == nil:
    raise newException(ValueError, "plugin \"std\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq
  if tmpSeq.len != 1:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = some(tmpSeq[0].nodes[0])


  let args = createMap()
  if clip.isSome:
    propSetNode(args, "clip", clip.get, paAppend)
  if width.isSome:
    propSetInt(args, "width", width.get, paAppend)
  if height.isSome:
    propSetInt(args, "height", height.get, paAppend)
  if format.isSome:
    propSetInt(args, "format", format.get, paAppend)
  if length.isSome:
    propSetInt(args, "length", length.get, paAppend)
  if fpsnum.isSome:
    propSetInt(args, "fpsnum", fpsnum.get, paAppend)
  if fpsden.isSome:
    propSetInt(args, "fpsden", fpsden.get, paAppend)
  if color.isSome:
    propSetFloatArray(args, "color", color.get)
  if keep.isSome:
    propSetInt(args, "keep", keep.get, paAppend)

  return API.invoke(plug, "BlankClip".cstring, args)        

proc BoxBlur*(vsmap:ptr VSMap; planes=none(seq[int]); hradius=none(int); hpasses=none(int); vradius=none(int); vpasses=none(int)):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.std")
  if plug == nil:
    raise newException(ValueError, "plugin \"std\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq
  if tmpSeq.len != 1:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  let args = createMap()
  propSetNode(args, "clip", clip, paAppend)
  if planes.isSome:
    propSetIntArray(args, "planes", planes.get)
  if hradius.isSome:
    propSetInt(args, "hradius", hradius.get, paAppend)
  if hpasses.isSome:
    propSetInt(args, "hpasses", hpasses.get, paAppend)
  if vradius.isSome:
    propSetInt(args, "vradius", vradius.get, paAppend)
  if vpasses.isSome:
    propSetInt(args, "vpasses", vpasses.get, paAppend)

  return API.invoke(plug, "BoxBlur".cstring, args)        

proc Cache*(vsmap:ptr VSMap; size=none(int); fixed=none(int); make_linear=none(int)):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.std")
  if plug == nil:
    raise newException(ValueError, "plugin \"std\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq
  if tmpSeq.len != 1:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  let args = createMap()
  propSetNode(args, "clip", clip, paAppend)
  if size.isSome:
    propSetInt(args, "size", size.get, paAppend)
  if fixed.isSome:
    propSetInt(args, "fixed", fixed.get, paAppend)
  if make_linear.isSome:
    propSetInt(args, "make_linear", make_linear.get, paAppend)

  return API.invoke(plug, "Cache".cstring, args)        

proc ClipToProp*(vsmap:ptr VSMap, mclip:ptr VSNodeRef; prop=none(string)):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.std")
  if plug == nil:
    raise newException(ValueError, "plugin \"std\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq
  if tmpSeq.len != 1:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  let args = createMap()
  propSetNode(args, "clip", clip, paAppend)
  propSetNode(args, "mclip", mclip, paAppend)
  if prop.isSome:
    propSetData(args, "prop", prop.get, paAppend)

  return API.invoke(plug, "ClipToProp".cstring, args)        

proc Convolution*(vsmap:ptr VSMap, matrix:seq[float]; bias=none(float); divisor=none(float); planes=none(seq[int]); saturate=none(int); mode=none(string)):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.std")
  if plug == nil:
    raise newException(ValueError, "plugin \"std\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq
  if tmpSeq.len != 1:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  let args = createMap()
  propSetNode(args, "clip", clip, paAppend)
  propSetFloatArray(args, "matrix", matrix)
  if bias.isSome:
    propSetFloat(args, "bias", bias.get, paAppend)
  if divisor.isSome:
    propSetFloat(args, "divisor", divisor.get, paAppend)
  if planes.isSome:
    propSetIntArray(args, "planes", planes.get)
  if saturate.isSome:
    propSetInt(args, "saturate", saturate.get, paAppend)
  if mode.isSome:
    propSetData(args, "mode", mode.get, paAppend)

  return API.invoke(plug, "Convolution".cstring, args)        

proc Crop*(vsmap:ptr VSMap; left=none(int); right=none(int); top=none(int); bottom=none(int)):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.std")
  if plug == nil:
    raise newException(ValueError, "plugin \"std\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq
  if tmpSeq.len != 1:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  let args = createMap()
  propSetNode(args, "clip", clip, paAppend)
  if left.isSome:
    propSetInt(args, "left", left.get, paAppend)
  if right.isSome:
    propSetInt(args, "right", right.get, paAppend)
  if top.isSome:
    propSetInt(args, "top", top.get, paAppend)
  if bottom.isSome:
    propSetInt(args, "bottom", bottom.get, paAppend)

  return API.invoke(plug, "Crop".cstring, args)        

proc CropAbs*(vsmap:ptr VSMap, width:int, height:int; left=none(int); top=none(int); x=none(int); y=none(int)):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.std")
  if plug == nil:
    raise newException(ValueError, "plugin \"std\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq
  if tmpSeq.len != 1:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  let args = createMap()
  propSetNode(args, "clip", clip, paAppend)
  propSetInt(args, "width", width, paAppend)
  propSetInt(args, "height", height, paAppend)
  if left.isSome:
    propSetInt(args, "left", left.get, paAppend)
  if top.isSome:
    propSetInt(args, "top", top.get, paAppend)
  if x.isSome:
    propSetInt(args, "x", x.get, paAppend)
  if y.isSome:
    propSetInt(args, "y", y.get, paAppend)

  return API.invoke(plug, "CropAbs".cstring, args)        

proc CropRel*(vsmap:ptr VSMap; left=none(int); right=none(int); top=none(int); bottom=none(int)):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.std")
  if plug == nil:
    raise newException(ValueError, "plugin \"std\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq
  if tmpSeq.len != 1:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  let args = createMap()
  propSetNode(args, "clip", clip, paAppend)
  if left.isSome:
    propSetInt(args, "left", left.get, paAppend)
  if right.isSome:
    propSetInt(args, "right", right.get, paAppend)
  if top.isSome:
    propSetInt(args, "top", top.get, paAppend)
  if bottom.isSome:
    propSetInt(args, "bottom", bottom.get, paAppend)

  return API.invoke(plug, "CropRel".cstring, args)        

proc Deflate*(vsmap:ptr VSMap; planes=none(seq[int]); threshold=none(float)):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.std")
  if plug == nil:
    raise newException(ValueError, "plugin \"std\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq
  if tmpSeq.len != 1:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  let args = createMap()
  propSetNode(args, "clip", clip, paAppend)
  if planes.isSome:
    propSetIntArray(args, "planes", planes.get)
  if threshold.isSome:
    propSetFloat(args, "threshold", threshold.get, paAppend)

  return API.invoke(plug, "Deflate".cstring, args)        

proc DeleteFrames*(vsmap:ptr VSMap, frames:seq[int]):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.std")
  if plug == nil:
    raise newException(ValueError, "plugin \"std\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq
  if tmpSeq.len != 1:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  let args = createMap()
  propSetNode(args, "clip", clip, paAppend)
  propSetIntArray(args, "frames", frames)

  return API.invoke(plug, "DeleteFrames".cstring, args)        

proc DoubleWeave*(vsmap:ptr VSMap; tff=none(int)):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.std")
  if plug == nil:
    raise newException(ValueError, "plugin \"std\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq
  if tmpSeq.len != 1:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  let args = createMap()
  propSetNode(args, "clip", clip, paAppend)
  if tff.isSome:
    propSetInt(args, "tff", tff.get, paAppend)

  return API.invoke(plug, "DoubleWeave".cstring, args)        

proc DuplicateFrames*(vsmap:ptr VSMap, frames:seq[int]):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.std")
  if plug == nil:
    raise newException(ValueError, "plugin \"std\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq
  if tmpSeq.len != 1:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  let args = createMap()
  propSetNode(args, "clip", clip, paAppend)
  propSetIntArray(args, "frames", frames)

  return API.invoke(plug, "DuplicateFrames".cstring, args)        

proc Expr*(vsmap:ptr VSMap, expr:seq[string]; format=none(int)):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.std")
  if plug == nil:
    raise newException(ValueError, "plugin \"std\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq
  if tmpSeq.len != 1:
    raise newException(ValueError, "the vsmap should contain one item")
  if tmpSeq[0].nodes.len >= 1:
    raise newException(ValueError, "the vsmap should contain a seq with nodes")
  var clips = tmpSeq[0].nodes


  let args = createMap()
  for item in clips:
    propSetNode(args, "clips", item, paAppend)
  for item in expr:
    propSetData(args, "expr", item, paAppend)
  if format.isSome:
    propSetInt(args, "format", format.get, paAppend)

  return API.invoke(plug, "Expr".cstring, args)        

proc FlipHorizontal*(vsmap:ptr VSMap):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.std")
  if plug == nil:
    raise newException(ValueError, "plugin \"std\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq
  if tmpSeq.len != 1:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  let args = createMap()
  propSetNode(args, "clip", clip, paAppend)

  return API.invoke(plug, "FlipHorizontal".cstring, args)        

proc FlipVertical*(vsmap:ptr VSMap):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.std")
  if plug == nil:
    raise newException(ValueError, "plugin \"std\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq
  if tmpSeq.len != 1:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  let args = createMap()
  propSetNode(args, "clip", clip, paAppend)

  return API.invoke(plug, "FlipVertical".cstring, args)        

proc FrameEval*(vsmap:ptr VSMap, eval:ptr VSFuncRef; prop_src=none(seq[ptr VSNodeRef])):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.std")
  if plug == nil:
    raise newException(ValueError, "plugin \"std\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq
  if tmpSeq.len != 1:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  let args = createMap()
  propSetNode(args, "clip", clip, paAppend)
  propSetFunc(args, "eval", eval, paAppend)
  if prop_src.isSome:
    for item in prop_src.get:
      propSetNode(args, "prop_src", item, paAppend)

  return API.invoke(plug, "FrameEval".cstring, args)        

proc FreezeFrames*(vsmap:ptr VSMap, first:seq[int], last:seq[int], replacement:seq[int]):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.std")
  if plug == nil:
    raise newException(ValueError, "plugin \"std\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq
  if tmpSeq.len != 1:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  let args = createMap()
  propSetNode(args, "clip", clip, paAppend)
  propSetIntArray(args, "first", first)
  propSetIntArray(args, "last", last)
  propSetIntArray(args, "replacement", replacement)

  return API.invoke(plug, "FreezeFrames".cstring, args)        

proc Inflate*(vsmap:ptr VSMap; planes=none(seq[int]); threshold=none(float)):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.std")
  if plug == nil:
    raise newException(ValueError, "plugin \"std\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq
  if tmpSeq.len != 1:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  let args = createMap()
  propSetNode(args, "clip", clip, paAppend)
  if planes.isSome:
    propSetIntArray(args, "planes", planes.get)
  if threshold.isSome:
    propSetFloat(args, "threshold", threshold.get, paAppend)

  return API.invoke(plug, "Inflate".cstring, args)        

proc Interleave*(vsmap:ptr VSMap; extend=none(int); mismatch=none(int)):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.std")
  if plug == nil:
    raise newException(ValueError, "plugin \"std\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq
  if tmpSeq.len != 1:
    raise newException(ValueError, "the vsmap should contain one item")
  if tmpSeq[0].nodes.len >= 1:
    raise newException(ValueError, "the vsmap should contain a seq with nodes")
  var clips = tmpSeq[0].nodes


  let args = createMap()
  for item in clips:
    propSetNode(args, "clips", item, paAppend)
  if extend.isSome:
    propSetInt(args, "extend", extend.get, paAppend)
  if mismatch.isSome:
    propSetInt(args, "mismatch", mismatch.get, paAppend)

  return API.invoke(plug, "Interleave".cstring, args)        

proc Invert*(vsmap:ptr VSMap; planes=none(seq[int])):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.std")
  if plug == nil:
    raise newException(ValueError, "plugin \"std\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq
  if tmpSeq.len != 1:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  let args = createMap()
  propSetNode(args, "clip", clip, paAppend)
  if planes.isSome:
    propSetIntArray(args, "planes", planes.get)

  return API.invoke(plug, "Invert".cstring, args)        

proc Levels*(vsmap:ptr VSMap; min_in=none(seq[float]); max_in=none(seq[float]); gamma=none(seq[float]); min_out=none(seq[float]); max_out=none(seq[float]); planes=none(seq[int])):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.std")
  if plug == nil:
    raise newException(ValueError, "plugin \"std\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq
  if tmpSeq.len != 1:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  let args = createMap()
  propSetNode(args, "clip", clip, paAppend)
  if min_in.isSome:
    propSetFloatArray(args, "min_in", min_in.get)
  if max_in.isSome:
    propSetFloatArray(args, "max_in", max_in.get)
  if gamma.isSome:
    propSetFloatArray(args, "gamma", gamma.get)
  if min_out.isSome:
    propSetFloatArray(args, "min_out", min_out.get)
  if max_out.isSome:
    propSetFloatArray(args, "max_out", max_out.get)
  if planes.isSome:
    propSetIntArray(args, "planes", planes.get)

  return API.invoke(plug, "Levels".cstring, args)        

proc Limiter*(vsmap:ptr VSMap; min=none(seq[float]); max=none(seq[float]); planes=none(seq[int])):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.std")
  if plug == nil:
    raise newException(ValueError, "plugin \"std\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq
  if tmpSeq.len != 1:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  let args = createMap()
  propSetNode(args, "clip", clip, paAppend)
  if min.isSome:
    propSetFloatArray(args, "min", min.get)
  if max.isSome:
    propSetFloatArray(args, "max", max.get)
  if planes.isSome:
    propSetIntArray(args, "planes", planes.get)

  return API.invoke(plug, "Limiter".cstring, args)        

proc LoadPlugin*(path:string; altsearchpath=none(int); forcens=none(string); forceid=none(string)):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.std")
  if plug == nil:
    raise newException(ValueError, "plugin \"std\" not installed properly in your computer")

  let args = createMap()
  propSetData(args, "path", path, paAppend)
  if altsearchpath.isSome:
    propSetInt(args, "altsearchpath", altsearchpath.get, paAppend)
  if forcens.isSome:
    propSetData(args, "forcens", forcens.get, paAppend)
  if forceid.isSome:
    propSetData(args, "forceid", forceid.get, paAppend)

  return API.invoke(plug, "LoadPlugin".cstring, args)        

proc Loop*(vsmap:ptr VSMap; times=none(int)):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.std")
  if plug == nil:
    raise newException(ValueError, "plugin \"std\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq
  if tmpSeq.len != 1:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  let args = createMap()
  propSetNode(args, "clip", clip, paAppend)
  if times.isSome:
    propSetInt(args, "times", times.get, paAppend)

  return API.invoke(plug, "Loop".cstring, args)        

proc Lut*(vsmap:ptr VSMap; planes=none(seq[int]); lut=none(seq[int]); lutf=none(seq[float]); function=none(ptr VSFuncRef); bits=none(int); floatout=none(int)):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.std")
  if plug == nil:
    raise newException(ValueError, "plugin \"std\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq
  if tmpSeq.len != 1:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  let args = createMap()
  propSetNode(args, "clip", clip, paAppend)
  if planes.isSome:
    propSetIntArray(args, "planes", planes.get)
  if lut.isSome:
    propSetIntArray(args, "lut", lut.get)
  if lutf.isSome:
    propSetFloatArray(args, "lutf", lutf.get)
  if function.isSome:
    propSetFunc(args, "function", function.get, paAppend)
  if bits.isSome:
    propSetInt(args, "bits", bits.get, paAppend)
  if floatout.isSome:
    propSetInt(args, "floatout", floatout.get, paAppend)

  return API.invoke(plug, "Lut".cstring, args)        

proc Lut2*(vsmap:ptr VSMap, clipb:ptr VSNodeRef; planes=none(seq[int]); lut=none(seq[int]); lutf=none(seq[float]); function=none(ptr VSFuncRef); bits=none(int); floatout=none(int)):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.std")
  if plug == nil:
    raise newException(ValueError, "plugin \"std\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq
  if tmpSeq.len != 1:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clipa = tmpSeq[0].nodes[0]


  let args = createMap()
  propSetNode(args, "clipa", clipa, paAppend)
  propSetNode(args, "clipb", clipb, paAppend)
  if planes.isSome:
    propSetIntArray(args, "planes", planes.get)
  if lut.isSome:
    propSetIntArray(args, "lut", lut.get)
  if lutf.isSome:
    propSetFloatArray(args, "lutf", lutf.get)
  if function.isSome:
    propSetFunc(args, "function", function.get, paAppend)
  if bits.isSome:
    propSetInt(args, "bits", bits.get, paAppend)
  if floatout.isSome:
    propSetInt(args, "floatout", floatout.get, paAppend)

  return API.invoke(plug, "Lut2".cstring, args)        

proc MakeDiff*(vsmap:ptr VSMap, clipb:ptr VSNodeRef; planes=none(seq[int])):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.std")
  if plug == nil:
    raise newException(ValueError, "plugin \"std\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq
  if tmpSeq.len != 1:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clipa = tmpSeq[0].nodes[0]


  let args = createMap()
  propSetNode(args, "clipa", clipa, paAppend)
  propSetNode(args, "clipb", clipb, paAppend)
  if planes.isSome:
    propSetIntArray(args, "planes", planes.get)

  return API.invoke(plug, "MakeDiff".cstring, args)        

proc MaskedMerge*(vsmap:ptr VSMap, clipb:ptr VSNodeRef, mask:ptr VSNodeRef; planes=none(seq[int]); first_plane=none(int); premultiplied=none(int)):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.std")
  if plug == nil:
    raise newException(ValueError, "plugin \"std\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq
  if tmpSeq.len != 1:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clipa = tmpSeq[0].nodes[0]


  let args = createMap()
  propSetNode(args, "clipa", clipa, paAppend)
  propSetNode(args, "clipb", clipb, paAppend)
  propSetNode(args, "mask", mask, paAppend)
  if planes.isSome:
    propSetIntArray(args, "planes", planes.get)
  if first_plane.isSome:
    propSetInt(args, "first_plane", first_plane.get, paAppend)
  if premultiplied.isSome:
    propSetInt(args, "premultiplied", premultiplied.get, paAppend)

  return API.invoke(plug, "MaskedMerge".cstring, args)        

proc Maximum*(vsmap:ptr VSMap; planes=none(seq[int]); threshold=none(float); coordinates=none(seq[int])):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.std")
  if plug == nil:
    raise newException(ValueError, "plugin \"std\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq
  if tmpSeq.len != 1:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  let args = createMap()
  propSetNode(args, "clip", clip, paAppend)
  if planes.isSome:
    propSetIntArray(args, "planes", planes.get)
  if threshold.isSome:
    propSetFloat(args, "threshold", threshold.get, paAppend)
  if coordinates.isSome:
    propSetIntArray(args, "coordinates", coordinates.get)

  return API.invoke(plug, "Maximum".cstring, args)        

proc Median*(vsmap:ptr VSMap; planes=none(seq[int])):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.std")
  if plug == nil:
    raise newException(ValueError, "plugin \"std\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq
  if tmpSeq.len != 1:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  let args = createMap()
  propSetNode(args, "clip", clip, paAppend)
  if planes.isSome:
    propSetIntArray(args, "planes", planes.get)

  return API.invoke(plug, "Median".cstring, args)        

proc Merge*(vsmap:ptr VSMap, clipb:ptr VSNodeRef; weight=none(seq[float])):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.std")
  if plug == nil:
    raise newException(ValueError, "plugin \"std\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq
  if tmpSeq.len != 1:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clipa = tmpSeq[0].nodes[0]


  let args = createMap()
  propSetNode(args, "clipa", clipa, paAppend)
  propSetNode(args, "clipb", clipb, paAppend)
  if weight.isSome:
    propSetFloatArray(args, "weight", weight.get)

  return API.invoke(plug, "Merge".cstring, args)        

proc MergeDiff*(vsmap:ptr VSMap, clipb:ptr VSNodeRef; planes=none(seq[int])):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.std")
  if plug == nil:
    raise newException(ValueError, "plugin \"std\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq
  if tmpSeq.len != 1:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clipa = tmpSeq[0].nodes[0]


  let args = createMap()
  propSetNode(args, "clipa", clipa, paAppend)
  propSetNode(args, "clipb", clipb, paAppend)
  if planes.isSome:
    propSetIntArray(args, "planes", planes.get)

  return API.invoke(plug, "MergeDiff".cstring, args)        

proc Minimum*(vsmap:ptr VSMap; planes=none(seq[int]); threshold=none(float); coordinates=none(seq[int])):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.std")
  if plug == nil:
    raise newException(ValueError, "plugin \"std\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq
  if tmpSeq.len != 1:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  let args = createMap()
  propSetNode(args, "clip", clip, paAppend)
  if planes.isSome:
    propSetIntArray(args, "planes", planes.get)
  if threshold.isSome:
    propSetFloat(args, "threshold", threshold.get, paAppend)
  if coordinates.isSome:
    propSetIntArray(args, "coordinates", coordinates.get)

  return API.invoke(plug, "Minimum".cstring, args)        

proc ModifyFrame*(vsmap:ptr VSMap, clips:seq[ptr VSNodeRef], selector:ptr VSFuncRef):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.std")
  if plug == nil:
    raise newException(ValueError, "plugin \"std\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq
  if tmpSeq.len != 1:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  let args = createMap()
  propSetNode(args, "clip", clip, paAppend)
  for item in clips:
    propSetNode(args, "clips", item, paAppend)
  propSetFunc(args, "selector", selector, paAppend)

  return API.invoke(plug, "ModifyFrame".cstring, args)        

proc PEMVerifier*(vsmap:ptr VSMap; upper=none(seq[float]); lower=none(seq[float])):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.std")
  if plug == nil:
    raise newException(ValueError, "plugin \"std\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq
  if tmpSeq.len != 1:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  let args = createMap()
  propSetNode(args, "clip", clip, paAppend)
  if upper.isSome:
    propSetFloatArray(args, "upper", upper.get)
  if lower.isSome:
    propSetFloatArray(args, "lower", lower.get)

  return API.invoke(plug, "PEMVerifier".cstring, args)        

proc PlaneStats*(vsmap:ptr VSMap; clipb=none(ptr VSNodeRef); plane=none(int); prop=none(string)):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.std")
  if plug == nil:
    raise newException(ValueError, "plugin \"std\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq
  if tmpSeq.len != 1:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clipa = tmpSeq[0].nodes[0]


  let args = createMap()
  propSetNode(args, "clipa", clipa, paAppend)
  if clipb.isSome:
    propSetNode(args, "clipb", clipb.get, paAppend)
  if plane.isSome:
    propSetInt(args, "plane", plane.get, paAppend)
  if prop.isSome:
    propSetData(args, "prop", prop.get, paAppend)

  return API.invoke(plug, "PlaneStats".cstring, args)        

proc PreMultiply*(vsmap:ptr VSMap, alpha:ptr VSNodeRef):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.std")
  if plug == nil:
    raise newException(ValueError, "plugin \"std\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq
  if tmpSeq.len != 1:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  let args = createMap()
  propSetNode(args, "clip", clip, paAppend)
  propSetNode(args, "alpha", alpha, paAppend)

  return API.invoke(plug, "PreMultiply".cstring, args)        

proc Prewitt*(vsmap:ptr VSMap; planes=none(seq[int]); scale=none(float)):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.std")
  if plug == nil:
    raise newException(ValueError, "plugin \"std\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq
  if tmpSeq.len != 1:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  let args = createMap()
  propSetNode(args, "clip", clip, paAppend)
  if planes.isSome:
    propSetIntArray(args, "planes", planes.get)
  if scale.isSome:
    propSetFloat(args, "scale", scale.get, paAppend)

  return API.invoke(plug, "Prewitt".cstring, args)        

proc PropToClip*(vsmap:ptr VSMap; prop=none(string)):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.std")
  if plug == nil:
    raise newException(ValueError, "plugin \"std\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq
  if tmpSeq.len != 1:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  let args = createMap()
  propSetNode(args, "clip", clip, paAppend)
  if prop.isSome:
    propSetData(args, "prop", prop.get, paAppend)

  return API.invoke(plug, "PropToClip".cstring, args)        

proc Reverse*(vsmap:ptr VSMap):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.std")
  if plug == nil:
    raise newException(ValueError, "plugin \"std\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq
  if tmpSeq.len != 1:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  let args = createMap()
  propSetNode(args, "clip", clip, paAppend)

  return API.invoke(plug, "Reverse".cstring, args)        

proc SelectEvery*(vsmap:ptr VSMap, cycle:int, offsets:seq[int]):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.std")
  if plug == nil:
    raise newException(ValueError, "plugin \"std\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq
  if tmpSeq.len != 1:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  let args = createMap()
  propSetNode(args, "clip", clip, paAppend)
  propSetInt(args, "cycle", cycle, paAppend)
  propSetIntArray(args, "offsets", offsets)

  return API.invoke(plug, "SelectEvery".cstring, args)        

proc SeparateFields*(vsmap:ptr VSMap; tff=none(int)):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.std")
  if plug == nil:
    raise newException(ValueError, "plugin \"std\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq
  if tmpSeq.len != 1:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  let args = createMap()
  propSetNode(args, "clip", clip, paAppend)
  if tff.isSome:
    propSetInt(args, "tff", tff.get, paAppend)

  return API.invoke(plug, "SeparateFields".cstring, args)        

proc SetFieldBased*(vsmap:ptr VSMap, value:int):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.std")
  if plug == nil:
    raise newException(ValueError, "plugin \"std\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq
  if tmpSeq.len != 1:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  let args = createMap()
  propSetNode(args, "clip", clip, paAppend)
  propSetInt(args, "value", value, paAppend)

  return API.invoke(plug, "SetFieldBased".cstring, args)        

proc SetFrameProp*(vsmap:ptr VSMap, prop:string; delete=none(int); intval=none(seq[int]); floatval=none(seq[float]); data=none(seq[string])):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.std")
  if plug == nil:
    raise newException(ValueError, "plugin \"std\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq
  if tmpSeq.len != 1:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  let args = createMap()
  propSetNode(args, "clip", clip, paAppend)
  propSetData(args, "prop", prop, paAppend)
  if delete.isSome:
    propSetInt(args, "delete", delete.get, paAppend)
  if intval.isSome:
    propSetIntArray(args, "intval", intval.get)
  if floatval.isSome:
    propSetFloatArray(args, "floatval", floatval.get)
  if data.isSome:
    for item in data.get:
      propSetData(args, "data", item, paAppend)

  return API.invoke(plug, "SetFrameProp".cstring, args)        

proc SetMaxCPU*(cpu:string):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.std")
  if plug == nil:
    raise newException(ValueError, "plugin \"std\" not installed properly in your computer")

  let args = createMap()
  propSetData(args, "cpu", cpu, paAppend)

  return API.invoke(plug, "SetMaxCPU".cstring, args)        

proc ShufflePlanes*(vsmap:ptr VSMap, planes:seq[int], colorfamily:int):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.std")
  if plug == nil:
    raise newException(ValueError, "plugin \"std\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq
  if tmpSeq.len != 1:
    raise newException(ValueError, "the vsmap should contain one item")
  if tmpSeq[0].nodes.len >= 1:
    raise newException(ValueError, "the vsmap should contain a seq with nodes")
  var clips = tmpSeq[0].nodes


  let args = createMap()
  for item in clips:
    propSetNode(args, "clips", item, paAppend)
  propSetIntArray(args, "planes", planes)
  propSetInt(args, "colorfamily", colorfamily, paAppend)

  return API.invoke(plug, "ShufflePlanes".cstring, args)        

proc Sobel*(vsmap:ptr VSMap; planes=none(seq[int]); scale=none(float)):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.std")
  if plug == nil:
    raise newException(ValueError, "plugin \"std\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq
  if tmpSeq.len != 1:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  let args = createMap()
  propSetNode(args, "clip", clip, paAppend)
  if planes.isSome:
    propSetIntArray(args, "planes", planes.get)
  if scale.isSome:
    propSetFloat(args, "scale", scale.get, paAppend)

  return API.invoke(plug, "Sobel".cstring, args)        

proc Splice*(vsmap:ptr VSMap; mismatch=none(int)):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.std")
  if plug == nil:
    raise newException(ValueError, "plugin \"std\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq
  if tmpSeq.len != 1:
    raise newException(ValueError, "the vsmap should contain one item")
  if tmpSeq[0].nodes.len >= 1:
    raise newException(ValueError, "the vsmap should contain a seq with nodes")
  var clips = tmpSeq[0].nodes


  let args = createMap()
  for item in clips:
    propSetNode(args, "clips", item, paAppend)
  if mismatch.isSome:
    propSetInt(args, "mismatch", mismatch.get, paAppend)

  return API.invoke(plug, "Splice".cstring, args)        

proc StackHorizontal*(vsmap:ptr VSMap):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.std")
  if plug == nil:
    raise newException(ValueError, "plugin \"std\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq
  if tmpSeq.len != 1:
    raise newException(ValueError, "the vsmap should contain one item")
  if tmpSeq[0].nodes.len >= 1:
    raise newException(ValueError, "the vsmap should contain a seq with nodes")
  var clips = tmpSeq[0].nodes


  let args = createMap()
  for item in clips:
    propSetNode(args, "clips", item, paAppend)

  return API.invoke(plug, "StackHorizontal".cstring, args)        

proc StackVertical*(vsmap:ptr VSMap):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.std")
  if plug == nil:
    raise newException(ValueError, "plugin \"std\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq
  if tmpSeq.len != 1:
    raise newException(ValueError, "the vsmap should contain one item")
  if tmpSeq[0].nodes.len >= 1:
    raise newException(ValueError, "the vsmap should contain a seq with nodes")
  var clips = tmpSeq[0].nodes


  let args = createMap()
  for item in clips:
    propSetNode(args, "clips", item, paAppend)

  return API.invoke(plug, "StackVertical".cstring, args)        

proc Transpose*(vsmap:ptr VSMap):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.std")
  if plug == nil:
    raise newException(ValueError, "plugin \"std\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq
  if tmpSeq.len != 1:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  let args = createMap()
  propSetNode(args, "clip", clip, paAppend)

  return API.invoke(plug, "Transpose".cstring, args)        

proc Trim*(vsmap:ptr VSMap; first=none(int); last=none(int); length=none(int)):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.std")
  if plug == nil:
    raise newException(ValueError, "plugin \"std\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq
  if tmpSeq.len != 1:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  let args = createMap()
  propSetNode(args, "clip", clip, paAppend)
  if first.isSome:
    propSetInt(args, "first", first.get, paAppend)
  if last.isSome:
    propSetInt(args, "last", last.get, paAppend)
  if length.isSome:
    propSetInt(args, "length", length.get, paAppend)

  return API.invoke(plug, "Trim".cstring, args)        

proc Turn180*(vsmap:ptr VSMap):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.std")
  if plug == nil:
    raise newException(ValueError, "plugin \"std\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq
  if tmpSeq.len != 1:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  let args = createMap()
  propSetNode(args, "clip", clip, paAppend)

  return API.invoke(plug, "Turn180".cstring, args)        

