#from vapoursynth4_wrapper import VSPlugin
import strutils
##[
Plugins
=======

Plugins are loaded and provide a number of functions. We need no make those functions available.

]##

#type
#  Function* = object
#    name*:string
#    args*:seq[seq[string]]
#[
  Plugin* = object
    id*:string
    namespace*:string
    description*:string
    functions*:seq[Function]
]#
proc getPluginById*(id:string):ptr VSPlugin = 
  API.getPluginById(id.cstring, CORE)

proc getPluginByNamespace*(namespace:string):ptr VSPlugin =
  API.getPluginByNamespace(namespace.cstring, CORE)


#proc(identifier:cstring, core:ptr VSCore):ptr VSPlugin 

#-------------- TO BE REPLACED
#proc getFunctions*(plugin:ptr VSPlugin):ptr VSMap = 
#  API.getFunctions(plugin)

type
  Plugins = ptr VSMap

#-------------- TO BE REPLACED
#proc getPlugins*():Plugins = API.getPlugins( CORE )

iterator plugins*():ptr VSPlugin =
  ## Iterate over all the plugins available in the system
  var plugin:ptr VSPlugin = API.getNextPlugin(nil, CORE )
  while plugin != nil:
    yield plugin
    plugin = API.getNextPlugin(plugin, CORE )

proc name*(plugin:ptr VSPlugin):string =
  $API.getPluginName(plugin)

proc id*(plugin:ptr VSPlugin):string =
  $API.getPluginID(plugin)

proc nameSpace*(plugin:ptr VSPlugin):string =
  $API.getPluginNamespace(plugin)

proc path*(plugin:ptr VSPlugin):string =
  $API.getPluginPath(plugin)

proc version*(plugin:ptr VSPlugin):int =
  API.getPluginVersion(plugin)




#------------------

iterator functions*(plugin:ptr VSPlugin):ptr VSPluginFunction =
  var function:ptr VSPluginFunction = API.getNextPluginFunction(nil, plugin )
  while function != nil:
    yield function
    function = API.getNextPluginFunction(function, plugin )  

proc name*(function:ptr VSPluginFunction):string =
  $API.getPluginFunctionName(function)

type
  Argument* = tuple[name:string, typ:string, optional:bool]

proc args*(function:ptr VSPluginFunction):seq[Argument] =
  var tmp = $API.getPluginFunctionArguments(function)
  # Arguments
  var args = tmp.split(';')
  if len(args) > 0:
    echo args[args.high]
    if args[args.high] == "":
      #var n = 
      args = args[0 .. args.high - 1]
  
  # Arguments details
  var newArgs:seq[Argument]
  for arg in args:
    var tmp = arg.split(':')
    if len(tmp) == 3:
      if tmp[2] == "opt":
        newArgs &= (tmp[0], tmp[1], true)
      else:
        echo "WARNING------------------------>", tmp[2]
    elif len(tmp) == 2:
      newArgs &= (tmp[0], tmp[1], false)
    else:
      if tmp[0] == "any":
        newArgs &= ("any", "any", false)
  return newArgs

proc ret*(function:ptr VSPluginFunction):string =
  $API.getPluginFunctionReturnType(function)


  #for item in plugins.items:
  #  for i in 0..<plugins.len(item): # Each item within a key
  #    let data = plugins.propGetData(item.key,i)
  #    let data_items = data.split(';')
  #    var tmp:Plugin
  #    tmp.namespace = data_items[0]
  #    tmp.id = data_items[1]
  #    tmp.description = data_items[2]
  #    yield tmp



#[
proc getPlugins*():seq[Plugin] = #:seq[ tuple[id:string,namespace:string,description:string, functions:seq[tuple[funcname:string, args:seq[seq[string]]] ]] ]   =
  # http://www.vapoursynth.com/doc/api/vapoursynth.h.html#getplugins
  # http://www.vapoursynth.com/doc/api/vapoursynth.h.html#getfunctions
  # http://www.vapoursynth.com/doc/api/vapoursynth.h.html#getpluginbyid
  let plugins:ptr VSMap = API.getPlugins( CORE ) #.toSeq
  var tmp:seq[Plugin]
  for i in  0..<plugins.len:
    for d in plugins[i].data:
      let id = d.split(';')        
      let plugin = getPluginById(id[1])
      let funcs = getFunctions(plugin).toSeq
      
      var functions:seq[Function]
      for k in 0..<funcs.len:        
        for args in funcs[k].data: # [2]:
          let argumentos = args.split(';')
          let funcName = argumentos[0]
          var newArgs:seq[seq[string]]
          for n in 1..<argumentos.len:
            let splitted = argumentos[n].split(':')
            if splitted != @[""]:
              newArgs &= splitted
            #if newArgs[newArgs.len-1] == "":
            #  newArgs = newArgs[0..newArgs.len-2]
          functions &= Function(name:funcName, args:newArgs)
      tmp &= Plugin(id:id[0], 
                    namespace:id[1],
                    description:id[2],
                    functions:functions)
  return tmp
]# 
proc vsinvoke*(plugin:ptr VSPlugin, name:string, args:ptr VSMap):ptr VSMap =
  #[
  Calls functions within plugins (invokes a filter).

  invoke() makes sure that:
  
  - the filter has no compat input nodes
  - checks that the args passed to the filter are consistent with the argument list registered by the plugin that contains the filter,
  - calls the filter’s "create" function,
  - and checks that the filter doesn’t return any compat nodes.
  
  If everything goes smoothly, the filter will be ready to generate frames after invoke() returns.
  
  Thread-safe.
  
  Arguments
  =========
  
  - plugin: A pointer to the plugin where the filter is located. Must not be NULL.
  
      See getPluginById() and getPluginByNs().
  
  - name: Name of the filter to invoke.
  - args: Arguments for the filter.
  
  Returns a map containing the filter’s return value(s).
  
  The caller gets ownership of the map. Use getError() to check if the filter was invoked successfully.
  
  Most filters will either add an error to the map, or one or more clips with the key “clip”.
  
  The exception to this are functions, for example LoadPlugin, which doesn’t return any clips for obvious reasons.
  ]#
   API.invoke(plugin, name.cstring, args)

