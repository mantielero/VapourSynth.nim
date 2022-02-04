proc AddBorders*(vsmap:ptr VSMap; left= none(int); right= none(int); top= none(int); bottom= none(int); color= none(seq[float])):ptr VSMap =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("vnode") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()

  args.append("clip", clip)
  if left.isSome: args.append("left", left.get)
  if right.isSome: args.append("right", right.get)
  if top.isSome: args.append("top", top.get)
  if bottom.isSome: args.append("bottom", bottom.get)
  if color.isSome: args.set("color", color.get)

  result = API.invoke(plug, "AddBorders".cstring, args)
  API.freeMap(args)


proc AssumeFPS*(vsmap:ptr VSMap; src= none(ptr VSNode); fpsnum= none(int); fpsden= none(int)):ptr VSMap =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("vnode") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()

  args.append("clip", clip)
  if src.isSome: args.append("src", src.get)
  if fpsnum.isSome: args.append("fpsnum", fpsnum.get)
  if fpsden.isSome: args.append("fpsden", fpsden.get)

  result = API.invoke(plug, "AssumeFPS".cstring, args)
  API.freeMap(args)


proc AssumeSampleRate*(clip:ptr VSNode; src= none(ptr VSNode); samplerate= none(int)):ptr VSMap =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("vnode") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()

  args.append("clip", clip)
  if src.isSome: args.append("src", src.get)
  if samplerate.isSome: args.append("samplerate", samplerate.get)

  result = API.invoke(plug, "AssumeSampleRate".cstring, args)
  API.freeMap(args)


proc AudioGain*(clip:ptr VSNode; gain= none(seq[float])):ptr VSMap =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("vnode") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()

  args.append("clip", clip)
  if gain.isSome: args.set("gain", gain.get)

  result = API.invoke(plug, "AudioGain".cstring, args)
  API.freeMap(args)


proc AudioLoop*(clip:ptr VSNode; times= none(int)):ptr VSMap =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("vnode") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()

  args.append("clip", clip)
  if times.isSome: args.append("times", times.get)

  result = API.invoke(plug, "AudioLoop".cstring, args)
  API.freeMap(args)


proc AudioMix*(clips:seq[ptr VSNode], matrix:seq[float], channels_out:seq[int]):ptr VSMap =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("clips") >= 1, "the vsmap should contain a seq with nodes")
  var clips = getFirstNodes(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()

  for item in clips:
    args.append("clips", item)
  args.set("matrix", matrix)
  args.set("channels_out", channels_out)

  result = API.invoke(plug, "AudioMix".cstring, args)
  API.freeMap(args)


proc AudioReverse*(clip:ptr VSNode):ptr VSMap =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("vnode") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()


  result = API.invoke(plug, "AudioReverse".cstring, args)
  API.freeMap(args)


proc AudioSplice*(clips:seq[ptr VSNode]):ptr VSMap =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("clips") >= 1, "the vsmap should contain a seq with nodes")
  var clips = getFirstNodes(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()


  result = API.invoke(plug, "AudioSplice".cstring, args)
  API.freeMap(args)


proc AudioTrim*(clip:ptr VSNode; first= none(int); last= none(int); length= none(int)):ptr VSMap =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("vnode") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()

  args.append("clip", clip)
  if first.isSome: args.append("first", first.get)
  if last.isSome: args.append("last", last.get)
  if length.isSome: args.append("length", length.get)

  result = API.invoke(plug, "AudioTrim".cstring, args)
  API.freeMap(args)


proc AverageFrames*(vsmap:ptr VSMap, weights:seq[float]; scale= none(float); scenechange= none(int); planes= none(seq[int])):ptr VSMap =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("clips") >= 1, "the vsmap should contain a seq with nodes")
  var clips = getFirstNodes(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()

  for item in clips:
    args.append("clips", item)
  args.set("weights", weights)
  if scale.isSome: args.append("scale", scale.get)
  if scenechange.isSome: args.append("scenechange", scenechange.get)
  if planes.isSome: args.set("planes", planes.get)

  result = API.invoke(plug, "AverageFrames".cstring, args)
  API.freeMap(args)


proc Binarize*(vsmap:ptr VSMap; threshold= none(seq[float]); v0= none(seq[float]); v1= none(seq[float]); planes= none(seq[int])):ptr VSMap =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("vnode") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()

  args.append("clip", clip)
  if threshold.isSome: args.set("threshold", threshold.get)
  if v0.isSome: args.set("v0", v0.get)
  if v1.isSome: args.set("v1", v1.get)
  if planes.isSome: args.set("planes", planes.get)

  result = API.invoke(plug, "Binarize".cstring, args)
  API.freeMap(args)


proc BinarizeMask*(vsmap:ptr VSMap; threshold= none(seq[float]); v0= none(seq[float]); v1= none(seq[float]); planes= none(seq[int])):ptr VSMap =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("vnode") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()

  args.append("clip", clip)
  if threshold.isSome: args.set("threshold", threshold.get)
  if v0.isSome: args.set("v0", v0.get)
  if v1.isSome: args.set("v1", v1.get)
  if planes.isSome: args.set("planes", planes.get)

  result = API.invoke(plug, "BinarizeMask".cstring, args)
  API.freeMap(args)


proc BlankAudio*(clip= none(ptr VSNode); channels= none(int); bits= none(int); sampletype= none(int); samplerate= none(int); length= none(int); keep= none(int)):ptr VSMap =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  if vsmap.isSome:
    assert( vsmap.get.len != 0, "the vsmap should contain at least one item")
    assert( vsmap.get.len("vnode") == 1, "the vsmap should contain one node")
  var clip:ptr VSNode
  if vsmap.isSome:
    clip = getFirstNode(vsmap.get)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()

  if clip.isSome: args.append("clip", clip.get)
  if channels.isSome: args.append("channels", channels.get)
  if bits.isSome: args.append("bits", bits.get)
  if sampletype.isSome: args.append("sampletype", sampletype.get)
  if samplerate.isSome: args.append("samplerate", samplerate.get)
  if length.isSome: args.append("length", length.get)
  if keep.isSome: args.append("keep", keep.get)

  result = API.invoke(plug, "BlankAudio".cstring, args)
  API.freeMap(args)


proc BlankClip*(vsmap= none(ptr VSMap); width= none(int); height= none(int); format= none(int); length= none(int); fpsnum= none(int); fpsden= none(int); color= none(seq[float]); keep= none(int)):ptr VSMap =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  if vsmap.isSome:
    assert( vsmap.get.len != 0, "the vsmap should contain at least one item")
    assert( vsmap.get.len("vnode") == 1, "the vsmap should contain one node")
  var clip:ptr VSNode
  if vsmap.isSome:
    clip = getFirstNode(vsmap.get)


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

  result = API.invoke(plug, "BlankClip".cstring, args)
  API.freeMap(args)


proc BoxBlur*(vsmap:ptr VSMap; planes= none(seq[int]); hradius= none(int); hpasses= none(int); vradius= none(int); vpasses= none(int)):ptr VSMap =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("vnode") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()

  args.append("clip", clip)
  if planes.isSome: args.set("planes", planes.get)
  if hradius.isSome: args.append("hradius", hradius.get)
  if hpasses.isSome: args.append("hpasses", hpasses.get)
  if vradius.isSome: args.append("vradius", vradius.get)
  if vpasses.isSome: args.append("vpasses", vpasses.get)

  result = API.invoke(plug, "BoxBlur".cstring, args)
  API.freeMap(args)


proc Cache*(vsmap:ptr VSMap; size= none(int); fixed= none(int); make_linear= none(int)):ptr VSMap =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("vnode") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()

  args.append("clip", clip)
  if size.isSome: args.append("size", size.get)
  if fixed.isSome: args.append("fixed", fixed.get)
  if make_linear.isSome: args.append("make_linear", make_linear.get)

  result = API.invoke(plug, "Cache".cstring, args)
  API.freeMap(args)


proc ClipToProp*(vsmap:ptr VSMap, mclip:ptr VSNode; prop= none(string)):ptr VSMap =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("vnode") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()

  args.append("clip", clip)
  args.append("mclip", mclip)
  if prop.isSome: args.append("prop", prop.get)

  result = API.invoke(plug, "ClipToProp".cstring, args)
  API.freeMap(args)


proc Convolution*(vsmap:ptr VSMap, matrix:seq[float]; bias= none(float); divisor= none(float); planes= none(seq[int]); saturate= none(int); mode= none(string)):ptr VSMap =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("vnode") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()

  args.append("clip", clip)
  args.set("matrix", matrix)
  if bias.isSome: args.append("bias", bias.get)
  if divisor.isSome: args.append("divisor", divisor.get)
  if planes.isSome: args.set("planes", planes.get)
  if saturate.isSome: args.append("saturate", saturate.get)
  if mode.isSome: args.append("mode", mode.get)

  result = API.invoke(plug, "Convolution".cstring, args)
  API.freeMap(args)


proc CopyFrameProps*(vsmap:ptr VSMap, prop_src:ptr VSNode):ptr VSMap =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("vnode") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()

  args.append("clip", clip)
  args.append("prop_src", prop_src)

  result = API.invoke(plug, "CopyFrameProps".cstring, args)
  API.freeMap(args)


proc Crop*(vsmap:ptr VSMap; left= none(int); right= none(int); top= none(int); bottom= none(int)):ptr VSMap =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("vnode") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()

  args.append("clip", clip)
  if left.isSome: args.append("left", left.get)
  if right.isSome: args.append("right", right.get)
  if top.isSome: args.append("top", top.get)
  if bottom.isSome: args.append("bottom", bottom.get)

  result = API.invoke(plug, "Crop".cstring, args)
  API.freeMap(args)


proc CropAbs*(vsmap:ptr VSMap, width:int, height:int; left= none(int); top= none(int); x= none(int); y= none(int)):ptr VSMap =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("vnode") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()

  args.append("clip", clip)
  args.append("width", width)
  args.append("height", height)
  if left.isSome: args.append("left", left.get)
  if top.isSome: args.append("top", top.get)
  if x.isSome: args.append("x", x.get)
  if y.isSome: args.append("y", y.get)

  result = API.invoke(plug, "CropAbs".cstring, args)
  API.freeMap(args)


proc CropRel*(vsmap:ptr VSMap; left= none(int); right= none(int); top= none(int); bottom= none(int)):ptr VSMap =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("vnode") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()

  args.append("clip", clip)
  if left.isSome: args.append("left", left.get)
  if right.isSome: args.append("right", right.get)
  if top.isSome: args.append("top", top.get)
  if bottom.isSome: args.append("bottom", bottom.get)

  result = API.invoke(plug, "CropRel".cstring, args)
  API.freeMap(args)


proc Deflate*(vsmap:ptr VSMap; planes= none(seq[int]); threshold= none(float)):ptr VSMap =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("vnode") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()

  args.append("clip", clip)
  if planes.isSome: args.set("planes", planes.get)
  if threshold.isSome: args.append("threshold", threshold.get)

  result = API.invoke(plug, "Deflate".cstring, args)
  API.freeMap(args)


proc DeleteFrames*(vsmap:ptr VSMap, frames:seq[int]):ptr VSMap =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("vnode") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()

  args.append("clip", clip)
  args.set("frames", frames)

  result = API.invoke(plug, "DeleteFrames".cstring, args)
  API.freeMap(args)


proc DoubleWeave*(vsmap:ptr VSMap; tff= none(int)):ptr VSMap =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("vnode") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()

  args.append("clip", clip)
  if tff.isSome: args.append("tff", tff.get)

  result = API.invoke(plug, "DoubleWeave".cstring, args)
  API.freeMap(args)


proc DuplicateFrames*(vsmap:ptr VSMap, frames:seq[int]):ptr VSMap =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("vnode") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()

  args.append("clip", clip)
  args.set("frames", frames)

  result = API.invoke(plug, "DuplicateFrames".cstring, args)
  API.freeMap(args)


proc Expr*(vsmap:ptr VSMap, expr:seq[string]; format= none(int)):ptr VSMap =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("clips") >= 1, "the vsmap should contain a seq with nodes")
  var clips = getFirstNodes(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()

  for item in clips:
    args.append("clips", item)
  for item in expr:
    args.append("expr", item)
  if format.isSome: args.append("format", format.get)

  result = API.invoke(plug, "Expr".cstring, args)
  API.freeMap(args)


proc FlipHorizontal*(vsmap:ptr VSMap):ptr VSMap =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("vnode") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()


  result = API.invoke(plug, "FlipHorizontal".cstring, args)
  API.freeMap(args)


proc FlipVertical*(vsmap:ptr VSMap):ptr VSMap =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("vnode") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()


  result = API.invoke(plug, "FlipVertical".cstring, args)
  API.freeMap(args)


proc FrameEval*(vsmap:ptr VSMap, eval:ptr VSFuncRef; prop_src= none(seq[ptr VSNode]); clip_src= none(seq[ptr VSNode])):ptr VSMap =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("vnode") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()

  args.append("clip", clip)
  args.append("eval", eval)
  if prop_src.isSome:
    for item in prop_src.get:
      args.append("prop_src", item)
  if clip_src.isSome:
    for item in clip_src.get:
      args.append("clip_src", item)

  result = API.invoke(plug, "FrameEval".cstring, args)
  API.freeMap(args)


proc FreezeFrames*(vsmap:ptr VSMap, first:seq[int], last:seq[int], replacement:seq[int]):ptr VSMap =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("vnode") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()

  args.append("clip", clip)
  args.set("first", first)
  args.set("last", last)
  args.set("replacement", replacement)

  result = API.invoke(plug, "FreezeFrames".cstring, args)
  API.freeMap(args)


proc Inflate*(vsmap:ptr VSMap; planes= none(seq[int]); threshold= none(float)):ptr VSMap =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("vnode") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()

  args.append("clip", clip)
  if planes.isSome: args.set("planes", planes.get)
  if threshold.isSome: args.append("threshold", threshold.get)

  result = API.invoke(plug, "Inflate".cstring, args)
  API.freeMap(args)


proc Interleave*(vsmap:ptr VSMap; extend= none(int); mismatch= none(int); modify_duration= none(int)):ptr VSMap =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("clips") >= 1, "the vsmap should contain a seq with nodes")
  var clips = getFirstNodes(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()

  for item in clips:
    args.append("clips", item)
  if extend.isSome: args.append("extend", extend.get)
  if mismatch.isSome: args.append("mismatch", mismatch.get)
  if modify_duration.isSome: args.append("modify_duration", modify_duration.get)

  result = API.invoke(plug, "Interleave".cstring, args)
  API.freeMap(args)


proc Invert*(vsmap:ptr VSMap; planes= none(seq[int])):ptr VSMap =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("vnode") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()

  args.append("clip", clip)
  if planes.isSome: args.set("planes", planes.get)

  result = API.invoke(plug, "Invert".cstring, args)
  API.freeMap(args)


proc InvertMask*(vsmap:ptr VSMap; planes= none(seq[int])):ptr VSMap =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("vnode") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()

  args.append("clip", clip)
  if planes.isSome: args.set("planes", planes.get)

  result = API.invoke(plug, "InvertMask".cstring, args)
  API.freeMap(args)


proc Levels*(vsmap:ptr VSMap; min_in= none(seq[float]); max_in= none(seq[float]); gamma= none(seq[float]); min_out= none(seq[float]); max_out= none(seq[float]); planes= none(seq[int])):ptr VSMap =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("vnode") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()

  args.append("clip", clip)
  if min_in.isSome: args.set("min_in", min_in.get)
  if max_in.isSome: args.set("max_in", max_in.get)
  if gamma.isSome: args.set("gamma", gamma.get)
  if min_out.isSome: args.set("min_out", min_out.get)
  if max_out.isSome: args.set("max_out", max_out.get)
  if planes.isSome: args.set("planes", planes.get)

  result = API.invoke(plug, "Levels".cstring, args)
  API.freeMap(args)


proc Limiter*(vsmap:ptr VSMap; min= none(seq[float]); max= none(seq[float]); planes= none(seq[int])):ptr VSMap =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("vnode") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()

  args.append("clip", clip)
  if min.isSome: args.set("min", min.get)
  if max.isSome: args.set("max", max.get)
  if planes.isSome: args.set("planes", planes.get)

  result = API.invoke(plug, "Limiter".cstring, args)
  API.freeMap(args)


proc LoadAllPlugins*(path:string):ptr VSMap =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 

  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()


  result = API.invoke(plug, "LoadAllPlugins".cstring, args)
  API.freeMap(args)


proc LoadPlugin*(path:string; altsearchpath= none(int); forcens= none(string); forceid= none(string)):ptr VSMap =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 

  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()

  args.append("path", path)
  if altsearchpath.isSome: args.append("altsearchpath", altsearchpath.get)
  if forcens.isSome: args.append("forcens", forcens.get)
  if forceid.isSome: args.append("forceid", forceid.get)

  result = API.invoke(plug, "LoadPlugin".cstring, args)
  API.freeMap(args)


proc Loop*(vsmap:ptr VSMap; times= none(int)):ptr VSMap =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("vnode") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()

  args.append("clip", clip)
  if times.isSome: args.append("times", times.get)

  result = API.invoke(plug, "Loop".cstring, args)
  API.freeMap(args)


proc Lut*(vsmap:ptr VSMap; planes= none(seq[int]); lut= none(seq[int]); lutf= none(seq[float]); function= none(ptr VSFuncRef); bits= none(int); floatout= none(int)):ptr VSMap =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("vnode") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()

  args.append("clip", clip)
  if planes.isSome: args.set("planes", planes.get)
  if lut.isSome: args.set("lut", lut.get)
  if lutf.isSome: args.set("lutf", lutf.get)
  if function.isSome: args.append("function", function.get)
  if bits.isSome: args.append("bits", bits.get)
  if floatout.isSome: args.append("floatout", floatout.get)

  result = API.invoke(plug, "Lut".cstring, args)
  API.freeMap(args)


proc Lut2*(vsmap:ptr VSMap, clipb:ptr VSNode; planes= none(seq[int]); lut= none(seq[int]); lutf= none(seq[float]); function= none(ptr VSFuncRef); bits= none(int); floatout= none(int)):ptr VSMap =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("vnode") == 1, "the vsmap should contain one node")
  var clipa = getFirstNode(vsmap)


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

  result = API.invoke(plug, "Lut2".cstring, args)
  API.freeMap(args)


proc MakeDiff*(vsmap:ptr VSMap, clipb:ptr VSNode; planes= none(seq[int])):ptr VSMap =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("vnode") == 1, "the vsmap should contain one node")
  var clipa = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()

  args.append("clipa", clipa)
  args.append("clipb", clipb)
  if planes.isSome: args.set("planes", planes.get)

  result = API.invoke(plug, "MakeDiff".cstring, args)
  API.freeMap(args)


proc MaskedMerge*(vsmap:ptr VSMap, clipb:ptr VSNode, mask:ptr VSNode; planes= none(seq[int]); first_plane= none(int); premultiplied= none(int)):ptr VSMap =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("vnode") == 1, "the vsmap should contain one node")
  var clipa = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()

  args.append("clipa", clipa)
  args.append("clipb", clipb)
  args.append("mask", mask)
  if planes.isSome: args.set("planes", planes.get)
  if first_plane.isSome: args.append("first_plane", first_plane.get)
  if premultiplied.isSome: args.append("premultiplied", premultiplied.get)

  result = API.invoke(plug, "MaskedMerge".cstring, args)
  API.freeMap(args)


proc Maximum*(vsmap:ptr VSMap; planes= none(seq[int]); threshold= none(float); coordinates= none(seq[int])):ptr VSMap =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("vnode") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()

  args.append("clip", clip)
  if planes.isSome: args.set("planes", planes.get)
  if threshold.isSome: args.append("threshold", threshold.get)
  if coordinates.isSome: args.set("coordinates", coordinates.get)

  result = API.invoke(plug, "Maximum".cstring, args)
  API.freeMap(args)


proc Median*(vsmap:ptr VSMap; planes= none(seq[int])):ptr VSMap =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("vnode") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()

  args.append("clip", clip)
  if planes.isSome: args.set("planes", planes.get)

  result = API.invoke(plug, "Median".cstring, args)
  API.freeMap(args)


proc Merge*(vsmap:ptr VSMap, clipb:ptr VSNode; weight= none(seq[float])):ptr VSMap =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("vnode") == 1, "the vsmap should contain one node")
  var clipa = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()

  args.append("clipa", clipa)
  args.append("clipb", clipb)
  if weight.isSome: args.set("weight", weight.get)

  result = API.invoke(plug, "Merge".cstring, args)
  API.freeMap(args)


proc MergeDiff*(vsmap:ptr VSMap, clipb:ptr VSNode; planes= none(seq[int])):ptr VSMap =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("vnode") == 1, "the vsmap should contain one node")
  var clipa = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()

  args.append("clipa", clipa)
  args.append("clipb", clipb)
  if planes.isSome: args.set("planes", planes.get)

  result = API.invoke(plug, "MergeDiff".cstring, args)
  API.freeMap(args)


proc Minimum*(vsmap:ptr VSMap; planes= none(seq[int]); threshold= none(float); coordinates= none(seq[int])):ptr VSMap =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("vnode") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()

  args.append("clip", clip)
  if planes.isSome: args.set("planes", planes.get)
  if threshold.isSome: args.append("threshold", threshold.get)
  if coordinates.isSome: args.set("coordinates", coordinates.get)

  result = API.invoke(plug, "Minimum".cstring, args)
  API.freeMap(args)


proc ModifyFrame*(vsmap:ptr VSMap, clips:seq[ptr VSNode], selector:ptr VSFuncRef):ptr VSMap =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("vnode") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()

  args.append("clip", clip)
  for item in clips:
    args.append("clips", item)
  args.append("selector", selector)

  result = API.invoke(plug, "ModifyFrame".cstring, args)
  API.freeMap(args)


proc PEMVerifier*(vsmap:ptr VSMap; upper= none(seq[float]); lower= none(seq[float])):ptr VSMap =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("vnode") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()

  args.append("clip", clip)
  if upper.isSome: args.set("upper", upper.get)
  if lower.isSome: args.set("lower", lower.get)

  result = API.invoke(plug, "PEMVerifier".cstring, args)
  API.freeMap(args)


proc PlaneStats*(vsmap:ptr VSMap; clipb= none(ptr VSNode); plane= none(int); prop= none(string)):ptr VSMap =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("vnode") == 1, "the vsmap should contain one node")
  var clipa = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()

  args.append("clipa", clipa)
  if clipb.isSome: args.append("clipb", clipb.get)
  if plane.isSome: args.append("plane", plane.get)
  if prop.isSome: args.append("prop", prop.get)

  result = API.invoke(plug, "PlaneStats".cstring, args)
  API.freeMap(args)


proc PreMultiply*(vsmap:ptr VSMap, alpha:ptr VSNode):ptr VSMap =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("vnode") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()

  args.append("clip", clip)
  args.append("alpha", alpha)

  result = API.invoke(plug, "PreMultiply".cstring, args)
  API.freeMap(args)


proc Prewitt*(vsmap:ptr VSMap; planes= none(seq[int]); scale= none(float)):ptr VSMap =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("vnode") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()

  args.append("clip", clip)
  if planes.isSome: args.set("planes", planes.get)
  if scale.isSome: args.append("scale", scale.get)

  result = API.invoke(plug, "Prewitt".cstring, args)
  API.freeMap(args)


proc PropToClip*(vsmap:ptr VSMap; prop= none(string)):ptr VSMap =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("vnode") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()

  args.append("clip", clip)
  if prop.isSome: args.append("prop", prop.get)

  result = API.invoke(plug, "PropToClip".cstring, args)
  API.freeMap(args)


proc RemoveFrameProps*(vsmap:ptr VSMap; props= none(seq[string])):ptr VSMap =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("vnode") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()

  args.append("clip", clip)
  if props.isSome:
    for item in props.get:
      args.append("props", item)

  result = API.invoke(plug, "RemoveFrameProps".cstring, args)
  API.freeMap(args)


proc Reverse*(vsmap:ptr VSMap):ptr VSMap =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("vnode") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()


  result = API.invoke(plug, "Reverse".cstring, args)
  API.freeMap(args)


proc SelectEvery*(vsmap:ptr VSMap, cycle:int, offsets:seq[int]; modify_duration= none(int)):ptr VSMap =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("vnode") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()

  args.append("clip", clip)
  args.append("cycle", cycle)
  args.set("offsets", offsets)
  if modify_duration.isSome: args.append("modify_duration", modify_duration.get)

  result = API.invoke(plug, "SelectEvery".cstring, args)
  API.freeMap(args)


proc SeparateFields*(vsmap:ptr VSMap; tff= none(int); modify_duration= none(int)):ptr VSMap =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("vnode") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()

  args.append("clip", clip)
  if tff.isSome: args.append("tff", tff.get)
  if modify_duration.isSome: args.append("modify_duration", modify_duration.get)

  result = API.invoke(plug, "SeparateFields".cstring, args)
  API.freeMap(args)


proc SetAudioCache*(clip:ptr VSNode; mode= none(int); fixedsize= none(int); maxsize= none(int); maxhistory= none(int)):ptr VSMap =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("vnode") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()

  args.append("clip", clip)
  if mode.isSome: args.append("mode", mode.get)
  if fixedsize.isSome: args.append("fixedsize", fixedsize.get)
  if maxsize.isSome: args.append("maxsize", maxsize.get)
  if maxhistory.isSome: args.append("maxhistory", maxhistory.get)

  result = API.invoke(plug, "SetAudioCache".cstring, args)
  API.freeMap(args)


proc SetFieldBased*(vsmap:ptr VSMap, value:int):ptr VSMap =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("vnode") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()

  args.append("clip", clip)
  args.append("value", value)

  result = API.invoke(plug, "SetFieldBased".cstring, args)
  API.freeMap(args)


proc SetFrameProp*(vsmap:ptr VSMap, prop:string; intval= none(seq[int]); floatval= none(seq[float]); data= none(seq[string])):ptr VSMap =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("vnode") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()

  args.append("clip", clip)
  args.append("prop", prop)
  if intval.isSome: args.set("intval", intval.get)
  if floatval.isSome: args.set("floatval", floatval.get)
  if data.isSome:
    for item in data.get:
      args.append("data", item)

  result = API.invoke(plug, "SetFrameProp".cstring, args)
  API.freeMap(args)


proc SetFrameProps*(vsmap:ptr VSMap, any:any):ptr VSMap =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("vnode") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()

  args.append("clip", clip)
  args.append("any", any)

  result = API.invoke(plug, "SetFrameProps".cstring, args)
  API.freeMap(args)


proc SetMaxCPU*(cpu:string):ptr VSMap =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 

  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()


  result = API.invoke(plug, "SetMaxCPU".cstring, args)
  API.freeMap(args)


proc SetVideoCache*(vsmap:ptr VSMap; mode= none(int); fixedsize= none(int); maxsize= none(int); maxhistory= none(int)):ptr VSMap =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("vnode") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()

  args.append("clip", clip)
  if mode.isSome: args.append("mode", mode.get)
  if fixedsize.isSome: args.append("fixedsize", fixedsize.get)
  if maxsize.isSome: args.append("maxsize", maxsize.get)
  if maxhistory.isSome: args.append("maxhistory", maxhistory.get)

  result = API.invoke(plug, "SetVideoCache".cstring, args)
  API.freeMap(args)


proc ShuffleChannels*(clips:seq[ptr VSNode], channels_in:seq[int], channels_out:seq[int]):ptr VSMap =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("clips") >= 1, "the vsmap should contain a seq with nodes")
  var clips = getFirstNodes(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()

  for item in clips:
    args.append("clips", item)
  args.set("channels_in", channels_in)
  args.set("channels_out", channels_out)

  result = API.invoke(plug, "ShuffleChannels".cstring, args)
  API.freeMap(args)


proc ShufflePlanes*(vsmap:ptr VSMap, planes:seq[int], colorfamily:int):ptr VSMap =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("clips") >= 1, "the vsmap should contain a seq with nodes")
  var clips = getFirstNodes(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()

  for item in clips:
    args.append("clips", item)
  args.set("planes", planes)
  args.append("colorfamily", colorfamily)

  result = API.invoke(plug, "ShufflePlanes".cstring, args)
  API.freeMap(args)


proc Sobel*(vsmap:ptr VSMap; planes= none(seq[int]); scale= none(float)):ptr VSMap =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("vnode") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()

  args.append("clip", clip)
  if planes.isSome: args.set("planes", planes.get)
  if scale.isSome: args.append("scale", scale.get)

  result = API.invoke(plug, "Sobel".cstring, args)
  API.freeMap(args)


proc Splice*(vsmap:ptr VSMap; mismatch= none(int)):ptr VSMap =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("clips") >= 1, "the vsmap should contain a seq with nodes")
  var clips = getFirstNodes(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()

  for item in clips:
    args.append("clips", item)
  if mismatch.isSome: args.append("mismatch", mismatch.get)

  result = API.invoke(plug, "Splice".cstring, args)
  API.freeMap(args)


proc SplitChannels*(clip:ptr VSNode):ptr VSMap =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("vnode") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()


  result = API.invoke(plug, "SplitChannels".cstring, args)
  API.freeMap(args)


proc SplitPlanes*(vsmap:ptr VSMap):ptr VSMap =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("vnode") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()


  result = API.invoke(plug, "SplitPlanes".cstring, args)
  API.freeMap(args)


proc StackHorizontal*(vsmap:ptr VSMap):ptr VSMap =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("clips") >= 1, "the vsmap should contain a seq with nodes")
  var clips = getFirstNodes(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()


  result = API.invoke(plug, "StackHorizontal".cstring, args)
  API.freeMap(args)


proc StackVertical*(vsmap:ptr VSMap):ptr VSMap =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("clips") >= 1, "the vsmap should contain a seq with nodes")
  var clips = getFirstNodes(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()


  result = API.invoke(plug, "StackVertical".cstring, args)
  API.freeMap(args)


proc TestAudio*(channels= none(int); bits= none(int); isfloat= none(int); samplerate= none(int); length= none(int)):ptr VSMap =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 

  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()

  if channels.isSome: args.append("channels", channels.get)
  if bits.isSome: args.append("bits", bits.get)
  if isfloat.isSome: args.append("isfloat", isfloat.get)
  if samplerate.isSome: args.append("samplerate", samplerate.get)
  if length.isSome: args.append("length", length.get)

  result = API.invoke(plug, "TestAudio".cstring, args)
  API.freeMap(args)


proc Transpose*(vsmap:ptr VSMap):ptr VSMap =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("vnode") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()


  result = API.invoke(plug, "Transpose".cstring, args)
  API.freeMap(args)


proc Trim*(vsmap:ptr VSMap; first= none(int); last= none(int); length= none(int)):ptr VSMap =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("vnode") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()

  args.append("clip", clip)
  if first.isSome: args.append("first", first.get)
  if last.isSome: args.append("last", last.get)
  if length.isSome: args.append("length", length.get)

  result = API.invoke(plug, "Trim".cstring, args)
  API.freeMap(args)


proc Turn180*(vsmap:ptr VSMap):ptr VSMap =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("vnode") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()


  result = API.invoke(plug, "Turn180".cstring, args)
  API.freeMap(args)


