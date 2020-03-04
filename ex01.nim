import VapourSynthWrapper


when isMainModule:
  let vsapi = getVapourSynthAPI(3)
  echo repr(vsapi)
  