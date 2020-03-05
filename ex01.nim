import VapourSynthWrapper


when isMainModule:
  let vsapi = getVapourSynthAPI(3)
  let coreptr = vsapi.createCore(0)
  #echo repr(vsapi)
  #echo repr(coreptr)
  let coreinfo = vsapi.getCoreInfo( coreptr )
  echo repr(coreinfo)
  