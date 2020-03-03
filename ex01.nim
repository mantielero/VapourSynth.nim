import VapourSynthWrapper


when isMainModule:
  const vsapi = VSGetVapourSynthAPI(3)
  echo repr(vsapi)