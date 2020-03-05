##[
Plugins
=======

Plugins are loaded and provide a number of functions. We need no make those functions available.

]##


proc getPluginById*(this:VS, id:string):ptr VSPlugin = 
  this.vsapi.getPluginById(id.cstring, this.coreptr)

#proc(identifier:cstring, core:ptr VSCore):ptr VSPlugin 

proc getFunctions*(this:VS, plugin:ptr VSPlugin):ptr VSMap = 
  this.vsapi.getFunctions(plugin)