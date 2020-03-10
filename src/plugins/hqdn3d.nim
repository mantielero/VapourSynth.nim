proc Hqdn3d(clip:ptr VSNodeRef; lum_spac=none(float); chrom_spac=none(float); lum_tmp=none(float); chrom_tmp=none(float); restart_lap=none(int)):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.hqdn3d")
  let args = createMap()
  propSetNode(args, "clip", clip, paAppend)
  if lum_spac.isSome:
    propSetFloat(args, "lum_spac", lum_spac.get, paAppend)
  if chrom_spac.isSome:
    propSetFloat(args, "chrom_spac", chrom_spac.get, paAppend)
  if lum_tmp.isSome:
    propSetFloat(args, "lum_tmp", lum_tmp.get, paAppend)
  if chrom_tmp.isSome:
    propSetFloat(args, "chrom_tmp", chrom_tmp.get, paAppend)
  if restart_lap.isSome:
    propSetInt(args, "restart_lap", restart_lap.get, paAppend)

  return API.invoke(plug, "Hqdn3d".cstring, args)        

