proc Bicubic(clip:ptr VSNodeRef; width=none(int); height=none(int); format=none(int); matrix=none(int); matrix_s=none(string); transfer=none(int); transfer_s=none(string); primaries=none(int); primaries_s=none(string); range=none(int); range_s=none(string); chromaloc=none(int); chromaloc_s=none(string); matrix_in=none(int); matrix_in_s=none(string); transfer_in=none(int); transfer_in_s=none(string); primaries_in=none(int); primaries_in_s=none(string); range_in=none(int); range_in_s=none(string); chromaloc_in=none(int); chromaloc_in_s=none(string); filter_param_a=none(float); filter_param_b=none(float); resample_filter_uv=none(string); filter_param_a_uv=none(float); filter_param_b_uv=none(float); dither_type=none(string); cpu_type=none(string); prefer_props=none(int); src_left=none(float); src_top=none(float); src_width=none(float); src_height=none(float); nominal_luminance=none(float)):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.resize")
  let args = createMap()
  propSetNode(args, "clip", clip, paAppend)
  if width.isSome:
    propSetInt(args, "width", width.get, paAppend)
  if height.isSome:
    propSetInt(args, "height", height.get, paAppend)
  if format.isSome:
    propSetInt(args, "format", format.get, paAppend)
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
  if range.isSome:
    propSetInt(args, "range", range.get, paAppend)
  if range_s.isSome:
    propSetData(args, "range_s", range_s.get, paAppend)
  if chromaloc.isSome:
    propSetInt(args, "chromaloc", chromaloc.get, paAppend)
  if chromaloc_s.isSome:
    propSetData(args, "chromaloc_s", chromaloc_s.get, paAppend)
  if matrix_in.isSome:
    propSetInt(args, "matrix_in", matrix_in.get, paAppend)
  if matrix_in_s.isSome:
    propSetData(args, "matrix_in_s", matrix_in_s.get, paAppend)
  if transfer_in.isSome:
    propSetInt(args, "transfer_in", transfer_in.get, paAppend)
  if transfer_in_s.isSome:
    propSetData(args, "transfer_in_s", transfer_in_s.get, paAppend)
  if primaries_in.isSome:
    propSetInt(args, "primaries_in", primaries_in.get, paAppend)
  if primaries_in_s.isSome:
    propSetData(args, "primaries_in_s", primaries_in_s.get, paAppend)
  if range_in.isSome:
    propSetInt(args, "range_in", range_in.get, paAppend)
  if range_in_s.isSome:
    propSetData(args, "range_in_s", range_in_s.get, paAppend)
  if chromaloc_in.isSome:
    propSetInt(args, "chromaloc_in", chromaloc_in.get, paAppend)
  if chromaloc_in_s.isSome:
    propSetData(args, "chromaloc_in_s", chromaloc_in_s.get, paAppend)
  if filter_param_a.isSome:
    propSetFloat(args, "filter_param_a", filter_param_a.get, paAppend)
  if filter_param_b.isSome:
    propSetFloat(args, "filter_param_b", filter_param_b.get, paAppend)
  if resample_filter_uv.isSome:
    propSetData(args, "resample_filter_uv", resample_filter_uv.get, paAppend)
  if filter_param_a_uv.isSome:
    propSetFloat(args, "filter_param_a_uv", filter_param_a_uv.get, paAppend)
  if filter_param_b_uv.isSome:
    propSetFloat(args, "filter_param_b_uv", filter_param_b_uv.get, paAppend)
  if dither_type.isSome:
    propSetData(args, "dither_type", dither_type.get, paAppend)
  if cpu_type.isSome:
    propSetData(args, "cpu_type", cpu_type.get, paAppend)
  if prefer_props.isSome:
    propSetInt(args, "prefer_props", prefer_props.get, paAppend)
  if src_left.isSome:
    propSetFloat(args, "src_left", src_left.get, paAppend)
  if src_top.isSome:
    propSetFloat(args, "src_top", src_top.get, paAppend)
  if src_width.isSome:
    propSetFloat(args, "src_width", src_width.get, paAppend)
  if src_height.isSome:
    propSetFloat(args, "src_height", src_height.get, paAppend)
  if nominal_luminance.isSome:
    propSetFloat(args, "nominal_luminance", nominal_luminance.get, paAppend)

  return API.invoke(plug, "Bicubic".cstring, args)        

proc Bilinear(clip:ptr VSNodeRef; width=none(int); height=none(int); format=none(int); matrix=none(int); matrix_s=none(string); transfer=none(int); transfer_s=none(string); primaries=none(int); primaries_s=none(string); range=none(int); range_s=none(string); chromaloc=none(int); chromaloc_s=none(string); matrix_in=none(int); matrix_in_s=none(string); transfer_in=none(int); transfer_in_s=none(string); primaries_in=none(int); primaries_in_s=none(string); range_in=none(int); range_in_s=none(string); chromaloc_in=none(int); chromaloc_in_s=none(string); filter_param_a=none(float); filter_param_b=none(float); resample_filter_uv=none(string); filter_param_a_uv=none(float); filter_param_b_uv=none(float); dither_type=none(string); cpu_type=none(string); prefer_props=none(int); src_left=none(float); src_top=none(float); src_width=none(float); src_height=none(float); nominal_luminance=none(float)):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.resize")
  let args = createMap()
  propSetNode(args, "clip", clip, paAppend)
  if width.isSome:
    propSetInt(args, "width", width.get, paAppend)
  if height.isSome:
    propSetInt(args, "height", height.get, paAppend)
  if format.isSome:
    propSetInt(args, "format", format.get, paAppend)
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
  if range.isSome:
    propSetInt(args, "range", range.get, paAppend)
  if range_s.isSome:
    propSetData(args, "range_s", range_s.get, paAppend)
  if chromaloc.isSome:
    propSetInt(args, "chromaloc", chromaloc.get, paAppend)
  if chromaloc_s.isSome:
    propSetData(args, "chromaloc_s", chromaloc_s.get, paAppend)
  if matrix_in.isSome:
    propSetInt(args, "matrix_in", matrix_in.get, paAppend)
  if matrix_in_s.isSome:
    propSetData(args, "matrix_in_s", matrix_in_s.get, paAppend)
  if transfer_in.isSome:
    propSetInt(args, "transfer_in", transfer_in.get, paAppend)
  if transfer_in_s.isSome:
    propSetData(args, "transfer_in_s", transfer_in_s.get, paAppend)
  if primaries_in.isSome:
    propSetInt(args, "primaries_in", primaries_in.get, paAppend)
  if primaries_in_s.isSome:
    propSetData(args, "primaries_in_s", primaries_in_s.get, paAppend)
  if range_in.isSome:
    propSetInt(args, "range_in", range_in.get, paAppend)
  if range_in_s.isSome:
    propSetData(args, "range_in_s", range_in_s.get, paAppend)
  if chromaloc_in.isSome:
    propSetInt(args, "chromaloc_in", chromaloc_in.get, paAppend)
  if chromaloc_in_s.isSome:
    propSetData(args, "chromaloc_in_s", chromaloc_in_s.get, paAppend)
  if filter_param_a.isSome:
    propSetFloat(args, "filter_param_a", filter_param_a.get, paAppend)
  if filter_param_b.isSome:
    propSetFloat(args, "filter_param_b", filter_param_b.get, paAppend)
  if resample_filter_uv.isSome:
    propSetData(args, "resample_filter_uv", resample_filter_uv.get, paAppend)
  if filter_param_a_uv.isSome:
    propSetFloat(args, "filter_param_a_uv", filter_param_a_uv.get, paAppend)
  if filter_param_b_uv.isSome:
    propSetFloat(args, "filter_param_b_uv", filter_param_b_uv.get, paAppend)
  if dither_type.isSome:
    propSetData(args, "dither_type", dither_type.get, paAppend)
  if cpu_type.isSome:
    propSetData(args, "cpu_type", cpu_type.get, paAppend)
  if prefer_props.isSome:
    propSetInt(args, "prefer_props", prefer_props.get, paAppend)
  if src_left.isSome:
    propSetFloat(args, "src_left", src_left.get, paAppend)
  if src_top.isSome:
    propSetFloat(args, "src_top", src_top.get, paAppend)
  if src_width.isSome:
    propSetFloat(args, "src_width", src_width.get, paAppend)
  if src_height.isSome:
    propSetFloat(args, "src_height", src_height.get, paAppend)
  if nominal_luminance.isSome:
    propSetFloat(args, "nominal_luminance", nominal_luminance.get, paAppend)

  return API.invoke(plug, "Bilinear".cstring, args)        

proc Lanczos(clip:ptr VSNodeRef; width=none(int); height=none(int); format=none(int); matrix=none(int); matrix_s=none(string); transfer=none(int); transfer_s=none(string); primaries=none(int); primaries_s=none(string); range=none(int); range_s=none(string); chromaloc=none(int); chromaloc_s=none(string); matrix_in=none(int); matrix_in_s=none(string); transfer_in=none(int); transfer_in_s=none(string); primaries_in=none(int); primaries_in_s=none(string); range_in=none(int); range_in_s=none(string); chromaloc_in=none(int); chromaloc_in_s=none(string); filter_param_a=none(float); filter_param_b=none(float); resample_filter_uv=none(string); filter_param_a_uv=none(float); filter_param_b_uv=none(float); dither_type=none(string); cpu_type=none(string); prefer_props=none(int); src_left=none(float); src_top=none(float); src_width=none(float); src_height=none(float); nominal_luminance=none(float)):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.resize")
  let args = createMap()
  propSetNode(args, "clip", clip, paAppend)
  if width.isSome:
    propSetInt(args, "width", width.get, paAppend)
  if height.isSome:
    propSetInt(args, "height", height.get, paAppend)
  if format.isSome:
    propSetInt(args, "format", format.get, paAppend)
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
  if range.isSome:
    propSetInt(args, "range", range.get, paAppend)
  if range_s.isSome:
    propSetData(args, "range_s", range_s.get, paAppend)
  if chromaloc.isSome:
    propSetInt(args, "chromaloc", chromaloc.get, paAppend)
  if chromaloc_s.isSome:
    propSetData(args, "chromaloc_s", chromaloc_s.get, paAppend)
  if matrix_in.isSome:
    propSetInt(args, "matrix_in", matrix_in.get, paAppend)
  if matrix_in_s.isSome:
    propSetData(args, "matrix_in_s", matrix_in_s.get, paAppend)
  if transfer_in.isSome:
    propSetInt(args, "transfer_in", transfer_in.get, paAppend)
  if transfer_in_s.isSome:
    propSetData(args, "transfer_in_s", transfer_in_s.get, paAppend)
  if primaries_in.isSome:
    propSetInt(args, "primaries_in", primaries_in.get, paAppend)
  if primaries_in_s.isSome:
    propSetData(args, "primaries_in_s", primaries_in_s.get, paAppend)
  if range_in.isSome:
    propSetInt(args, "range_in", range_in.get, paAppend)
  if range_in_s.isSome:
    propSetData(args, "range_in_s", range_in_s.get, paAppend)
  if chromaloc_in.isSome:
    propSetInt(args, "chromaloc_in", chromaloc_in.get, paAppend)
  if chromaloc_in_s.isSome:
    propSetData(args, "chromaloc_in_s", chromaloc_in_s.get, paAppend)
  if filter_param_a.isSome:
    propSetFloat(args, "filter_param_a", filter_param_a.get, paAppend)
  if filter_param_b.isSome:
    propSetFloat(args, "filter_param_b", filter_param_b.get, paAppend)
  if resample_filter_uv.isSome:
    propSetData(args, "resample_filter_uv", resample_filter_uv.get, paAppend)
  if filter_param_a_uv.isSome:
    propSetFloat(args, "filter_param_a_uv", filter_param_a_uv.get, paAppend)
  if filter_param_b_uv.isSome:
    propSetFloat(args, "filter_param_b_uv", filter_param_b_uv.get, paAppend)
  if dither_type.isSome:
    propSetData(args, "dither_type", dither_type.get, paAppend)
  if cpu_type.isSome:
    propSetData(args, "cpu_type", cpu_type.get, paAppend)
  if prefer_props.isSome:
    propSetInt(args, "prefer_props", prefer_props.get, paAppend)
  if src_left.isSome:
    propSetFloat(args, "src_left", src_left.get, paAppend)
  if src_top.isSome:
    propSetFloat(args, "src_top", src_top.get, paAppend)
  if src_width.isSome:
    propSetFloat(args, "src_width", src_width.get, paAppend)
  if src_height.isSome:
    propSetFloat(args, "src_height", src_height.get, paAppend)
  if nominal_luminance.isSome:
    propSetFloat(args, "nominal_luminance", nominal_luminance.get, paAppend)

  return API.invoke(plug, "Lanczos".cstring, args)        

proc Point(clip:ptr VSNodeRef; width=none(int); height=none(int); format=none(int); matrix=none(int); matrix_s=none(string); transfer=none(int); transfer_s=none(string); primaries=none(int); primaries_s=none(string); range=none(int); range_s=none(string); chromaloc=none(int); chromaloc_s=none(string); matrix_in=none(int); matrix_in_s=none(string); transfer_in=none(int); transfer_in_s=none(string); primaries_in=none(int); primaries_in_s=none(string); range_in=none(int); range_in_s=none(string); chromaloc_in=none(int); chromaloc_in_s=none(string); filter_param_a=none(float); filter_param_b=none(float); resample_filter_uv=none(string); filter_param_a_uv=none(float); filter_param_b_uv=none(float); dither_type=none(string); cpu_type=none(string); prefer_props=none(int); src_left=none(float); src_top=none(float); src_width=none(float); src_height=none(float); nominal_luminance=none(float)):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.resize")
  let args = createMap()
  propSetNode(args, "clip", clip, paAppend)
  if width.isSome:
    propSetInt(args, "width", width.get, paAppend)
  if height.isSome:
    propSetInt(args, "height", height.get, paAppend)
  if format.isSome:
    propSetInt(args, "format", format.get, paAppend)
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
  if range.isSome:
    propSetInt(args, "range", range.get, paAppend)
  if range_s.isSome:
    propSetData(args, "range_s", range_s.get, paAppend)
  if chromaloc.isSome:
    propSetInt(args, "chromaloc", chromaloc.get, paAppend)
  if chromaloc_s.isSome:
    propSetData(args, "chromaloc_s", chromaloc_s.get, paAppend)
  if matrix_in.isSome:
    propSetInt(args, "matrix_in", matrix_in.get, paAppend)
  if matrix_in_s.isSome:
    propSetData(args, "matrix_in_s", matrix_in_s.get, paAppend)
  if transfer_in.isSome:
    propSetInt(args, "transfer_in", transfer_in.get, paAppend)
  if transfer_in_s.isSome:
    propSetData(args, "transfer_in_s", transfer_in_s.get, paAppend)
  if primaries_in.isSome:
    propSetInt(args, "primaries_in", primaries_in.get, paAppend)
  if primaries_in_s.isSome:
    propSetData(args, "primaries_in_s", primaries_in_s.get, paAppend)
  if range_in.isSome:
    propSetInt(args, "range_in", range_in.get, paAppend)
  if range_in_s.isSome:
    propSetData(args, "range_in_s", range_in_s.get, paAppend)
  if chromaloc_in.isSome:
    propSetInt(args, "chromaloc_in", chromaloc_in.get, paAppend)
  if chromaloc_in_s.isSome:
    propSetData(args, "chromaloc_in_s", chromaloc_in_s.get, paAppend)
  if filter_param_a.isSome:
    propSetFloat(args, "filter_param_a", filter_param_a.get, paAppend)
  if filter_param_b.isSome:
    propSetFloat(args, "filter_param_b", filter_param_b.get, paAppend)
  if resample_filter_uv.isSome:
    propSetData(args, "resample_filter_uv", resample_filter_uv.get, paAppend)
  if filter_param_a_uv.isSome:
    propSetFloat(args, "filter_param_a_uv", filter_param_a_uv.get, paAppend)
  if filter_param_b_uv.isSome:
    propSetFloat(args, "filter_param_b_uv", filter_param_b_uv.get, paAppend)
  if dither_type.isSome:
    propSetData(args, "dither_type", dither_type.get, paAppend)
  if cpu_type.isSome:
    propSetData(args, "cpu_type", cpu_type.get, paAppend)
  if prefer_props.isSome:
    propSetInt(args, "prefer_props", prefer_props.get, paAppend)
  if src_left.isSome:
    propSetFloat(args, "src_left", src_left.get, paAppend)
  if src_top.isSome:
    propSetFloat(args, "src_top", src_top.get, paAppend)
  if src_width.isSome:
    propSetFloat(args, "src_width", src_width.get, paAppend)
  if src_height.isSome:
    propSetFloat(args, "src_height", src_height.get, paAppend)
  if nominal_luminance.isSome:
    propSetFloat(args, "nominal_luminance", nominal_luminance.get, paAppend)

  return API.invoke(plug, "Point".cstring, args)        

proc Spline16(clip:ptr VSNodeRef; width=none(int); height=none(int); format=none(int); matrix=none(int); matrix_s=none(string); transfer=none(int); transfer_s=none(string); primaries=none(int); primaries_s=none(string); range=none(int); range_s=none(string); chromaloc=none(int); chromaloc_s=none(string); matrix_in=none(int); matrix_in_s=none(string); transfer_in=none(int); transfer_in_s=none(string); primaries_in=none(int); primaries_in_s=none(string); range_in=none(int); range_in_s=none(string); chromaloc_in=none(int); chromaloc_in_s=none(string); filter_param_a=none(float); filter_param_b=none(float); resample_filter_uv=none(string); filter_param_a_uv=none(float); filter_param_b_uv=none(float); dither_type=none(string); cpu_type=none(string); prefer_props=none(int); src_left=none(float); src_top=none(float); src_width=none(float); src_height=none(float); nominal_luminance=none(float)):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.resize")
  let args = createMap()
  propSetNode(args, "clip", clip, paAppend)
  if width.isSome:
    propSetInt(args, "width", width.get, paAppend)
  if height.isSome:
    propSetInt(args, "height", height.get, paAppend)
  if format.isSome:
    propSetInt(args, "format", format.get, paAppend)
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
  if range.isSome:
    propSetInt(args, "range", range.get, paAppend)
  if range_s.isSome:
    propSetData(args, "range_s", range_s.get, paAppend)
  if chromaloc.isSome:
    propSetInt(args, "chromaloc", chromaloc.get, paAppend)
  if chromaloc_s.isSome:
    propSetData(args, "chromaloc_s", chromaloc_s.get, paAppend)
  if matrix_in.isSome:
    propSetInt(args, "matrix_in", matrix_in.get, paAppend)
  if matrix_in_s.isSome:
    propSetData(args, "matrix_in_s", matrix_in_s.get, paAppend)
  if transfer_in.isSome:
    propSetInt(args, "transfer_in", transfer_in.get, paAppend)
  if transfer_in_s.isSome:
    propSetData(args, "transfer_in_s", transfer_in_s.get, paAppend)
  if primaries_in.isSome:
    propSetInt(args, "primaries_in", primaries_in.get, paAppend)
  if primaries_in_s.isSome:
    propSetData(args, "primaries_in_s", primaries_in_s.get, paAppend)
  if range_in.isSome:
    propSetInt(args, "range_in", range_in.get, paAppend)
  if range_in_s.isSome:
    propSetData(args, "range_in_s", range_in_s.get, paAppend)
  if chromaloc_in.isSome:
    propSetInt(args, "chromaloc_in", chromaloc_in.get, paAppend)
  if chromaloc_in_s.isSome:
    propSetData(args, "chromaloc_in_s", chromaloc_in_s.get, paAppend)
  if filter_param_a.isSome:
    propSetFloat(args, "filter_param_a", filter_param_a.get, paAppend)
  if filter_param_b.isSome:
    propSetFloat(args, "filter_param_b", filter_param_b.get, paAppend)
  if resample_filter_uv.isSome:
    propSetData(args, "resample_filter_uv", resample_filter_uv.get, paAppend)
  if filter_param_a_uv.isSome:
    propSetFloat(args, "filter_param_a_uv", filter_param_a_uv.get, paAppend)
  if filter_param_b_uv.isSome:
    propSetFloat(args, "filter_param_b_uv", filter_param_b_uv.get, paAppend)
  if dither_type.isSome:
    propSetData(args, "dither_type", dither_type.get, paAppend)
  if cpu_type.isSome:
    propSetData(args, "cpu_type", cpu_type.get, paAppend)
  if prefer_props.isSome:
    propSetInt(args, "prefer_props", prefer_props.get, paAppend)
  if src_left.isSome:
    propSetFloat(args, "src_left", src_left.get, paAppend)
  if src_top.isSome:
    propSetFloat(args, "src_top", src_top.get, paAppend)
  if src_width.isSome:
    propSetFloat(args, "src_width", src_width.get, paAppend)
  if src_height.isSome:
    propSetFloat(args, "src_height", src_height.get, paAppend)
  if nominal_luminance.isSome:
    propSetFloat(args, "nominal_luminance", nominal_luminance.get, paAppend)

  return API.invoke(plug, "Spline16".cstring, args)        

proc Spline36(clip:ptr VSNodeRef; width=none(int); height=none(int); format=none(int); matrix=none(int); matrix_s=none(string); transfer=none(int); transfer_s=none(string); primaries=none(int); primaries_s=none(string); range=none(int); range_s=none(string); chromaloc=none(int); chromaloc_s=none(string); matrix_in=none(int); matrix_in_s=none(string); transfer_in=none(int); transfer_in_s=none(string); primaries_in=none(int); primaries_in_s=none(string); range_in=none(int); range_in_s=none(string); chromaloc_in=none(int); chromaloc_in_s=none(string); filter_param_a=none(float); filter_param_b=none(float); resample_filter_uv=none(string); filter_param_a_uv=none(float); filter_param_b_uv=none(float); dither_type=none(string); cpu_type=none(string); prefer_props=none(int); src_left=none(float); src_top=none(float); src_width=none(float); src_height=none(float); nominal_luminance=none(float)):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.resize")
  let args = createMap()
  propSetNode(args, "clip", clip, paAppend)
  if width.isSome:
    propSetInt(args, "width", width.get, paAppend)
  if height.isSome:
    propSetInt(args, "height", height.get, paAppend)
  if format.isSome:
    propSetInt(args, "format", format.get, paAppend)
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
  if range.isSome:
    propSetInt(args, "range", range.get, paAppend)
  if range_s.isSome:
    propSetData(args, "range_s", range_s.get, paAppend)
  if chromaloc.isSome:
    propSetInt(args, "chromaloc", chromaloc.get, paAppend)
  if chromaloc_s.isSome:
    propSetData(args, "chromaloc_s", chromaloc_s.get, paAppend)
  if matrix_in.isSome:
    propSetInt(args, "matrix_in", matrix_in.get, paAppend)
  if matrix_in_s.isSome:
    propSetData(args, "matrix_in_s", matrix_in_s.get, paAppend)
  if transfer_in.isSome:
    propSetInt(args, "transfer_in", transfer_in.get, paAppend)
  if transfer_in_s.isSome:
    propSetData(args, "transfer_in_s", transfer_in_s.get, paAppend)
  if primaries_in.isSome:
    propSetInt(args, "primaries_in", primaries_in.get, paAppend)
  if primaries_in_s.isSome:
    propSetData(args, "primaries_in_s", primaries_in_s.get, paAppend)
  if range_in.isSome:
    propSetInt(args, "range_in", range_in.get, paAppend)
  if range_in_s.isSome:
    propSetData(args, "range_in_s", range_in_s.get, paAppend)
  if chromaloc_in.isSome:
    propSetInt(args, "chromaloc_in", chromaloc_in.get, paAppend)
  if chromaloc_in_s.isSome:
    propSetData(args, "chromaloc_in_s", chromaloc_in_s.get, paAppend)
  if filter_param_a.isSome:
    propSetFloat(args, "filter_param_a", filter_param_a.get, paAppend)
  if filter_param_b.isSome:
    propSetFloat(args, "filter_param_b", filter_param_b.get, paAppend)
  if resample_filter_uv.isSome:
    propSetData(args, "resample_filter_uv", resample_filter_uv.get, paAppend)
  if filter_param_a_uv.isSome:
    propSetFloat(args, "filter_param_a_uv", filter_param_a_uv.get, paAppend)
  if filter_param_b_uv.isSome:
    propSetFloat(args, "filter_param_b_uv", filter_param_b_uv.get, paAppend)
  if dither_type.isSome:
    propSetData(args, "dither_type", dither_type.get, paAppend)
  if cpu_type.isSome:
    propSetData(args, "cpu_type", cpu_type.get, paAppend)
  if prefer_props.isSome:
    propSetInt(args, "prefer_props", prefer_props.get, paAppend)
  if src_left.isSome:
    propSetFloat(args, "src_left", src_left.get, paAppend)
  if src_top.isSome:
    propSetFloat(args, "src_top", src_top.get, paAppend)
  if src_width.isSome:
    propSetFloat(args, "src_width", src_width.get, paAppend)
  if src_height.isSome:
    propSetFloat(args, "src_height", src_height.get, paAppend)
  if nominal_luminance.isSome:
    propSetFloat(args, "nominal_luminance", nominal_luminance.get, paAppend)

  return API.invoke(plug, "Spline36".cstring, args)        

