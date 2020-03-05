import VapourSynthWrapper

#proc vsapi_init() =

type
  VS = object
    vsapi:   ptr VSAPI 
    coreptr: ptr VSCore

proc init(version:int=3, core:int=0):VS =
  let vsapi   = getVapourSynthAPI(version.cint)
  let coreptr = vsapi.createCore(core.cint)
  return VS( vsapi:vsapi, 
                coreptr:coreptr)



#[
proc vsmap2seq(vsmap:VSMap):seq =
  var n = vsapi.propNumKeys( vsmap )
  echo n

type
  CoreInfo* = object 
    versionString*: string
    core*: int
    api*: int
    numThreads*: int
    maxFramebufferSize*: int64
    usedFramebufferSize*: int64
]#
proc getVesionString(this:VS):cstring = this.vsapi.getCoreInfo( this.coreptr ).versionString
proc getCore(this:VS):int = this.vsapi.getCoreInfo( this.coreptr ).core.int
proc getApi(this:VS):int = this.vsapi.getCoreInfo( this.coreptr ).api.int
proc getNumThreads(this:VS):int = this.vsapi.getCoreInfo( this.coreptr ).numThreads.int
proc getMaxFramebufferSize(this:VS):int = this.vsapi.getCoreInfo( this.coreptr ).maxFramebufferSize.int
proc getUsedFramebufferSize(this:VS):int = this.vsapi.getCoreInfo( this.coreptr ).usedFramebufferSize.int

include "vsmap.nim"

when isMainModule:
  #let vsapi:VSapi = getVapourSynthAPI(3)
  #let coreptr = vsapi.createCore(0)
  let vsapi:VS = init(3,0)
  
  var vsmap = vsapi.vsapi.getPlugins( vsapi.coreptr )
  echo repr(vsmap)
  echo vsapi.propNumKeys(vsmap)
  #echo repr(vsapi)
  #echo repr(coreptr)
  
  #[
  let coreinfo = vsapi.vsapi.getCoreInfo( vsapi.coreptr )
  echo repr(coreinfo)
  echo vsapi.getVesionString()  
  echo vsapi.getCore()
  echo vsapi.getApi()
  echo vsapi.getNumThreads()  
  echo vsapi.getMaxFramebufferSize()     
  echo vsapi.getUsedFramebufferSize()  
  ]#

  #
  #echo repr tmp
  #vsmap2seq(vsmap)
  