proc ClipInfo*(vsmap:ptr VSMap; alignment= none(int); scale= none(int)):ptr VSMap =

  let plug = getPluginById("com.vapoursynth.text")
  assert( plug != nil, "plugin \"com.vapoursynth.text\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("vnode") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()

  args.append("clip", clip)
  if alignment.isSome: args.append("alignment", alignment.get)
  if scale.isSome: args.append("scale", scale.get)

  result = API.invoke(plug, "ClipInfo".cstring, args)
  API.freeMap(args)


proc CoreInfo*(vsmap= none(ptr VSMap); alignment= none(int); scale= none(int)):ptr VSMap =

  let plug = getPluginById("com.vapoursynth.text")
  assert( plug != nil, "plugin \"com.vapoursynth.text\" not installed properly in your computer") 
  if vsmap.isSome:
    assert( vsmap.get.len != 0, "the vsmap should contain at least one item")
    assert( vsmap.get.len("vnode") == 1, "the vsmap should contain one node")
  var clip:ptr VSNode
  if vsmap.isSome:
    clip = getFirstNode(vsmap.get)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()

  if clip.isSome: args.append("clip", clip.get)
  if alignment.isSome: args.append("alignment", alignment.get)
  if scale.isSome: args.append("scale", scale.get)

  result = API.invoke(plug, "CoreInfo".cstring, args)
  API.freeMap(args)


proc FrameNum*(vsmap:ptr VSMap; alignment= none(int); scale= none(int)):ptr VSMap =

  let plug = getPluginById("com.vapoursynth.text")
  assert( plug != nil, "plugin \"com.vapoursynth.text\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("vnode") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()

  args.append("clip", clip)
  if alignment.isSome: args.append("alignment", alignment.get)
  if scale.isSome: args.append("scale", scale.get)

  result = API.invoke(plug, "FrameNum".cstring, args)
  API.freeMap(args)


proc FrameProps*(vsmap:ptr VSMap; props= none(seq[string]); alignment= none(int); scale= none(int)):ptr VSMap =

  let plug = getPluginById("com.vapoursynth.text")
  assert( plug != nil, "plugin \"com.vapoursynth.text\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("vnode") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()

  args.append("clip", clip)
  if props.isSome:
    for item in props.get:
      args.append("props", item)
  if alignment.isSome: args.append("alignment", alignment.get)
  if scale.isSome: args.append("scale", scale.get)

  result = API.invoke(plug, "FrameProps".cstring, args)
  API.freeMap(args)


proc Text*(vsmap:ptr VSMap, text:string; alignment= none(int); scale= none(int)):ptr VSMap =

  let plug = getPluginById("com.vapoursynth.text")
  assert( plug != nil, "plugin \"com.vapoursynth.text\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("vnode") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()

  args.append("clip", clip)
  args.append("text", text)
  if alignment.isSome: args.append("alignment", alignment.get)
  if scale.isSome: args.append("scale", scale.get)

  result = API.invoke(plug, "Text".cstring, args)
  API.freeMap(args)


