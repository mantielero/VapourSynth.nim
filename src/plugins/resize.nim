proc Bicubic*(vsmap:ptr VSMap; width=none(int); height=none(int); format=none(int); matrix=none(int); matrix_s=none(string); transfer=none(int); transfer_s=none(string); primaries=none(int); primaries_s=none(string); range=none(int); range_s=none(string); chromaloc=none(int); chromaloc_s=none(string); matrix_in=none(int); matrix_in_s=none(string); transfer_in=none(int); transfer_in_s=none(string); primaries_in=none(int); primaries_in_s=none(string); range_in=none(int); range_in_s=none(string); chromaloc_in=none(int); chromaloc_in_s=none(string); filter_param_a=none(float); filter_param_b=none(float); resample_filter_uv=none(string); filter_param_a_uv=none(float); filter_param_b_uv=none(float); dither_type=none(string); cpu_type=none(string); prefer_props=none(int); src_left=none(float); src_top=none(float); src_width=none(float); src_height=none(float); nominal_luminance=none(float)):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.resize")
  if plug == nil:
    raise newException(ValueError, "plugin \"resize\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq    # Convert the VSMap into a sequence
  if tmpSeq.len == 0:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()
  args.append("clip", clip)
  if width.isSome: args.append("width", width.get)
  if height.isSome: args.append("height", height.get)
  if format.isSome: args.append("format", format.get)
  if matrix.isSome: args.append("matrix", matrix.get)
  if matrix_s.isSome: args.append("matrix_s", matrix_s.get)
  if transfer.isSome: args.append("transfer", transfer.get)
  if transfer_s.isSome: args.append("transfer_s", transfer_s.get)
  if primaries.isSome: args.append("primaries", primaries.get)
  if primaries_s.isSome: args.append("primaries_s", primaries_s.get)
  if range.isSome: args.append("range", range.get)
  if range_s.isSome: args.append("range_s", range_s.get)
  if chromaloc.isSome: args.append("chromaloc", chromaloc.get)
  if chromaloc_s.isSome: args.append("chromaloc_s", chromaloc_s.get)
  if matrix_in.isSome: args.append("matrix_in", matrix_in.get)
  if matrix_in_s.isSome: args.append("matrix_in_s", matrix_in_s.get)
  if transfer_in.isSome: args.append("transfer_in", transfer_in.get)
  if transfer_in_s.isSome: args.append("transfer_in_s", transfer_in_s.get)
  if primaries_in.isSome: args.append("primaries_in", primaries_in.get)
  if primaries_in_s.isSome: args.append("primaries_in_s", primaries_in_s.get)
  if range_in.isSome: args.append("range_in", range_in.get)
  if range_in_s.isSome: args.append("range_in_s", range_in_s.get)
  if chromaloc_in.isSome: args.append("chromaloc_in", chromaloc_in.get)
  if chromaloc_in_s.isSome: args.append("chromaloc_in_s", chromaloc_in_s.get)
  if filter_param_a.isSome: args.append("filter_param_a", filter_param_a.get)
  if filter_param_b.isSome: args.append("filter_param_b", filter_param_b.get)
  if resample_filter_uv.isSome: args.append("resample_filter_uv", resample_filter_uv.get)
  if filter_param_a_uv.isSome: args.append("filter_param_a_uv", filter_param_a_uv.get)
  if filter_param_b_uv.isSome: args.append("filter_param_b_uv", filter_param_b_uv.get)
  if dither_type.isSome: args.append("dither_type", dither_type.get)
  if cpu_type.isSome: args.append("cpu_type", cpu_type.get)
  if prefer_props.isSome: args.append("prefer_props", prefer_props.get)
  if src_left.isSome: args.append("src_left", src_left.get)
  if src_top.isSome: args.append("src_top", src_top.get)
  if src_width.isSome: args.append("src_width", src_width.get)
  if src_height.isSome: args.append("src_height", src_height.get)
  if nominal_luminance.isSome: args.append("nominal_luminance", nominal_luminance.get)

  return API.invoke(plug, "Bicubic".cstring, args)        

proc Bilinear*(vsmap:ptr VSMap; width=none(int); height=none(int); format=none(int); matrix=none(int); matrix_s=none(string); transfer=none(int); transfer_s=none(string); primaries=none(int); primaries_s=none(string); range=none(int); range_s=none(string); chromaloc=none(int); chromaloc_s=none(string); matrix_in=none(int); matrix_in_s=none(string); transfer_in=none(int); transfer_in_s=none(string); primaries_in=none(int); primaries_in_s=none(string); range_in=none(int); range_in_s=none(string); chromaloc_in=none(int); chromaloc_in_s=none(string); filter_param_a=none(float); filter_param_b=none(float); resample_filter_uv=none(string); filter_param_a_uv=none(float); filter_param_b_uv=none(float); dither_type=none(string); cpu_type=none(string); prefer_props=none(int); src_left=none(float); src_top=none(float); src_width=none(float); src_height=none(float); nominal_luminance=none(float)):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.resize")
  if plug == nil:
    raise newException(ValueError, "plugin \"resize\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq    # Convert the VSMap into a sequence
  if tmpSeq.len == 0:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()
  args.append("clip", clip)
  if width.isSome: args.append("width", width.get)
  if height.isSome: args.append("height", height.get)
  if format.isSome: args.append("format", format.get)
  if matrix.isSome: args.append("matrix", matrix.get)
  if matrix_s.isSome: args.append("matrix_s", matrix_s.get)
  if transfer.isSome: args.append("transfer", transfer.get)
  if transfer_s.isSome: args.append("transfer_s", transfer_s.get)
  if primaries.isSome: args.append("primaries", primaries.get)
  if primaries_s.isSome: args.append("primaries_s", primaries_s.get)
  if range.isSome: args.append("range", range.get)
  if range_s.isSome: args.append("range_s", range_s.get)
  if chromaloc.isSome: args.append("chromaloc", chromaloc.get)
  if chromaloc_s.isSome: args.append("chromaloc_s", chromaloc_s.get)
  if matrix_in.isSome: args.append("matrix_in", matrix_in.get)
  if matrix_in_s.isSome: args.append("matrix_in_s", matrix_in_s.get)
  if transfer_in.isSome: args.append("transfer_in", transfer_in.get)
  if transfer_in_s.isSome: args.append("transfer_in_s", transfer_in_s.get)
  if primaries_in.isSome: args.append("primaries_in", primaries_in.get)
  if primaries_in_s.isSome: args.append("primaries_in_s", primaries_in_s.get)
  if range_in.isSome: args.append("range_in", range_in.get)
  if range_in_s.isSome: args.append("range_in_s", range_in_s.get)
  if chromaloc_in.isSome: args.append("chromaloc_in", chromaloc_in.get)
  if chromaloc_in_s.isSome: args.append("chromaloc_in_s", chromaloc_in_s.get)
  if filter_param_a.isSome: args.append("filter_param_a", filter_param_a.get)
  if filter_param_b.isSome: args.append("filter_param_b", filter_param_b.get)
  if resample_filter_uv.isSome: args.append("resample_filter_uv", resample_filter_uv.get)
  if filter_param_a_uv.isSome: args.append("filter_param_a_uv", filter_param_a_uv.get)
  if filter_param_b_uv.isSome: args.append("filter_param_b_uv", filter_param_b_uv.get)
  if dither_type.isSome: args.append("dither_type", dither_type.get)
  if cpu_type.isSome: args.append("cpu_type", cpu_type.get)
  if prefer_props.isSome: args.append("prefer_props", prefer_props.get)
  if src_left.isSome: args.append("src_left", src_left.get)
  if src_top.isSome: args.append("src_top", src_top.get)
  if src_width.isSome: args.append("src_width", src_width.get)
  if src_height.isSome: args.append("src_height", src_height.get)
  if nominal_luminance.isSome: args.append("nominal_luminance", nominal_luminance.get)

  return API.invoke(plug, "Bilinear".cstring, args)        

proc Lanczos*(vsmap:ptr VSMap; width=none(int); height=none(int); format=none(int); matrix=none(int); matrix_s=none(string); transfer=none(int); transfer_s=none(string); primaries=none(int); primaries_s=none(string); range=none(int); range_s=none(string); chromaloc=none(int); chromaloc_s=none(string); matrix_in=none(int); matrix_in_s=none(string); transfer_in=none(int); transfer_in_s=none(string); primaries_in=none(int); primaries_in_s=none(string); range_in=none(int); range_in_s=none(string); chromaloc_in=none(int); chromaloc_in_s=none(string); filter_param_a=none(float); filter_param_b=none(float); resample_filter_uv=none(string); filter_param_a_uv=none(float); filter_param_b_uv=none(float); dither_type=none(string); cpu_type=none(string); prefer_props=none(int); src_left=none(float); src_top=none(float); src_width=none(float); src_height=none(float); nominal_luminance=none(float)):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.resize")
  if plug == nil:
    raise newException(ValueError, "plugin \"resize\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq    # Convert the VSMap into a sequence
  if tmpSeq.len == 0:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()
  args.append("clip", clip)
  if width.isSome: args.append("width", width.get)
  if height.isSome: args.append("height", height.get)
  if format.isSome: args.append("format", format.get)
  if matrix.isSome: args.append("matrix", matrix.get)
  if matrix_s.isSome: args.append("matrix_s", matrix_s.get)
  if transfer.isSome: args.append("transfer", transfer.get)
  if transfer_s.isSome: args.append("transfer_s", transfer_s.get)
  if primaries.isSome: args.append("primaries", primaries.get)
  if primaries_s.isSome: args.append("primaries_s", primaries_s.get)
  if range.isSome: args.append("range", range.get)
  if range_s.isSome: args.append("range_s", range_s.get)
  if chromaloc.isSome: args.append("chromaloc", chromaloc.get)
  if chromaloc_s.isSome: args.append("chromaloc_s", chromaloc_s.get)
  if matrix_in.isSome: args.append("matrix_in", matrix_in.get)
  if matrix_in_s.isSome: args.append("matrix_in_s", matrix_in_s.get)
  if transfer_in.isSome: args.append("transfer_in", transfer_in.get)
  if transfer_in_s.isSome: args.append("transfer_in_s", transfer_in_s.get)
  if primaries_in.isSome: args.append("primaries_in", primaries_in.get)
  if primaries_in_s.isSome: args.append("primaries_in_s", primaries_in_s.get)
  if range_in.isSome: args.append("range_in", range_in.get)
  if range_in_s.isSome: args.append("range_in_s", range_in_s.get)
  if chromaloc_in.isSome: args.append("chromaloc_in", chromaloc_in.get)
  if chromaloc_in_s.isSome: args.append("chromaloc_in_s", chromaloc_in_s.get)
  if filter_param_a.isSome: args.append("filter_param_a", filter_param_a.get)
  if filter_param_b.isSome: args.append("filter_param_b", filter_param_b.get)
  if resample_filter_uv.isSome: args.append("resample_filter_uv", resample_filter_uv.get)
  if filter_param_a_uv.isSome: args.append("filter_param_a_uv", filter_param_a_uv.get)
  if filter_param_b_uv.isSome: args.append("filter_param_b_uv", filter_param_b_uv.get)
  if dither_type.isSome: args.append("dither_type", dither_type.get)
  if cpu_type.isSome: args.append("cpu_type", cpu_type.get)
  if prefer_props.isSome: args.append("prefer_props", prefer_props.get)
  if src_left.isSome: args.append("src_left", src_left.get)
  if src_top.isSome: args.append("src_top", src_top.get)
  if src_width.isSome: args.append("src_width", src_width.get)
  if src_height.isSome: args.append("src_height", src_height.get)
  if nominal_luminance.isSome: args.append("nominal_luminance", nominal_luminance.get)

  return API.invoke(plug, "Lanczos".cstring, args)        

proc Point*(vsmap:ptr VSMap; width=none(int); height=none(int); format=none(int); matrix=none(int); matrix_s=none(string); transfer=none(int); transfer_s=none(string); primaries=none(int); primaries_s=none(string); range=none(int); range_s=none(string); chromaloc=none(int); chromaloc_s=none(string); matrix_in=none(int); matrix_in_s=none(string); transfer_in=none(int); transfer_in_s=none(string); primaries_in=none(int); primaries_in_s=none(string); range_in=none(int); range_in_s=none(string); chromaloc_in=none(int); chromaloc_in_s=none(string); filter_param_a=none(float); filter_param_b=none(float); resample_filter_uv=none(string); filter_param_a_uv=none(float); filter_param_b_uv=none(float); dither_type=none(string); cpu_type=none(string); prefer_props=none(int); src_left=none(float); src_top=none(float); src_width=none(float); src_height=none(float); nominal_luminance=none(float)):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.resize")
  if plug == nil:
    raise newException(ValueError, "plugin \"resize\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq    # Convert the VSMap into a sequence
  if tmpSeq.len == 0:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()
  args.append("clip", clip)
  if width.isSome: args.append("width", width.get)
  if height.isSome: args.append("height", height.get)
  if format.isSome: args.append("format", format.get)
  if matrix.isSome: args.append("matrix", matrix.get)
  if matrix_s.isSome: args.append("matrix_s", matrix_s.get)
  if transfer.isSome: args.append("transfer", transfer.get)
  if transfer_s.isSome: args.append("transfer_s", transfer_s.get)
  if primaries.isSome: args.append("primaries", primaries.get)
  if primaries_s.isSome: args.append("primaries_s", primaries_s.get)
  if range.isSome: args.append("range", range.get)
  if range_s.isSome: args.append("range_s", range_s.get)
  if chromaloc.isSome: args.append("chromaloc", chromaloc.get)
  if chromaloc_s.isSome: args.append("chromaloc_s", chromaloc_s.get)
  if matrix_in.isSome: args.append("matrix_in", matrix_in.get)
  if matrix_in_s.isSome: args.append("matrix_in_s", matrix_in_s.get)
  if transfer_in.isSome: args.append("transfer_in", transfer_in.get)
  if transfer_in_s.isSome: args.append("transfer_in_s", transfer_in_s.get)
  if primaries_in.isSome: args.append("primaries_in", primaries_in.get)
  if primaries_in_s.isSome: args.append("primaries_in_s", primaries_in_s.get)
  if range_in.isSome: args.append("range_in", range_in.get)
  if range_in_s.isSome: args.append("range_in_s", range_in_s.get)
  if chromaloc_in.isSome: args.append("chromaloc_in", chromaloc_in.get)
  if chromaloc_in_s.isSome: args.append("chromaloc_in_s", chromaloc_in_s.get)
  if filter_param_a.isSome: args.append("filter_param_a", filter_param_a.get)
  if filter_param_b.isSome: args.append("filter_param_b", filter_param_b.get)
  if resample_filter_uv.isSome: args.append("resample_filter_uv", resample_filter_uv.get)
  if filter_param_a_uv.isSome: args.append("filter_param_a_uv", filter_param_a_uv.get)
  if filter_param_b_uv.isSome: args.append("filter_param_b_uv", filter_param_b_uv.get)
  if dither_type.isSome: args.append("dither_type", dither_type.get)
  if cpu_type.isSome: args.append("cpu_type", cpu_type.get)
  if prefer_props.isSome: args.append("prefer_props", prefer_props.get)
  if src_left.isSome: args.append("src_left", src_left.get)
  if src_top.isSome: args.append("src_top", src_top.get)
  if src_width.isSome: args.append("src_width", src_width.get)
  if src_height.isSome: args.append("src_height", src_height.get)
  if nominal_luminance.isSome: args.append("nominal_luminance", nominal_luminance.get)

  return API.invoke(plug, "Point".cstring, args)        

proc Spline16*(vsmap:ptr VSMap; width=none(int); height=none(int); format=none(int); matrix=none(int); matrix_s=none(string); transfer=none(int); transfer_s=none(string); primaries=none(int); primaries_s=none(string); range=none(int); range_s=none(string); chromaloc=none(int); chromaloc_s=none(string); matrix_in=none(int); matrix_in_s=none(string); transfer_in=none(int); transfer_in_s=none(string); primaries_in=none(int); primaries_in_s=none(string); range_in=none(int); range_in_s=none(string); chromaloc_in=none(int); chromaloc_in_s=none(string); filter_param_a=none(float); filter_param_b=none(float); resample_filter_uv=none(string); filter_param_a_uv=none(float); filter_param_b_uv=none(float); dither_type=none(string); cpu_type=none(string); prefer_props=none(int); src_left=none(float); src_top=none(float); src_width=none(float); src_height=none(float); nominal_luminance=none(float)):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.resize")
  if plug == nil:
    raise newException(ValueError, "plugin \"resize\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq    # Convert the VSMap into a sequence
  if tmpSeq.len == 0:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()
  args.append("clip", clip)
  if width.isSome: args.append("width", width.get)
  if height.isSome: args.append("height", height.get)
  if format.isSome: args.append("format", format.get)
  if matrix.isSome: args.append("matrix", matrix.get)
  if matrix_s.isSome: args.append("matrix_s", matrix_s.get)
  if transfer.isSome: args.append("transfer", transfer.get)
  if transfer_s.isSome: args.append("transfer_s", transfer_s.get)
  if primaries.isSome: args.append("primaries", primaries.get)
  if primaries_s.isSome: args.append("primaries_s", primaries_s.get)
  if range.isSome: args.append("range", range.get)
  if range_s.isSome: args.append("range_s", range_s.get)
  if chromaloc.isSome: args.append("chromaloc", chromaloc.get)
  if chromaloc_s.isSome: args.append("chromaloc_s", chromaloc_s.get)
  if matrix_in.isSome: args.append("matrix_in", matrix_in.get)
  if matrix_in_s.isSome: args.append("matrix_in_s", matrix_in_s.get)
  if transfer_in.isSome: args.append("transfer_in", transfer_in.get)
  if transfer_in_s.isSome: args.append("transfer_in_s", transfer_in_s.get)
  if primaries_in.isSome: args.append("primaries_in", primaries_in.get)
  if primaries_in_s.isSome: args.append("primaries_in_s", primaries_in_s.get)
  if range_in.isSome: args.append("range_in", range_in.get)
  if range_in_s.isSome: args.append("range_in_s", range_in_s.get)
  if chromaloc_in.isSome: args.append("chromaloc_in", chromaloc_in.get)
  if chromaloc_in_s.isSome: args.append("chromaloc_in_s", chromaloc_in_s.get)
  if filter_param_a.isSome: args.append("filter_param_a", filter_param_a.get)
  if filter_param_b.isSome: args.append("filter_param_b", filter_param_b.get)
  if resample_filter_uv.isSome: args.append("resample_filter_uv", resample_filter_uv.get)
  if filter_param_a_uv.isSome: args.append("filter_param_a_uv", filter_param_a_uv.get)
  if filter_param_b_uv.isSome: args.append("filter_param_b_uv", filter_param_b_uv.get)
  if dither_type.isSome: args.append("dither_type", dither_type.get)
  if cpu_type.isSome: args.append("cpu_type", cpu_type.get)
  if prefer_props.isSome: args.append("prefer_props", prefer_props.get)
  if src_left.isSome: args.append("src_left", src_left.get)
  if src_top.isSome: args.append("src_top", src_top.get)
  if src_width.isSome: args.append("src_width", src_width.get)
  if src_height.isSome: args.append("src_height", src_height.get)
  if nominal_luminance.isSome: args.append("nominal_luminance", nominal_luminance.get)

  return API.invoke(plug, "Spline16".cstring, args)        

proc Spline36*(vsmap:ptr VSMap; width=none(int); height=none(int); format=none(int); matrix=none(int); matrix_s=none(string); transfer=none(int); transfer_s=none(string); primaries=none(int); primaries_s=none(string); range=none(int); range_s=none(string); chromaloc=none(int); chromaloc_s=none(string); matrix_in=none(int); matrix_in_s=none(string); transfer_in=none(int); transfer_in_s=none(string); primaries_in=none(int); primaries_in_s=none(string); range_in=none(int); range_in_s=none(string); chromaloc_in=none(int); chromaloc_in_s=none(string); filter_param_a=none(float); filter_param_b=none(float); resample_filter_uv=none(string); filter_param_a_uv=none(float); filter_param_b_uv=none(float); dither_type=none(string); cpu_type=none(string); prefer_props=none(int); src_left=none(float); src_top=none(float); src_width=none(float); src_height=none(float); nominal_luminance=none(float)):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.resize")
  if plug == nil:
    raise newException(ValueError, "plugin \"resize\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq    # Convert the VSMap into a sequence
  if tmpSeq.len == 0:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()
  args.append("clip", clip)
  if width.isSome: args.append("width", width.get)
  if height.isSome: args.append("height", height.get)
  if format.isSome: args.append("format", format.get)
  if matrix.isSome: args.append("matrix", matrix.get)
  if matrix_s.isSome: args.append("matrix_s", matrix_s.get)
  if transfer.isSome: args.append("transfer", transfer.get)
  if transfer_s.isSome: args.append("transfer_s", transfer_s.get)
  if primaries.isSome: args.append("primaries", primaries.get)
  if primaries_s.isSome: args.append("primaries_s", primaries_s.get)
  if range.isSome: args.append("range", range.get)
  if range_s.isSome: args.append("range_s", range_s.get)
  if chromaloc.isSome: args.append("chromaloc", chromaloc.get)
  if chromaloc_s.isSome: args.append("chromaloc_s", chromaloc_s.get)
  if matrix_in.isSome: args.append("matrix_in", matrix_in.get)
  if matrix_in_s.isSome: args.append("matrix_in_s", matrix_in_s.get)
  if transfer_in.isSome: args.append("transfer_in", transfer_in.get)
  if transfer_in_s.isSome: args.append("transfer_in_s", transfer_in_s.get)
  if primaries_in.isSome: args.append("primaries_in", primaries_in.get)
  if primaries_in_s.isSome: args.append("primaries_in_s", primaries_in_s.get)
  if range_in.isSome: args.append("range_in", range_in.get)
  if range_in_s.isSome: args.append("range_in_s", range_in_s.get)
  if chromaloc_in.isSome: args.append("chromaloc_in", chromaloc_in.get)
  if chromaloc_in_s.isSome: args.append("chromaloc_in_s", chromaloc_in_s.get)
  if filter_param_a.isSome: args.append("filter_param_a", filter_param_a.get)
  if filter_param_b.isSome: args.append("filter_param_b", filter_param_b.get)
  if resample_filter_uv.isSome: args.append("resample_filter_uv", resample_filter_uv.get)
  if filter_param_a_uv.isSome: args.append("filter_param_a_uv", filter_param_a_uv.get)
  if filter_param_b_uv.isSome: args.append("filter_param_b_uv", filter_param_b_uv.get)
  if dither_type.isSome: args.append("dither_type", dither_type.get)
  if cpu_type.isSome: args.append("cpu_type", cpu_type.get)
  if prefer_props.isSome: args.append("prefer_props", prefer_props.get)
  if src_left.isSome: args.append("src_left", src_left.get)
  if src_top.isSome: args.append("src_top", src_top.get)
  if src_width.isSome: args.append("src_width", src_width.get)
  if src_height.isSome: args.append("src_height", src_height.get)
  if nominal_luminance.isSome: args.append("nominal_luminance", nominal_luminance.get)

  return API.invoke(plug, "Spline36".cstring, args)        

