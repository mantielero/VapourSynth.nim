import VapourSynthWrapper


when isMainModule:
  let vsapi = VSGetVapourSynthAPI(3)
  echo repr(vsapi)
  