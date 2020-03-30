proc Hqdn3d*(vsmap:ptr VSMap; lum_spac=none(float); chrom_spac=none(float); lum_tmp=none(float); chrom_tmp=none(float); restart_lap=none(int)):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.hqdn3d")
  if plug == nil:
    raise newException(ValueError, "plugin \"hqdn3d\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq    # Convert the VSMap into a sequence
  if tmpSeq.len == 0:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


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

