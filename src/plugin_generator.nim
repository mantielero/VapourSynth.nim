import VapourSynthWrapper, strformat, strutils

let API = getVapourSynthAPI(3)
let CORE = API.createCore(0)

include "vsmap.nim"
include "vsplugins.nim"

let KEYWORDS = @["addr", "and", "as", "asm", "bind", "block", "break", "case", "cast",
"concept", "const", "continue", "converter", "defer", "discard",
"distinct", "div", "do", "elif", "else", "end", "enum", "except", "export",
"finally", "for", "from", "func", "if", "import", "in", "include",
"interface", "is", "isnot", "iterator", "let", "macro", "method", "mixin",
"mod", "nil", "not", "notin", "object", "of", "or", "out", "proc", "ptr",
"raise", "ref", "return", "shl", "shr", "static", "template", "try", 
"tuple", "type", "using", "var", "when", "while", "xor", "yield" ]


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
           of "data[]":
             "seq[string]"
           of "clip":
             "ptr VSNodeRef"
           of "clip[]":
             "seq[ptr VSNodeRef]"
           of "frame":
             "ptr VSFrameRef"             
           of "frame[]":
             "seq[ptr VSFrameRef]"               
           of "func":
             "ptr VSFuncRef"             
           of "func[]":
             "seq[ptr VSFuncRef]"             
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
      var firstArg = ""
      
      var isFirstArg = true

      # Lets create the function arguments.
      for arg in f.args:
        # This is to add a "," or a ";" between each function argument
        if flag:  # This flag is in order to avoid adding "," or ";" for the first argument
          if arg.len == 2:
            args &= ", "
          elif arg.len == 3:
            args &= "; "        
        flag = true

        # Get the appropriate Nim type from the VapourSynth type
        let newtype = convertType(arg[1])
        
        # If the argument is a Nim keyword, then enclused between "`" symbol.
        var argName = arg[0]
        if argName in KEYWORDS:
          argName = &"`{argName}`"

        # Create the arguments for the Nim function
        if arg.len == 2:    # For the mandatory argument: name:type
          args &= &"{argName}:{newtype}"
        elif arg.len == 3:  # For the optional argument: name:type:opc 
          args &= &"{argName}=none({newtype})"

        # For the cases where the first argument is clip, we transform it
        # into a VSMap, to allow chaining calls
        var isClip = false
        if newtype in ["ptr VSNodeRef", "seq[ptr VSNodeRef]"] and isFirstArg:
          args="vsmap:ptr VSMap"
          isClip = true
        
        if isClip:
          firstArg &= "\n  let tmpSeq = vsmap.toSeq    # Convert the VSMap into a sequence\n"
          firstArg &= "  if tmpSeq.len == 0:\n"            
          firstArg &= "    raise newException(ValueError, \"the vsmap should contain at least one item\")\n"          

          # Just one clip
          if newtype == "ptr VSNodeRef":
            firstArg &= "  if tmpSeq[0].nodes.len != 1:\n"
            firstArg &= "    raise newException(ValueError, \"the vsmap should contain one node\")\n"
            if arg.len == 2:
              firstArg &= &"  var {argName} = tmpSeq[0].nodes[0]\n\n" 
            elif arg.len == 3:
              firstArg &= &"  var {argName} = some(tmpSeq[0].nodes[0])\n\n"
          
          # For a sequence of clips in the first argument
          elif newtype == "seq[ptr VSNodeRef]":           
            firstArg &= "  if tmpSeq[0].nodes.len >= 1:\n"
            firstArg &= "    raise newException(ValueError, \"the vsmap should contain a seq with nodes\")\n"
            if arg.len == 2:
              firstArg &= &"  var {argName} = tmpSeq[0].nodes\n\n"            
            elif arg.len == 3:
              firstArg &= &"  var {argName} = some(tmpSeq[0].nodes)\n\n"              
        
        # We create the map
        #[
        let funcName = case newtype:
                       of "int", "string", "float", "ptr VSNodeRef", "ptr VSFrameRef","ptr VSFuncRef", "seq[string]", "seq[ptr VSNodeRef]", "seq[ptr VSFrameRef]", "seq[ptr VSFuncRef]":
                        "append"
                       of "seq[int]", "seq[float]":
                         "set"
                       else:
                         ""
        ]#
        let funcName = case newtype:
                       of "seq[int]", "seq[float]":
                         "set"
                       else:
                         "append"
        if newtype[0..2] == "seq" and funcName != "set":
          if arg.len == 2:
            map &= &"  for item in {argName}:\n"
            map &= &"    args.{funcName}(\"{arg[0]}\", item)\n"     
          elif arg.len == 3:
            map &= &"  if {argName}.isSome:\n"
            map &= &"    for item in {argName}.get:\n"
            map &= &"      args.{funcName}(\"{arg[0]}\", item)\n"  
        else: 
          if arg.len == 2:
            map &= &"  args.{funcName}(\"{arg[0]}\", {argName})\n"     
          elif arg.len == 3:
            map &= &"  if {argName}.isSome: args.{funcName}(\"{arg[0]}\", {argName}.get)\n"             
        #[        
        if newtype in @["seq[string]", "seq[ptr VSNodeRef]","seq[ptr VSFrameRef]", "seq[ptr VSFuncRef]"] and arg.len == 2:
          map &= &"  for item in {argName}:\n"
          map &= &"    {funcName}(args, \"{arg[0]}\", item)\n"     
        elif newtype in @["seq[ptr VSNodeRef]","seq[ptr VSFrameRef]", "seq[ptr VSFuncRef]"] and arg.len == 3:
          map &= &"  if {argName}.isSome:\n"
          map &= &"    for item in {argName}.get:\n"
          map &= &"      {funcName}(args, \"{arg[0]}\", item, paAppend)\n"  
        ]#
        #elif newtype in @["seq[string]"]:
        #  map &= &"  if {argName}.isSome:\n"
        #  map &= &"    for item in {argName}.get:\n"
        #  map &= &"      append(args, \"{arg[0]}\", item)\n"           
        #[
        else:  # int, float, string, ... # Not sequence cases
          if funcName in @["propSetIntArray", "propSetFloatArray"]:
            if arg.len == 2:
              map &= &"  {funcName}(args, \"{arg[0]}\", {argName})\n"
            elif arg.len == 3:
              map &= &"  if {argName}.isSome:\n"   # if track.isSome:
              map &= &"    {funcName}(args, \"{arg[0]}\", {argName}.get)\n"        
          elif funcName in @["append"]:
            if arg.len == 2:
              map &= &"  args.append(\"{arg[0]}\", {argName})\n"
            elif arg.len == 3:
              map &= &"  if {argName}.isSome: args.append(\"{arg[0]}\", {argName}.get)\n"             
          else:
            if arg.len == 2:
              map &= &"  {funcName}(args, \"{arg[0]}\", {argName}, paAppend)\n"
            elif arg.len == 3:
              map &= &"  if {argName}.isSome:\n"   # if track.isSome:
              map &= &"    {funcName}(args, \"{arg[0]}\", {argName}.get, paAppend)\n"
        ]#
        isFirstArg = false # deactivate the flag

      source &= fmt"""
proc {f.name}*({args}):ptr VSMap =
  let plug = getPluginById("{plugin.namespace}")
  if plug == nil:
    raise newException(ValueError, "plugin \"{plugin.id}\" not installed properly in your computer")
{firstArg}
  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
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

  os.createDir("./plugins")
  

  let sources = gen_functions()

  var includes = "import options\n\n"
  for s in  sources:
    includes &= &"include \"{s.key}.nim\"\n"
    let name = &"./plugins/{s.key}.nim"
    writeFile(name, s.source)
    echo "Written file: ",name

  writeFile("./plugins/all_plugins.nim", includes)
  echo "Written file: ", "./plugins/all_plugins.nim" 

  #showPlugins()