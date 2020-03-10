import VapourSynthWrapper, strformat, strutils

let API = getVapourSynthAPI(3)
let CORE = API.createCore(0)
#[
proc getVesionString():cstring = API.getCoreInfo( CORE ).versionString
proc getCore():int = API.getCoreInfo( CORE ).core.int
proc getApi():int = API.getCoreInfo( CORE ).api.int
proc getNumThreads():int = API.getCoreInfo( CORE ).numThreads.int
proc getMaxFramebufferSize():int = API.getCoreInfo( CORE ).maxFramebufferSize.int
proc getUsedFramebufferSize():int = API.getCoreInfo( CORE ).usedFramebufferSize.int
]#

include "vsmap.nim"
include "vsplugins.nim"


proc showPlugins() =
  let plugins = getPlugins()
  for plugin in plugins:
    echo ""
    echo fmt"Plugin: {plugin.id} ({plugin.namespace})"
    echo fmt"  Description: {plugin.description}"
    echo fmt"  Functions:"
    for f in plugin.functions:
      echo fmt"    Name     : {f.name}"
      echo fmt"    Arguments: "
      for arg in f.args:
        echo "       ", arg

proc convertType(`type`:string):string =
  result = case `type`:
           of "int[]":
             "seq[int]"
           of "float[]":
             "seq[float]"
           of "data":
             "string" 
           of "clip":
             "ptr VSNodeRef"
           else:
             `type`
    

proc gen_functions():seq[ tuple[key:string,source:string] ] =
  let plugins = getPlugins()
  var plugins_list:seq[tuple[key:string,source:string]]
  
  for plugin in plugins:
    var source = ""
    for f in plugin.functions:
      var flag = false
      var args = ""
      var map = ""
      
      for arg in f.args:
        if flag:
          if arg.len == 2:
            args &= ", "
          elif arg.len == 3:
            args &= "; "        
        flag = true      
        let newtype = convertType(arg[1])
        if arg.len == 2:
          args &= &"{arg[0]}:{newtype}"
        elif arg.len == 3:
          args &= &"{arg[0]}=none({newtype})"

        # We create the map
        let funcName = case newtype:
                       of "int":
                         "propSetInt"
                       of "seq[int]":
                         "propSetIntArray"
                       of "float":
                         "propSetFloat"
                       of "seq[float]":
                         "propSetFloatArray"
                       of "string":
                         "propSetData"
                       of "ptr VSNodeRef":
                         "propSetNode"
                       else:
                         ""
        
        if arg.len == 2:
          map &= &"  {funcName}(args, \"{arg[0]}\", {arg[0]}, paAppend)\n"
        elif arg.len == 3:
          map &= &"  if {arg[0]}.isSome:\n"   # if track.isSome:
          map &= &"    {funcName}(args, \"{arg[0]}\", {arg[0]}.get, paAppend)\n"

      source &= fmt"""
proc {f.name}({args}):ptr VSMap =
  let plug = getPluginById("{plugin.namespace}")
  let args = createMap()
{map}
  return API.invoke(plug, "{f.name}".cstring, args)        

"""
    plugins_list &= (plugin.id, source)
  return plugins_list


#[
macro gen_function(plugin, functionName:untyped):untyped =
  #let functionName = arg[0]
  #let plugin = arg[1]
  #let pluginNameSpace = strVal(plugin)
  let source = quote do:
    proc `functionName`():ptr VSMap =
      let plug = getPluginById("`plugin`")
      let args = createMap()
      return API.invoke(plug, "`functionName`".cstring, args)
  
  return source
]#


type
  Param = object
    name:string
    kind:string
    opt:bool


when isMainModule: 
  import os
  #showPlugins()
  os.createDir("./plugins")
  
  #var tmp = "import options\n\n"
  let sources = gen_functions()

  var includes = "import options\n\n"
  for s in  sources:
    includes &= &"include \"{s.key}.nim\"\n"
    let name = &"./plugins/{s.key}.nim"
    writeFile(name, s.source)
    echo "Written file: ",name

  writeFile("./plugins/all_plugins.nim", includes)
  echo "Written file: ", "./plugins/all_plugins.nim" 
  #echo tmp
  #echo repr tmp

  #let vsmap = SetLogLevel(1)
  #let vsmap = Source("grb_2.mkv")
