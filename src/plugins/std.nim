proc AddBorders(clip:ptr VSNodeRef; left=none(int); right=none(int); top=none(int); bottom=none(int); color=none(seq[float])):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.std")
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
    propSetFloatArray(args, "color", color.get, paAppend)

  return API.invoke(plug, "AddBorders".cstring, args)        

proc AssumeFPS(clip:ptr VSNodeRef; src=none(ptr VSNodeRef); fpsnum=none(int); fpsden=none(int)):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.std")
  let args = createMap()
  propSetNode(args, "clip", clip, paAppend)
  if src.isSome:
    propSetNode(args, "src", src.get, paAppend)
  if fpsnum.isSome:
    propSetInt(args, "fpsnum", fpsnum.get, paAppend)
  if fpsden.isSome:
    propSetInt(args, "fpsden", fpsden.get, paAppend)

  return API.invoke(plug, "AssumeFPS".cstring, args)        

proc Binarize(clip:ptr VSNodeRef; threshold=none(seq[float]); v0=none(seq[float]); v1=none(seq[float]); planes=none(seq[int])):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.std")
  let args = createMap()
  propSetNode(args, "clip", clip, paAppend)
  if threshold.isSome:
    propSetFloatArray(args, "threshold", threshold.get, paAppend)
  if v0.isSome:
    propSetFloatArray(args, "v0", v0.get, paAppend)
  if v1.isSome:
    propSetFloatArray(args, "v1", v1.get, paAppend)
  if planes.isSome:
    propSetIntArray(args, "planes", planes.get, paAppend)

  return API.invoke(plug, "Binarize".cstring, args)        

proc BlankClip(clip=none(ptr VSNodeRef); width=none(int); height=none(int); format=none(int); length=none(int); fpsnum=none(int); fpsden=none(int); color=none(seq[float]); keep=none(int)):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.std")
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
    propSetFloatArray(args, "color", color.get, paAppend)
  if keep.isSome:
    propSetInt(args, "keep", keep.get, paAppend)

  return API.invoke(plug, "BlankClip".cstring, args)        

proc BoxBlur(clip:ptr VSNodeRef; planes=none(seq[int]); hradius=none(int); hpasses=none(int); vradius=none(int); vpasses=none(int)):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.std")
  let args = createMap()
  propSetNode(args, "clip", clip, paAppend)
  if planes.isSome:
    propSetIntArray(args, "planes", planes.get, paAppend)
  if hradius.isSome:
    propSetInt(args, "hradius", hradius.get, paAppend)
  if hpasses.isSome:
    propSetInt(args, "hpasses", hpasses.get, paAppend)
  if vradius.isSome:
    propSetInt(args, "vradius", vradius.get, paAppend)
  if vpasses.isSome:
    propSetInt(args, "vpasses", vpasses.get, paAppend)

  return API.invoke(plug, "BoxBlur".cstring, args)        

proc Cache(clip:ptr VSNodeRef; size=none(int); fixed=none(int); make_linear=none(int)):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.std")
  let args = createMap()
  propSetNode(args, "clip", clip, paAppend)
  if size.isSome:
    propSetInt(args, "size", size.get, paAppend)
  if fixed.isSome:
    propSetInt(args, "fixed", fixed.get, paAppend)
  if make_linear.isSome:
    propSetInt(args, "make_linear", make_linear.get, paAppend)

  return API.invoke(plug, "Cache".cstring, args)        

proc ClipToProp(clip:ptr VSNodeRef, mclip:ptr VSNodeRef; prop=none(string)):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.std")
  let args = createMap()
  propSetNode(args, "clip", clip, paAppend)
  propSetNode(args, "mclip", mclip, paAppend)
  if prop.isSome:
    propSetData(args, "prop", prop.get, paAppend)

  return API.invoke(plug, "ClipToProp".cstring, args)        

proc Convolution(clip:ptr VSNodeRef, matrix:seq[float]; bias=none(float); divisor=none(float); planes=none(seq[int]); saturate=none(int); mode=none(string)):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.std")
  let args = createMap()
  propSetNode(args, "clip", clip, paAppend)
  propSetFloatArray(args, "matrix", matrix, paAppend)
  if bias.isSome:
    propSetFloat(args, "bias", bias.get, paAppend)
  if divisor.isSome:
    propSetFloat(args, "divisor", divisor.get, paAppend)
  if planes.isSome:
    propSetIntArray(args, "planes", planes.get, paAppend)
  if saturate.isSome:
    propSetInt(args, "saturate", saturate.get, paAppend)
  if mode.isSome:
    propSetData(args, "mode", mode.get, paAppend)

  return API.invoke(plug, "Convolution".cstring, args)        

proc Crop(clip:ptr VSNodeRef; left=none(int); right=none(int); top=none(int); bottom=none(int)):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.std")
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

proc CropAbs(clip:ptr VSNodeRef, width:int, height:int; left=none(int); top=none(int); x=none(int); y=none(int)):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.std")
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

proc CropRel(clip:ptr VSNodeRef; left=none(int); right=none(int); top=none(int); bottom=none(int)):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.std")
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

proc Deflate(clip:ptr VSNodeRef; planes=none(seq[int]); threshold=none(float)):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.std")
  let args = createMap()
  propSetNode(args, "clip", clip, paAppend)
  if planes.isSome:
    propSetIntArray(args, "planes", planes.get, paAppend)
  if threshold.isSome:
    propSetFloat(args, "threshold", threshold.get, paAppend)

  return API.invoke(plug, "Deflate".cstring, args)        

proc DeleteFrames(clip:ptr VSNodeRef, frames:seq[int]):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.std")
  let args = createMap()
  propSetNode(args, "clip", clip, paAppend)
  propSetIntArray(args, "frames", frames, paAppend)

  return API.invoke(plug, "DeleteFrames".cstring, args)        

proc DoubleWeave(clip:ptr VSNodeRef; tff=none(int)):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.std")
  let args = createMap()
  propSetNode(args, "clip", clip, paAppend)
  if tff.isSome:
    propSetInt(args, "tff", tff.get, paAppend)

  return API.invoke(plug, "DoubleWeave".cstring, args)        

proc DuplicateFrames(clip:ptr VSNodeRef, frames:seq[int]):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.std")
  let args = createMap()
  propSetNode(args, "clip", clip, paAppend)
  propSetIntArray(args, "frames", frames, paAppend)

  return API.invoke(plug, "DuplicateFrames".cstring, args)        

proc Expr(clips:clip[], expr:data[]; format=none(int)):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.std")
  let args = createMap()
  (args, "clips", clips, paAppend)
  (args, "expr", expr, paAppend)
  if format.isSome:
    propSetInt(args, "format", format.get, paAppend)

  return API.invoke(plug, "Expr".cstring, args)        

proc FlipHorizontal(clip:ptr VSNodeRef):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.std")
  let args = createMap()
  propSetNode(args, "clip", clip, paAppend)

  return API.invoke(plug, "FlipHorizontal".cstring, args)        

proc FlipVertical(clip:ptr VSNodeRef):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.std")
  let args = createMap()
  propSetNode(args, "clip", clip, paAppend)

  return API.invoke(plug, "FlipVertical".cstring, args)        

proc FrameEval(clip:ptr VSNodeRef, eval:func; prop_src=none(clip[])):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.std")
  let args = createMap()
  propSetNode(args, "clip", clip, paAppend)
  (args, "eval", eval, paAppend)
  if prop_src.isSome:
    (args, "prop_src", prop_src.get, paAppend)

  return API.invoke(plug, "FrameEval".cstring, args)        

proc FreezeFrames(clip:ptr VSNodeRef, first:seq[int], last:seq[int], replacement:seq[int]):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.std")
  let args = createMap()
  propSetNode(args, "clip", clip, paAppend)
  propSetIntArray(args, "first", first, paAppend)
  propSetIntArray(args, "last", last, paAppend)
  propSetIntArray(args, "replacement", replacement, paAppend)

  return API.invoke(plug, "FreezeFrames".cstring, args)        

proc Inflate(clip:ptr VSNodeRef; planes=none(seq[int]); threshold=none(float)):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.std")
  let args = createMap()
  propSetNode(args, "clip", clip, paAppend)
  if planes.isSome:
    propSetIntArray(args, "planes", planes.get, paAppend)
  if threshold.isSome:
    propSetFloat(args, "threshold", threshold.get, paAppend)

  return API.invoke(plug, "Inflate".cstring, args)        

proc Interleave(clips:clip[]; extend=none(int); mismatch=none(int)):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.std")
  let args = createMap()
  (args, "clips", clips, paAppend)
  if extend.isSome:
    propSetInt(args, "extend", extend.get, paAppend)
  if mismatch.isSome:
    propSetInt(args, "mismatch", mismatch.get, paAppend)

  return API.invoke(plug, "Interleave".cstring, args)        

proc Invert(clip:ptr VSNodeRef; planes=none(seq[int])):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.std")
  let args = createMap()
  propSetNode(args, "clip", clip, paAppend)
  if planes.isSome:
    propSetIntArray(args, "planes", planes.get, paAppend)

  return API.invoke(plug, "Invert".cstring, args)        

proc Levels(clip:ptr VSNodeRef; min_in=none(seq[float]); max_in=none(seq[float]); gamma=none(seq[float]); min_out=none(seq[float]); max_out=none(seq[float]); planes=none(seq[int])):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.std")
  let args = createMap()
  propSetNode(args, "clip", clip, paAppend)
  if min_in.isSome:
    propSetFloatArray(args, "min_in", min_in.get, paAppend)
  if max_in.isSome:
    propSetFloatArray(args, "max_in", max_in.get, paAppend)
  if gamma.isSome:
    propSetFloatArray(args, "gamma", gamma.get, paAppend)
  if min_out.isSome:
    propSetFloatArray(args, "min_out", min_out.get, paAppend)
  if max_out.isSome:
    propSetFloatArray(args, "max_out", max_out.get, paAppend)
  if planes.isSome:
    propSetIntArray(args, "planes", planes.get, paAppend)

  return API.invoke(plug, "Levels".cstring, args)        

proc Limiter(clip:ptr VSNodeRef; min=none(seq[float]); max=none(seq[float]); planes=none(seq[int])):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.std")
  let args = createMap()
  propSetNode(args, "clip", clip, paAppend)
  if min.isSome:
    propSetFloatArray(args, "min", min.get, paAppend)
  if max.isSome:
    propSetFloatArray(args, "max", max.get, paAppend)
  if planes.isSome:
    propSetIntArray(args, "planes", planes.get, paAppend)

  return API.invoke(plug, "Limiter".cstring, args)        

proc LoadPlugin(path:string; altsearchpath=none(int); forcens=none(string); forceid=none(string)):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.std")
  let args = createMap()
  propSetData(args, "path", path, paAppend)
  if altsearchpath.isSome:
    propSetInt(args, "altsearchpath", altsearchpath.get, paAppend)
  if forcens.isSome:
    propSetData(args, "forcens", forcens.get, paAppend)
  if forceid.isSome:
    propSetData(args, "forceid", forceid.get, paAppend)

  return API.invoke(plug, "LoadPlugin".cstring, args)        

proc Loop(clip:ptr VSNodeRef; times=none(int)):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.std")
  let args = createMap()
  propSetNode(args, "clip", clip, paAppend)
  if times.isSome:
    propSetInt(args, "times", times.get, paAppend)

  return API.invoke(plug, "Loop".cstring, args)        

proc Lut(clip:ptr VSNodeRef; planes=none(seq[int]); lut=none(seq[int]); lutf=none(seq[float]); function=none(func); bits=none(int); floatout=none(int)):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.std")
  let args = createMap()
  propSetNode(args, "clip", clip, paAppend)
  if planes.isSome:
    propSetIntArray(args, "planes", planes.get, paAppend)
  if lut.isSome:
    propSetIntArray(args, "lut", lut.get, paAppend)
  if lutf.isSome:
    propSetFloatArray(args, "lutf", lutf.get, paAppend)
  if function.isSome:
    (args, "function", function.get, paAppend)
  if bits.isSome:
    propSetInt(args, "bits", bits.get, paAppend)
  if floatout.isSome:
    propSetInt(args, "floatout", floatout.get, paAppend)

  return API.invoke(plug, "Lut".cstring, args)        

proc Lut2(clipa:ptr VSNodeRef, clipb:ptr VSNodeRef; planes=none(seq[int]); lut=none(seq[int]); lutf=none(seq[float]); function=none(func); bits=none(int); floatout=none(int)):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.std")
  let args = createMap()
  propSetNode(args, "clipa", clipa, paAppend)
  propSetNode(args, "clipb", clipb, paAppend)
  if planes.isSome:
    propSetIntArray(args, "planes", planes.get, paAppend)
  if lut.isSome:
    propSetIntArray(args, "lut", lut.get, paAppend)
  if lutf.isSome:
    propSetFloatArray(args, "lutf", lutf.get, paAppend)
  if function.isSome:
    (args, "function", function.get, paAppend)
  if bits.isSome:
    propSetInt(args, "bits", bits.get, paAppend)
  if floatout.isSome:
    propSetInt(args, "floatout", floatout.get, paAppend)

  return API.invoke(plug, "Lut2".cstring, args)        

proc MakeDiff(clipa:ptr VSNodeRef, clipb:ptr VSNodeRef; planes=none(seq[int])):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.std")
  let args = createMap()
  propSetNode(args, "clipa", clipa, paAppend)
  propSetNode(args, "clipb", clipb, paAppend)
  if planes.isSome:
    propSetIntArray(args, "planes", planes.get, paAppend)

  return API.invoke(plug, "MakeDiff".cstring, args)        

proc MaskedMerge(clipa:ptr VSNodeRef, clipb:ptr VSNodeRef, mask:ptr VSNodeRef; planes=none(seq[int]); first_plane=none(int); premultiplied=none(int)):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.std")
  let args = createMap()
  propSetNode(args, "clipa", clipa, paAppend)
  propSetNode(args, "clipb", clipb, paAppend)
  propSetNode(args, "mask", mask, paAppend)
  if planes.isSome:
    propSetIntArray(args, "planes", planes.get, paAppend)
  if first_plane.isSome:
    propSetInt(args, "first_plane", first_plane.get, paAppend)
  if premultiplied.isSome:
    propSetInt(args, "premultiplied", premultiplied.get, paAppend)

  return API.invoke(plug, "MaskedMerge".cstring, args)        

proc Maximum(clip:ptr VSNodeRef; planes=none(seq[int]); threshold=none(float); coordinates=none(seq[int])):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.std")
  let args = createMap()
  propSetNode(args, "clip", clip, paAppend)
  if planes.isSome:
    propSetIntArray(args, "planes", planes.get, paAppend)
  if threshold.isSome:
    propSetFloat(args, "threshold", threshold.get, paAppend)
  if coordinates.isSome:
    propSetIntArray(args, "coordinates", coordinates.get, paAppend)

  return API.invoke(plug, "Maximum".cstring, args)        

proc Median(clip:ptr VSNodeRef; planes=none(seq[int])):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.std")
  let args = createMap()
  propSetNode(args, "clip", clip, paAppend)
  if planes.isSome:
    propSetIntArray(args, "planes", planes.get, paAppend)

  return API.invoke(plug, "Median".cstring, args)        

proc Merge(clipa:ptr VSNodeRef, clipb:ptr VSNodeRef; weight=none(seq[float])):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.std")
  let args = createMap()
  propSetNode(args, "clipa", clipa, paAppend)
  propSetNode(args, "clipb", clipb, paAppend)
  if weight.isSome:
    propSetFloatArray(args, "weight", weight.get, paAppend)

  return API.invoke(plug, "Merge".cstring, args)        

proc MergeDiff(clipa:ptr VSNodeRef, clipb:ptr VSNodeRef; planes=none(seq[int])):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.std")
  let args = createMap()
  propSetNode(args, "clipa", clipa, paAppend)
  propSetNode(args, "clipb", clipb, paAppend)
  if planes.isSome:
    propSetIntArray(args, "planes", planes.get, paAppend)

  return API.invoke(plug, "MergeDiff".cstring, args)        

proc Minimum(clip:ptr VSNodeRef; planes=none(seq[int]); threshold=none(float); coordinates=none(seq[int])):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.std")
  let args = createMap()
  propSetNode(args, "clip", clip, paAppend)
  if planes.isSome:
    propSetIntArray(args, "planes", planes.get, paAppend)
  if threshold.isSome:
    propSetFloat(args, "threshold", threshold.get, paAppend)
  if coordinates.isSome:
    propSetIntArray(args, "coordinates", coordinates.get, paAppend)

  return API.invoke(plug, "Minimum".cstring, args)        

proc ModifyFrame(clip:ptr VSNodeRef, clips:clip[], selector:func):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.std")
  let args = createMap()
  propSetNode(args, "clip", clip, paAppend)
  (args, "clips", clips, paAppend)
  (args, "selector", selector, paAppend)

  return API.invoke(plug, "ModifyFrame".cstring, args)        

proc PEMVerifier(clip:ptr VSNodeRef; upper=none(seq[float]); lower=none(seq[float])):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.std")
  let args = createMap()
  propSetNode(args, "clip", clip, paAppend)
  if upper.isSome:
    propSetFloatArray(args, "upper", upper.get, paAppend)
  if lower.isSome:
    propSetFloatArray(args, "lower", lower.get, paAppend)

  return API.invoke(plug, "PEMVerifier".cstring, args)        

proc PlaneStats(clipa:ptr VSNodeRef; clipb=none(ptr VSNodeRef); plane=none(int); prop=none(string)):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.std")
  let args = createMap()
  propSetNode(args, "clipa", clipa, paAppend)
  if clipb.isSome:
    propSetNode(args, "clipb", clipb.get, paAppend)
  if plane.isSome:
    propSetInt(args, "plane", plane.get, paAppend)
  if prop.isSome:
    propSetData(args, "prop", prop.get, paAppend)

  return API.invoke(plug, "PlaneStats".cstring, args)        

proc PreMultiply(clip:ptr VSNodeRef, alpha:ptr VSNodeRef):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.std")
  let args = createMap()
  propSetNode(args, "clip", clip, paAppend)
  propSetNode(args, "alpha", alpha, paAppend)

  return API.invoke(plug, "PreMultiply".cstring, args)        

proc Prewitt(clip:ptr VSNodeRef; planes=none(seq[int]); scale=none(float)):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.std")
  let args = createMap()
  propSetNode(args, "clip", clip, paAppend)
  if planes.isSome:
    propSetIntArray(args, "planes", planes.get, paAppend)
  if scale.isSome:
    propSetFloat(args, "scale", scale.get, paAppend)

  return API.invoke(plug, "Prewitt".cstring, args)        

proc PropToClip(clip:ptr VSNodeRef; prop=none(string)):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.std")
  let args = createMap()
  propSetNode(args, "clip", clip, paAppend)
  if prop.isSome:
    propSetData(args, "prop", prop.get, paAppend)

  return API.invoke(plug, "PropToClip".cstring, args)        

proc Reverse(clip:ptr VSNodeRef):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.std")
  let args = createMap()
  propSetNode(args, "clip", clip, paAppend)

  return API.invoke(plug, "Reverse".cstring, args)        

proc SelectEvery(clip:ptr VSNodeRef, cycle:int, offsets:seq[int]):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.std")
  let args = createMap()
  propSetNode(args, "clip", clip, paAppend)
  propSetInt(args, "cycle", cycle, paAppend)
  propSetIntArray(args, "offsets", offsets, paAppend)

  return API.invoke(plug, "SelectEvery".cstring, args)        

proc SeparateFields(clip:ptr VSNodeRef; tff=none(int)):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.std")
  let args = createMap()
  propSetNode(args, "clip", clip, paAppend)
  if tff.isSome:
    propSetInt(args, "tff", tff.get, paAppend)

  return API.invoke(plug, "SeparateFields".cstring, args)        

proc SetFieldBased(clip:ptr VSNodeRef, value:int):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.std")
  let args = createMap()
  propSetNode(args, "clip", clip, paAppend)
  propSetInt(args, "value", value, paAppend)

  return API.invoke(plug, "SetFieldBased".cstring, args)        

proc SetFrameProp(clip:ptr VSNodeRef, prop:string; delete=none(int); intval=none(seq[int]); floatval=none(seq[float]); data=none(data[])):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.std")
  let args = createMap()
  propSetNode(args, "clip", clip, paAppend)
  propSetData(args, "prop", prop, paAppend)
  if delete.isSome:
    propSetInt(args, "delete", delete.get, paAppend)
  if intval.isSome:
    propSetIntArray(args, "intval", intval.get, paAppend)
  if floatval.isSome:
    propSetFloatArray(args, "floatval", floatval.get, paAppend)
  if data.isSome:
    (args, "data", data.get, paAppend)

  return API.invoke(plug, "SetFrameProp".cstring, args)        

proc SetMaxCPU(cpu:string):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.std")
  let args = createMap()
  propSetData(args, "cpu", cpu, paAppend)

  return API.invoke(plug, "SetMaxCPU".cstring, args)        

proc ShufflePlanes(clips:clip[], planes:seq[int], colorfamily:int):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.std")
  let args = createMap()
  (args, "clips", clips, paAppend)
  propSetIntArray(args, "planes", planes, paAppend)
  propSetInt(args, "colorfamily", colorfamily, paAppend)

  return API.invoke(plug, "ShufflePlanes".cstring, args)        

proc Sobel(clip:ptr VSNodeRef; planes=none(seq[int]); scale=none(float)):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.std")
  let args = createMap()
  propSetNode(args, "clip", clip, paAppend)
  if planes.isSome:
    propSetIntArray(args, "planes", planes.get, paAppend)
  if scale.isSome:
    propSetFloat(args, "scale", scale.get, paAppend)

  return API.invoke(plug, "Sobel".cstring, args)        

proc Splice(clips:clip[]; mismatch=none(int)):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.std")
  let args = createMap()
  (args, "clips", clips, paAppend)
  if mismatch.isSome:
    propSetInt(args, "mismatch", mismatch.get, paAppend)

  return API.invoke(plug, "Splice".cstring, args)        

proc StackHorizontal(clips:clip[]):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.std")
  let args = createMap()
  (args, "clips", clips, paAppend)

  return API.invoke(plug, "StackHorizontal".cstring, args)        

proc StackVertical(clips:clip[]):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.std")
  let args = createMap()
  (args, "clips", clips, paAppend)

  return API.invoke(plug, "StackVertical".cstring, args)        

proc Transpose(clip:ptr VSNodeRef):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.std")
  let args = createMap()
  propSetNode(args, "clip", clip, paAppend)

  return API.invoke(plug, "Transpose".cstring, args)        

proc Trim(clip:ptr VSNodeRef; first=none(int); last=none(int); length=none(int)):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.std")
  let args = createMap()
  propSetNode(args, "clip", clip, paAppend)
  if first.isSome:
    propSetInt(args, "first", first.get, paAppend)
  if last.isSome:
    propSetInt(args, "last", last.get, paAppend)
  if length.isSome:
    propSetInt(args, "length", length.get, paAppend)

  return API.invoke(plug, "Trim".cstring, args)        

proc Turn180(clip:ptr VSNodeRef):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.std")
  let args = createMap()
  propSetNode(args, "clip", clip, paAppend)

  return API.invoke(plug, "Turn180".cstring, args)        

