proc Hqdn3d*(vsmap:ptr VSMap; lum_spac= none(float); chrom_spac= none(float); lum_tmp= none(float); chrom_tmp= none(float); restart_lap= none(int)):ptr VSMap =

  let plug = getPluginById("com.vapoursynth.hqdn3d")
  assert( plug != nil, "plugin \"com.vapoursynth.hqdn3d\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("clip") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()
  args.append("clip", clip)
  if lum_spac.isSome: args.append("lum_spac", lum_spac.get)
  if chrom_spac.isSome: args.append("chrom_spac", chrom_spac.get)
  if lum_tmp.isSome: args.append("lum_tmp", lum_tmp.get)
  if chrom_tmp.isSome: args.append("chrom_tmp", chrom_tmp.get)
  if restart_lap.isSome: args.append("restart_lap", restart_lap.get)

  result = API.invoke(plug, "Hqdn3d".cstring, args)
  API.freeMap(args)


