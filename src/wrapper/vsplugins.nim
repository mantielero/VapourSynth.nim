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

#proc(identifier:cstring, core:ptr VSCore):ptr VSPlugin 


proc getFunctions*(plugin:ptr VSPlugin):ptr VSMap = 
  API.getFunctions(plugin)

type
  Plugins = ptr VSMap

proc getPlugins*():Plugins = API.getPlugins( CORE )

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

