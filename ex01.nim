import VapourSynthWrapper, strformat, strutils

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
include "plugins.nim"

when isMainModule:
  #let vsapi:VSapi = getVapourSynthAPI(3)
  #let coreptr = vsapi.createCore(0)
  let vsapi:VS = init(3,0)
  
  var vsmap = vsapi.vsapi.getPlugins( vsapi.coreptr )
  echo repr(vsmap)
  echo vsapi.propNumKeys(vsmap)

  var pluginName = vsapi.propGetKey(vsmap, 10)
  var pluginType = vsapi.propGetType(vsmap, pluginName)
  var nElems = vsapi.propNumElements(vsmap, pluginName)
  echo nElems
  echo vsapi.propGetData(vsmap, pluginName, 0, nil)
  echo vsapi.propGetDataSize(vsmap, pluginName, 0, nil)


  #
  echo "PRINTING PLUGINS"
  for i in 0..<vsapi.propNumKeys(vsmap):
    echo fmt"  PLUGIN #{i}"
    var name = vsapi.propGetKey(vsmap, i)
    var t = vsapi.propGetType(vsmap, name)
    var nElems = vsapi.propNumElements(vsmap, name)
    echo fmt"     Name: {name}"
    echo fmt"     Tipo: {t}"
    echo fmt"     N elems.: {nElems}"
    for j in 0..<nElems:
      var data = vsapi.propGetData(vsmap, name, 0, nil)
      echo fmt"        Data: {data}"
      #var data1:string = $data
      var fields = data.split(";")
      for item in fields:
        echo fmt"           {item}"
      var plugin = vsapi.getPluginById(fields[1])
      #echo repr(plugin)
      var funciones = vsapi.getFunctions(plugin)
      var nFunciones = vsapi.propNumKeys(funciones)
      for k in 0..<nFunciones:
        var funcionName = vsapi.propGetKey(funciones, k)
        echo fmt"             Function name: {funcionName}"
      #echo tmp
  # https://github.com/mantielero/VapourSynth.jl/blob/3903bfe492456e2c2e094db2ee940058805f3663/src/vsmodules.jl
  # getpluginfunctions





  #echo repr(VSPropTypes(pluginType))
  #echo ptData

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
  