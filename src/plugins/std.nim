proc AddBorders*(vsmap:ptr VSMap; left=none(int); right=none(int); top=none(int); bottom=none(int); color=none(seq[float])):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.std")
  if plug == nil:
    raise newException(ValueError, "plugin \"std\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq    # Convert the VSMap into a sequence
  if tmpSeq.len == 0:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()
  args.append("clip", clip)
  if left.isSome: args.append("left", left.get)
  if right.isSome: args.append("right", right.get)
  if top.isSome: args.append("top", top.get)
  if bottom.isSome: args.append("bottom", bottom.get)
  if color.isSome: args.set("color", color.get)

  return API.invoke(plug, "AddBorders".cstring, args)        

proc AssumeFPS*(vsmap:ptr VSMap; src=none(ptr VSNodeRef); fpsnum=none(int); fpsden=none(int)):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.std")
  if plug == nil:
    raise newException(ValueError, "plugin \"std\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq    # Convert the VSMap into a sequence
  if tmpSeq.len == 0:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()
  args.append("clip", clip)
  if src.isSome: args.append("src", src.get)
  if fpsnum.isSome: args.append("fpsnum", fpsnum.get)
  if fpsden.isSome: args.append("fpsden", fpsden.get)

  return API.invoke(plug, "AssumeFPS".cstring, args)        

proc Binarize*(vsmap:ptr VSMap; threshold=none(seq[float]); v0=none(seq[float]); v1=none(seq[float]); planes=none(seq[int])):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.std")
  if plug == nil:
    raise newException(ValueError, "plugin \"std\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq    # Convert the VSMap into a sequence
  if tmpSeq.len == 0:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()
  args.append("clip", clip)
  if threshold.isSome: args.set("threshold", threshold.get)
  if v0.isSome: args.set("v0", v0.get)
  if v1.isSome: args.set("v1", v1.get)
  if planes.isSome: args.set("planes", planes.get)

  return API.invoke(plug, "Binarize".cstring, args)        

proc BlankClip*(vsmap:ptr VSMap; width=none(int); height=none(int); format=none(int); length=none(int); fpsnum=none(int); fpsden=none(int); color=none(seq[float]); keep=none(int)):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.std")
  if plug == nil:
    raise newException(ValueError, "plugin \"std\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq    # Convert the VSMap into a sequence
  if tmpSeq.len == 0:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = some(tmpSeq[0].nodes[0])


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()
  if clip.isSome: args.append("clip", clip.get)
  if width.isSome: args.append("width", width.get)
  if height.isSome: args.append("height", height.get)
  if format.isSome: args.append("format", format.get)
  if length.isSome: args.append("length", length.get)
  if fpsnum.isSome: args.append("fpsnum", fpsnum.get)
  if fpsden.isSome: args.append("fpsden", fpsden.get)
  if color.isSome: args.set("color", color.get)
  if keep.isSome: args.append("keep", keep.get)

  return API.invoke(plug, "BlankClip".cstring, args)        

proc BoxBlur*(vsmap:ptr VSMap; planes=none(seq[int]); hradius=none(int); hpasses=none(int); vradius=none(int); vpasses=none(int)):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.std")
  if plug == nil:
    raise newException(ValueError, "plugin \"std\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq    # Convert the VSMap into a sequence
  if tmpSeq.len == 0:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()
  args.append("clip", clip)
  if planes.isSome: args.set("planes", planes.get)
  if hradius.isSome: args.append("hradius", hradius.get)
  if hpasses.isSome: args.append("hpasses", hpasses.get)
  if vradius.isSome: args.append("vradius", vradius.get)
  if vpasses.isSome: args.append("vpasses", vpasses.get)

  return API.invoke(plug, "BoxBlur".cstring, args)        

proc Cache*(vsmap:ptr VSMap; size=none(int); fixed=none(int); make_linear=none(int)):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.std")
  if plug == nil:
    raise newException(ValueError, "plugin \"std\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq    # Convert the VSMap into a sequence
  if tmpSeq.len == 0:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()
  args.append("clip", clip)
  if size.isSome: args.append("size", size.get)
  if fixed.isSome: args.append("fixed", fixed.get)
  if make_linear.isSome: args.append("make_linear", make_linear.get)

  return API.invoke(plug, "Cache".cstring, args)        

proc ClipToProp*(vsmap:ptr VSMap, mclip:ptr VSNodeRef; prop=none(string)):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.std")
  if plug == nil:
    raise newException(ValueError, "plugin \"std\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq    # Convert the VSMap into a sequence
  if tmpSeq.len == 0:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()
  args.append("clip", clip)
  args.append("mclip", mclip)
  if prop.isSome: args.append("prop", prop.get)

  return API.invoke(plug, "ClipToProp".cstring, args)        

proc Convolution*(vsmap:ptr VSMap, matrix:seq[float]; bias=none(float); divisor=none(float); planes=none(seq[int]); saturate=none(int); mode=none(string)):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.std")
  if plug == nil:
    raise newException(ValueError, "plugin \"std\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq    # Convert the VSMap into a sequence
  if tmpSeq.len == 0:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()
  args.append("clip", clip)
  args.set("matrix", matrix)
  if bias.isSome: args.append("bias", bias.get)
  if divisor.isSome: args.append("divisor", divisor.get)
  if planes.isSome: args.set("planes", planes.get)
  if saturate.isSome: args.append("saturate", saturate.get)
  if mode.isSome: args.append("mode", mode.get)

  return API.invoke(plug, "Convolution".cstring, args)        

proc Crop*(vsmap:ptr VSMap; left=none(int); right=none(int); top=none(int); bottom=none(int)):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.std")
  if plug == nil:
    raise newException(ValueError, "plugin \"std\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq    # Convert the VSMap into a sequence
  if tmpSeq.len == 0:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()
  args.append("clip", clip)
  if left.isSome: args.append("left", left.get)
  if right.isSome: args.append("right", right.get)
  if top.isSome: args.append("top", top.get)
  if bottom.isSome: args.append("bottom", bottom.get)

  return API.invoke(plug, "Crop".cstring, args)        

proc CropAbs*(vsmap:ptr VSMap, width:int, height:int; left=none(int); top=none(int); x=none(int); y=none(int)):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.std")
  if plug == nil:
    raise newException(ValueError, "plugin \"std\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq    # Convert the VSMap into a sequence
  if tmpSeq.len == 0:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()
  args.append("clip", clip)
  args.append("width", width)
  args.append("height", height)
  if left.isSome: args.append("left", left.get)
  if top.isSome: args.append("top", top.get)
  if x.isSome: args.append("x", x.get)
  if y.isSome: args.append("y", y.get)

  return API.invoke(plug, "CropAbs".cstring, args)        

proc CropRel*(vsmap:ptr VSMap; left=none(int); right=none(int); top=none(int); bottom=none(int)):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.std")
  if plug == nil:
    raise newException(ValueError, "plugin \"std\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq    # Convert the VSMap into a sequence
  if tmpSeq.len == 0:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()
  args.append("clip", clip)
  if left.isSome: args.append("left", left.get)
  if right.isSome: args.append("right", right.get)
  if top.isSome: args.append("top", top.get)
  if bottom.isSome: args.append("bottom", bottom.get)

  return API.invoke(plug, "CropRel".cstring, args)        

proc Deflate*(vsmap:ptr VSMap; planes=none(seq[int]); threshold=none(float)):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.std")
  if plug == nil:
    raise newException(ValueError, "plugin \"std\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq    # Convert the VSMap into a sequence
  if tmpSeq.len == 0:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()
  args.append("clip", clip)
  if planes.isSome: args.set("planes", planes.get)
  if threshold.isSome: args.append("threshold", threshold.get)

  return API.invoke(plug, "Deflate".cstring, args)        

proc DeleteFrames*(vsmap:ptr VSMap, frames:seq[int]):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.std")
  if plug == nil:
    raise newException(ValueError, "plugin \"std\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq    # Convert the VSMap into a sequence
  if tmpSeq.len == 0:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()
  args.append("clip", clip)
  args.set("frames", frames)

  return API.invoke(plug, "DeleteFrames".cstring, args)        

proc DoubleWeave*(vsmap:ptr VSMap; tff=none(int)):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.std")
  if plug == nil:
    raise newException(ValueError, "plugin \"std\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq    # Convert the VSMap into a sequence
  if tmpSeq.len == 0:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()
  args.append("clip", clip)
  if tff.isSome: args.append("tff", tff.get)

  return API.invoke(plug, "DoubleWeave".cstring, args)        

proc DuplicateFrames*(vsmap:ptr VSMap, frames:seq[int]):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.std")
  if plug == nil:
    raise newException(ValueError, "plugin \"std\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq    # Convert the VSMap into a sequence
  if tmpSeq.len == 0:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()
  args.append("clip", clip)
  args.set("frames", frames)

  return API.invoke(plug, "DuplicateFrames".cstring, args)        

proc Expr*(vsmap:ptr VSMap, expr:seq[string]; format=none(int)):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.std")
  if plug == nil:
    raise newException(ValueError, "plugin \"std\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq    # Convert the VSMap into a sequence
  if tmpSeq.len == 0:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len >= 1:
    raise newException(ValueError, "the vsmap should contain a seq with nodes")
  var clips = tmpSeq[0].nodes


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()
  for item in clips:
    args.append("clips", item)
  for item in expr:
    args.append("expr", item)
  if format.isSome: args.append("format", format.get)

  return API.invoke(plug, "Expr".cstring, args)        

proc FlipHorizontal*(vsmap:ptr VSMap):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.std")
  if plug == nil:
    raise newException(ValueError, "plugin \"std\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq    # Convert the VSMap into a sequence
  if tmpSeq.len == 0:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()
  args.append("clip", clip)

  return API.invoke(plug, "FlipHorizontal".cstring, args)        

proc FlipVertical*(vsmap:ptr VSMap):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.std")
  if plug == nil:
    raise newException(ValueError, "plugin \"std\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq    # Convert the VSMap into a sequence
  if tmpSeq.len == 0:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()
  args.append("clip", clip)

  return API.invoke(plug, "FlipVertical".cstring, args)        

proc FrameEval*(vsmap:ptr VSMap, eval:ptr VSFuncRef; prop_src=none(seq[ptr VSNodeRef])):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.std")
  if plug == nil:
    raise newException(ValueError, "plugin \"std\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq    # Convert the VSMap into a sequence
  if tmpSeq.len == 0:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()
  args.append("clip", clip)
  args.append("eval", eval)
  if prop_src.isSome:
    for item in prop_src.get:
      args.append("prop_src", item)

  return API.invoke(plug, "FrameEval".cstring, args)        

proc FreezeFrames*(vsmap:ptr VSMap, first:seq[int], last:seq[int], replacement:seq[int]):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.std")
  if plug == nil:
    raise newException(ValueError, "plugin \"std\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq    # Convert the VSMap into a sequence
  if tmpSeq.len == 0:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()
  args.append("clip", clip)
  args.set("first", first)
  args.set("last", last)
  args.set("replacement", replacement)

  return API.invoke(plug, "FreezeFrames".cstring, args)        

proc Inflate*(vsmap:ptr VSMap; planes=none(seq[int]); threshold=none(float)):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.std")
  if plug == nil:
    raise newException(ValueError, "plugin \"std\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq    # Convert the VSMap into a sequence
  if tmpSeq.len == 0:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()
  args.append("clip", clip)
  if planes.isSome: args.set("planes", planes.get)
  if threshold.isSome: args.append("threshold", threshold.get)

  return API.invoke(plug, "Inflate".cstring, args)        

proc Interleave*(vsmap:ptr VSMap; extend=none(int); mismatch=none(int)):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.std")
  if plug == nil:
    raise newException(ValueError, "plugin \"std\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq    # Convert the VSMap into a sequence
  if tmpSeq.len == 0:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len >= 1:
    raise newException(ValueError, "the vsmap should contain a seq with nodes")
  var clips = tmpSeq[0].nodes


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()
  for item in clips:
    args.append("clips", item)
  if extend.isSome: args.append("extend", extend.get)
  if mismatch.isSome: args.append("mismatch", mismatch.get)

  return API.invoke(plug, "Interleave".cstring, args)        

proc Invert*(vsmap:ptr VSMap; planes=none(seq[int])):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.std")
  if plug == nil:
    raise newException(ValueError, "plugin \"std\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq    # Convert the VSMap into a sequence
  if tmpSeq.len == 0:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()
  args.append("clip", clip)
  if planes.isSome: args.set("planes", planes.get)

  return API.invoke(plug, "Invert".cstring, args)        

proc Levels*(vsmap:ptr VSMap; min_in=none(seq[float]); max_in=none(seq[float]); gamma=none(seq[float]); min_out=none(seq[float]); max_out=none(seq[float]); planes=none(seq[int])):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.std")
  if plug == nil:
    raise newException(ValueError, "plugin \"std\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq    # Convert the VSMap into a sequence
  if tmpSeq.len == 0:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()
  args.append("clip", clip)
  if min_in.isSome: args.set("min_in", min_in.get)
  if max_in.isSome: args.set("max_in", max_in.get)
  if gamma.isSome: args.set("gamma", gamma.get)
  if min_out.isSome: args.set("min_out", min_out.get)
  if max_out.isSome: args.set("max_out", max_out.get)
  if planes.isSome: args.set("planes", planes.get)

  return API.invoke(plug, "Levels".cstring, args)        

proc Limiter*(vsmap:ptr VSMap; min=none(seq[float]); max=none(seq[float]); planes=none(seq[int])):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.std")
  if plug == nil:
    raise newException(ValueError, "plugin \"std\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq    # Convert the VSMap into a sequence
  if tmpSeq.len == 0:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()
  args.append("clip", clip)
  if min.isSome: args.set("min", min.get)
  if max.isSome: args.set("max", max.get)
  if planes.isSome: args.set("planes", planes.get)

  return API.invoke(plug, "Limiter".cstring, args)        

proc LoadPlugin*(path:string; altsearchpath=none(int); forcens=none(string); forceid=none(string)):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.std")
  if plug == nil:
    raise newException(ValueError, "plugin \"std\" not installed properly in your computer")

  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()
  args.append("path", path)
  if altsearchpath.isSome: args.append("altsearchpath", altsearchpath.get)
  if forcens.isSome: args.append("forcens", forcens.get)
  if forceid.isSome: args.append("forceid", forceid.get)

  return API.invoke(plug, "LoadPlugin".cstring, args)        

proc Loop*(vsmap:ptr VSMap; times=none(int)):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.std")
  if plug == nil:
    raise newException(ValueError, "plugin \"std\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq    # Convert the VSMap into a sequence
  if tmpSeq.len == 0:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()
  args.append("clip", clip)
  if times.isSome: args.append("times", times.get)

  return API.invoke(plug, "Loop".cstring, args)        

proc Lut*(vsmap:ptr VSMap; planes=none(seq[int]); lut=none(seq[int]); lutf=none(seq[float]); function=none(ptr VSFuncRef); bits=none(int); floatout=none(int)):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.std")
  if plug == nil:
    raise newException(ValueError, "plugin \"std\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq    # Convert the VSMap into a sequence
  if tmpSeq.len == 0:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()
  args.append("clip", clip)
  if planes.isSome: args.set("planes", planes.get)
  if lut.isSome: args.set("lut", lut.get)
  if lutf.isSome: args.set("lutf", lutf.get)
  if function.isSome: args.append("function", function.get)
  if bits.isSome: args.append("bits", bits.get)
  if floatout.isSome: args.append("floatout", floatout.get)

  return API.invoke(plug, "Lut".cstring, args)        

proc Lut2*(vsmap:ptr VSMap, clipb:ptr VSNodeRef; planes=none(seq[int]); lut=none(seq[int]); lutf=none(seq[float]); function=none(ptr VSFuncRef); bits=none(int); floatout=none(int)):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.std")
  if plug == nil:
    raise newException(ValueError, "plugin \"std\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq    # Convert the VSMap into a sequence
  if tmpSeq.len == 0:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clipa = tmpSeq[0].nodes[0]


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()
  args.append("clipa", clipa)
  args.append("clipb", clipb)
  if planes.isSome: args.set("planes", planes.get)
  if lut.isSome: args.set("lut", lut.get)
  if lutf.isSome: args.set("lutf", lutf.get)
  if function.isSome: args.append("function", function.get)
  if bits.isSome: args.append("bits", bits.get)
  if floatout.isSome: args.append("floatout", floatout.get)

  return API.invoke(plug, "Lut2".cstring, args)        

proc MakeDiff*(vsmap:ptr VSMap, clipb:ptr VSNodeRef; planes=none(seq[int])):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.std")
  if plug == nil:
    raise newException(ValueError, "plugin \"std\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq    # Convert the VSMap into a sequence
  if tmpSeq.len == 0:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clipa = tmpSeq[0].nodes[0]


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()
  args.append("clipa", clipa)
  args.append("clipb", clipb)
  if planes.isSome: args.set("planes", planes.get)

  return API.invoke(plug, "MakeDiff".cstring, args)        

proc MaskedMerge*(vsmap:ptr VSMap, clipb:ptr VSNodeRef, mask:ptr VSNodeRef; planes=none(seq[int]); first_plane=none(int); premultiplied=none(int)):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.std")
  if plug == nil:
    raise newException(ValueError, "plugin \"std\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq    # Convert the VSMap into a sequence
  if tmpSeq.len == 0:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clipa = tmpSeq[0].nodes[0]


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()
  args.append("clipa", clipa)
  args.append("clipb", clipb)
  args.append("mask", mask)
  if planes.isSome: args.set("planes", planes.get)
  if first_plane.isSome: args.append("first_plane", first_plane.get)
  if premultiplied.isSome: args.append("premultiplied", premultiplied.get)

  return API.invoke(plug, "MaskedMerge".cstring, args)        

proc Maximum*(vsmap:ptr VSMap; planes=none(seq[int]); threshold=none(float); coordinates=none(seq[int])):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.std")
  if plug == nil:
    raise newException(ValueError, "plugin \"std\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq    # Convert the VSMap into a sequence
  if tmpSeq.len == 0:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()
  args.append("clip", clip)
  if planes.isSome: args.set("planes", planes.get)
  if threshold.isSome: args.append("threshold", threshold.get)
  if coordinates.isSome: args.set("coordinates", coordinates.get)

  return API.invoke(plug, "Maximum".cstring, args)        

proc Median*(vsmap:ptr VSMap; planes=none(seq[int])):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.std")
  if plug == nil:
    raise newException(ValueError, "plugin \"std\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq    # Convert the VSMap into a sequence
  if tmpSeq.len == 0:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()
  args.append("clip", clip)
  if planes.isSome: args.set("planes", planes.get)

  return API.invoke(plug, "Median".cstring, args)        

proc Merge*(vsmap:ptr VSMap, clipb:ptr VSNodeRef; weight=none(seq[float])):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.std")
  if plug == nil:
    raise newException(ValueError, "plugin \"std\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq    # Convert the VSMap into a sequence
  if tmpSeq.len == 0:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clipa = tmpSeq[0].nodes[0]


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()
  args.append("clipa", clipa)
  args.append("clipb", clipb)
  if weight.isSome: args.set("weight", weight.get)

  return API.invoke(plug, "Merge".cstring, args)        

proc MergeDiff*(vsmap:ptr VSMap, clipb:ptr VSNodeRef; planes=none(seq[int])):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.std")
  if plug == nil:
    raise newException(ValueError, "plugin \"std\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq    # Convert the VSMap into a sequence
  if tmpSeq.len == 0:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clipa = tmpSeq[0].nodes[0]


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()
  args.append("clipa", clipa)
  args.append("clipb", clipb)
  if planes.isSome: args.set("planes", planes.get)

  return API.invoke(plug, "MergeDiff".cstring, args)        

proc Minimum*(vsmap:ptr VSMap; planes=none(seq[int]); threshold=none(float); coordinates=none(seq[int])):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.std")
  if plug == nil:
    raise newException(ValueError, "plugin \"std\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq    # Convert the VSMap into a sequence
  if tmpSeq.len == 0:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()
  args.append("clip", clip)
  if planes.isSome: args.set("planes", planes.get)
  if threshold.isSome: args.append("threshold", threshold.get)
  if coordinates.isSome: args.set("coordinates", coordinates.get)

  return API.invoke(plug, "Minimum".cstring, args)        

proc ModifyFrame*(vsmap:ptr VSMap, clips:seq[ptr VSNodeRef], selector:ptr VSFuncRef):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.std")
  if plug == nil:
    raise newException(ValueError, "plugin \"std\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq    # Convert the VSMap into a sequence
  if tmpSeq.len == 0:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()
  args.append("clip", clip)
  for item in clips:
    args.append("clips", item)
  args.append("selector", selector)

  return API.invoke(plug, "ModifyFrame".cstring, args)        

proc PEMVerifier*(vsmap:ptr VSMap; upper=none(seq[float]); lower=none(seq[float])):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.std")
  if plug == nil:
    raise newException(ValueError, "plugin \"std\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq    # Convert the VSMap into a sequence
  if tmpSeq.len == 0:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()
  args.append("clip", clip)
  if upper.isSome: args.set("upper", upper.get)
  if lower.isSome: args.set("lower", lower.get)

  return API.invoke(plug, "PEMVerifier".cstring, args)        

proc PlaneStats*(vsmap:ptr VSMap; clipb=none(ptr VSNodeRef); plane=none(int); prop=none(string)):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.std")
  if plug == nil:
    raise newException(ValueError, "plugin \"std\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq    # Convert the VSMap into a sequence
  if tmpSeq.len == 0:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clipa = tmpSeq[0].nodes[0]


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()
  args.append("clipa", clipa)
  if clipb.isSome: args.append("clipb", clipb.get)
  if plane.isSome: args.append("plane", plane.get)
  if prop.isSome: args.append("prop", prop.get)

  return API.invoke(plug, "PlaneStats".cstring, args)        

proc PreMultiply*(vsmap:ptr VSMap, alpha:ptr VSNodeRef):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.std")
  if plug == nil:
    raise newException(ValueError, "plugin \"std\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq    # Convert the VSMap into a sequence
  if tmpSeq.len == 0:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()
  args.append("clip", clip)
  args.append("alpha", alpha)

  return API.invoke(plug, "PreMultiply".cstring, args)        

proc Prewitt*(vsmap:ptr VSMap; planes=none(seq[int]); scale=none(float)):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.std")
  if plug == nil:
    raise newException(ValueError, "plugin \"std\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq    # Convert the VSMap into a sequence
  if tmpSeq.len == 0:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()
  args.append("clip", clip)
  if planes.isSome: args.set("planes", planes.get)
  if scale.isSome: args.append("scale", scale.get)

  return API.invoke(plug, "Prewitt".cstring, args)        

proc PropToClip*(vsmap:ptr VSMap; prop=none(string)):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.std")
  if plug == nil:
    raise newException(ValueError, "plugin \"std\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq    # Convert the VSMap into a sequence
  if tmpSeq.len == 0:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()
  args.append("clip", clip)
  if prop.isSome: args.append("prop", prop.get)

  return API.invoke(plug, "PropToClip".cstring, args)        

proc Reverse*(vsmap:ptr VSMap):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.std")
  if plug == nil:
    raise newException(ValueError, "plugin \"std\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq    # Convert the VSMap into a sequence
  if tmpSeq.len == 0:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()
  args.append("clip", clip)

  return API.invoke(plug, "Reverse".cstring, args)        

proc SelectEvery*(vsmap:ptr VSMap, cycle:int, offsets:seq[int]):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.std")
  if plug == nil:
    raise newException(ValueError, "plugin \"std\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq    # Convert the VSMap into a sequence
  if tmpSeq.len == 0:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()
  args.append("clip", clip)
  args.append("cycle", cycle)
  args.set("offsets", offsets)

  return API.invoke(plug, "SelectEvery".cstring, args)        

proc SeparateFields*(vsmap:ptr VSMap; tff=none(int)):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.std")
  if plug == nil:
    raise newException(ValueError, "plugin \"std\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq    # Convert the VSMap into a sequence
  if tmpSeq.len == 0:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()
  args.append("clip", clip)
  if tff.isSome: args.append("tff", tff.get)

  return API.invoke(plug, "SeparateFields".cstring, args)        

proc SetFieldBased*(vsmap:ptr VSMap, value:int):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.std")
  if plug == nil:
    raise newException(ValueError, "plugin \"std\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq    # Convert the VSMap into a sequence
  if tmpSeq.len == 0:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()
  args.append("clip", clip)
  args.append("value", value)

  return API.invoke(plug, "SetFieldBased".cstring, args)        

proc SetFrameProp*(vsmap:ptr VSMap, prop:string; delete=none(int); intval=none(seq[int]); floatval=none(seq[float]); data=none(seq[string])):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.std")
  if plug == nil:
    raise newException(ValueError, "plugin \"std\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq    # Convert the VSMap into a sequence
  if tmpSeq.len == 0:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()
  args.append("clip", clip)
  args.append("prop", prop)
  if delete.isSome: args.append("delete", delete.get)
  if intval.isSome: args.set("intval", intval.get)
  if floatval.isSome: args.set("floatval", floatval.get)
  if data.isSome:
    for item in data.get:
      args.append("data", item)

  return API.invoke(plug, "SetFrameProp".cstring, args)        

proc SetMaxCPU*(cpu:string):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.std")
  if plug == nil:
    raise newException(ValueError, "plugin \"std\" not installed properly in your computer")

  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()
  args.append("cpu", cpu)

  return API.invoke(plug, "SetMaxCPU".cstring, args)        

proc ShufflePlanes*(vsmap:ptr VSMap, planes:seq[int], colorfamily:int):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.std")
  if plug == nil:
    raise newException(ValueError, "plugin \"std\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq    # Convert the VSMap into a sequence
  if tmpSeq.len == 0:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len >= 1:
    raise newException(ValueError, "the vsmap should contain a seq with nodes")
  var clips = tmpSeq[0].nodes


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()
  for item in clips:
    args.append("clips", item)
  args.set("planes", planes)
  args.append("colorfamily", colorfamily)

  return API.invoke(plug, "ShufflePlanes".cstring, args)        

proc Sobel*(vsmap:ptr VSMap; planes=none(seq[int]); scale=none(float)):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.std")
  if plug == nil:
    raise newException(ValueError, "plugin \"std\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq    # Convert the VSMap into a sequence
  if tmpSeq.len == 0:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()
  args.append("clip", clip)
  if planes.isSome: args.set("planes", planes.get)
  if scale.isSome: args.append("scale", scale.get)

  return API.invoke(plug, "Sobel".cstring, args)        

proc Splice*(vsmap:ptr VSMap; mismatch=none(int)):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.std")
  if plug == nil:
    raise newException(ValueError, "plugin \"std\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq    # Convert the VSMap into a sequence
  if tmpSeq.len == 0:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len >= 1:
    raise newException(ValueError, "the vsmap should contain a seq with nodes")
  var clips = tmpSeq[0].nodes


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()
  for item in clips:
    args.append("clips", item)
  if mismatch.isSome: args.append("mismatch", mismatch.get)

  return API.invoke(plug, "Splice".cstring, args)        

proc StackHorizontal*(vsmap:ptr VSMap):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.std")
  if plug == nil:
    raise newException(ValueError, "plugin \"std\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq    # Convert the VSMap into a sequence
  if tmpSeq.len == 0:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len >= 1:
    raise newException(ValueError, "the vsmap should contain a seq with nodes")
  var clips = tmpSeq[0].nodes


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()
  for item in clips:
    args.append("clips", item)

  return API.invoke(plug, "StackHorizontal".cstring, args)        

proc StackVertical*(vsmap:ptr VSMap):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.std")
  if plug == nil:
    raise newException(ValueError, "plugin \"std\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq    # Convert the VSMap into a sequence
  if tmpSeq.len == 0:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len >= 1:
    raise newException(ValueError, "the vsmap should contain a seq with nodes")
  var clips = tmpSeq[0].nodes


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()
  for item in clips:
    args.append("clips", item)

  return API.invoke(plug, "StackVertical".cstring, args)        

proc Transpose*(vsmap:ptr VSMap):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.std")
  if plug == nil:
    raise newException(ValueError, "plugin \"std\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq    # Convert the VSMap into a sequence
  if tmpSeq.len == 0:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()
  args.append("clip", clip)

  return API.invoke(plug, "Transpose".cstring, args)        

proc Trim*(vsmap:ptr VSMap; first=none(int); last=none(int); length=none(int)):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.std")
  if plug == nil:
    raise newException(ValueError, "plugin \"std\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq    # Convert the VSMap into a sequence
  if tmpSeq.len == 0:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()
  args.append("clip", clip)
  if first.isSome: args.append("first", first.get)
  if last.isSome: args.append("last", last.get)
  if length.isSome: args.append("length", length.get)

  return API.invoke(plug, "Trim".cstring, args)        

proc Turn180*(vsmap:ptr VSMap):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.std")
  if plug == nil:
    raise newException(ValueError, "plugin \"std\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq    # Convert the VSMap into a sequence
  if tmpSeq.len == 0:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()
  args.append("clip", clip)

  return API.invoke(plug, "Turn180".cstring, args)        

