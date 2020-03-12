import strutils
##[
Plugins
=======

Plugins are loaded and provide a number of functions. We need no make those functions available.

]##

type
  Function* = object
    name*:string
    args*:seq[seq[string]]

  Plugin* = object
    id*:string
    namespace*:string
    description*:string
    functions*:seq[Function]

proc getPluginById*(id:string):ptr VSPlugin = 
  API.getPluginById(id.cstring, CORE)

#proc(identifier:cstring, core:ptr VSCore):ptr VSPlugin 

proc getFunctions*(plugin:ptr VSPlugin):ptr VSMap = 
  API.getFunctions(plugin)

#proc getPlugins():ptr VSMap = API.getPlugins( CORE )


proc getPlugins*():seq[Plugin] = #:seq[ tuple[id:string,namespace:string,description:string, functions:seq[tuple[funcname:string, args:seq[seq[string]]] ]] ]   =
  # http://www.vapoursynth.com/doc/api/vapoursynth.h.html#getplugins
  # http://www.vapoursynth.com/doc/api/vapoursynth.h.html#getfunctions
  # http://www.vapoursynth.com/doc/api/vapoursynth.h.html#getpluginbyid
  let plugins = API.getPlugins( CORE ).toSeq
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
  

#[
proc createPluginFunctions() =
  let plugins = getPlugins()
]#


#    invoke*: proc(plugin:ptr VSPlugin, name:cstring, args:ptr VSMap):ptr VSMap {.cdecl.}

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


#[   CONVIERTE LOS TIPOS DE LAS FUNCIONES EN TIPOS "decentes"
function get_new_type( t::String)
    if t == "data[]"
        return String
    elseif t == "int"
        return Int
    elseif t == "clip"
        return Clip
    elseif t == "clip[]"
        return Array{Clip,1}
    elseif t == "int[]"
        return Array{Int,1}
    elseif t == "float[]"
        return Array{Float64,1}
    elseif t == "data"
        return String
    elseif t == "float"
        return Float64
    elseif t == "func"
        return VSFuncRef
    else
        println("[ERROR] vsplugins - get_new_type: No se conoce el tipo: $(t)")
    end
end  
]#

#[
#module Vsplugin

abstract type VSPlugin end

struct Plugin
    id::String
    namespace::String
    fullname::String
    functions::NamedTuple
    ptr::Ptr{VSPlugin}

    function Plugin( core::Ptr{VSCore}, cadena::String)
        elems = split(cadena, ";")
        functions = []
        plugin_ptr = getPluginById(  core, elems[2] )
        lista = Expr(:tuple,)
        # func contains a string: funcname+params
        for func in getpluginfunctions( plugin_ptr)
            # Creating the list with the function arguments
            params = []
            if occursin(";", func)
                arguments = split(func, ";")
                for argument in arguments[2:end]
                    if occursin(":", argument)
                       push!( params,  [String(i) for i in split(argument, ":")] )#Param( String(elem) ) )
                    end
                end
            end

            func = create_function( plugin_ptr, String( arguments[1] ), params)
            lista.args = [lista.args; Expr(:(=), Symbol(String( arguments[1] )), func )]
        end

        # Creamos una named tuple con las func
        new(elems[2], elems[1], elems[3], eval(lista), plugin_ptr)
    end
end


struct Param
    param::String
    paramtype::String
    optional::Bool
    function Param(cadena::String)
        tmp = split(cadena, ":" )
        optional = length(tmp) == 2 ? false : true
        new( tmp[1], tmp[2], optional)
    end
end

struct Function
    name::String
    params::Array{Param}
    function Function(cadena::String)
        params = []
        if occursin(";", cadena)
            elems = split(cadena, ";")
            for elem in elems[2:end]
                if occursin(":", elem)
                   push!( params, Param( String(elem) ) )
                end
            end
            new( elems[1], params )
        else
            new( cadena, [])
        end

    end
end







# DADO QUE ESTO NO ES POSIBLE, USAR LA APROXIMACIÓN DE CREAR FICHEROS DE TEXTO CON LOS MÓDULOS
# es decir: un módulo "ffms2" que contiene las funciones. Además es más legible.
function create_function( ptr::Ptr{VSPlugin}, funcname::String, params)
    # Creating function signature
    funcname = lowercasefirst(funcname)
    Funcname = uppercasefirst(funcname)
    funcnamesbl = Symbol(funcname)
    # Creamos la llamada a la función
    # Incluye: parámetros obligatorios + opcionales (les asigna nothing)
    f_arguments = []


    args = []

    for i in 1:length(params)
        param = params[i]
        symbol = Symbol(param[1])
        tipo = get_new_type( param[2] )
        if length(param) == 2 #Expr(:kw,:y,Float64(2))
            ex = Expr(:(::), symbol, tipo)
            args = [args; (param[1], symbol, ex, tipo, true)]  # text, symbol, expression, mandatory
        elseif length(param) > 2 && param[3] == "opt"
            ex = Expr(:(::),Symbol(param[1]),Union{tipo, Nothing}) # Asignamos el tipo
            ex = Expr(:kw, ex, :nothing)
            args = [args; (param[1], symbol, ex, tipo, false)] # text, symbol, expression, mandatory
        end
    end

    optional = [arg[3] for arg in args if !arg[5]]
    f_argumentsopt = Expr(:parameters,optional...)

    f_call = Expr( :call,
                   funcnamesbl,
                   f_argumentsopt,
                   [ex for (t, s, ex, tipo, mandatory) in args if mandatory]...)

    lista = []
    lista = vcat(lista, :(vsmap = Main.VapourSynth.createMap()))
    #println(f_call)
    for (t,s,ex,tipo,mandatory) in args
        #if !mandatory
        #    lista = vcat(lista, :(if $s != nothing) )
        #end
        if mandatory
            if tipo <: Int
                lista = vcat(lista, :(Main.VapourSynth.propSetInt( vsmap, $t, $s, Main.VapourSynth.paAppend )))
            elseif tipo <: Array{Int64,1}
                lista = vcat(lista, :(Main.VapourSynth.propSetIntArray( vsmap, $t, $s ) ))
            elseif tipo <: AbstractFloat
                lista = vcat(lista, :(Main.VapourSynth.propSetFloat( vsmap, $t, $s, Main.VapourSynth.paAppend ) ))
            elseif tipo <: Array{Float64,1}
                lista = vcat(lista, :(Main.VapourSynth.propSetFloatArray( vsmap, $t, $s ) ))
            elseif tipo <: AbstractString
                lista = vcat(lista, :(Main.VapourSynth.propSetData( vsmap, $t, $s, Main.VapourSynth.paAppend ) ))
            elseif tipo <: VSNodeRef
                lista = vcat(lista, :(Main.VapourSynth.propSetNode( vsmap, $t, $s, Main.VapourSynth.paAppend ) ))
            elseif tipo <: VSFrameRef
                lista = vcat(lista, :(Main.VapourSynth.propSetFrame( vsmap, $t, $s, Main.VapourSynth.paAppend ) ))
            elseif tipo <: VSFuncRef
                lista = vcat(lista, :(Main.VapourSynth.propSetFunc( vsmap, $t, $s, Main.VapourSynth.paAppend ) ))
            elseif tipo <: Clip
                lista = vcat(lista, :(tmp = Main.VapourSynth.propSetNode( vsmap, $t, $s.ptr, Main.VapourSynth.paAppend ) ))

            elseif tipo <: Array{Clip, 1}
                tmp = quote
                    for clip in $s
                        Main.VapourSynth.propSetNode( vsmap, $t, clip.ptr, Main.VapourSynth.paAppend )
                    end
                end
                lista = vcat(lista, tmp )
            end
        else
            if tipo <: Int
                tmp = quote
                    if $s != nothing
                       Main.VapourSynth.propSetInt( vsmap, $t, $s, Main.VapourSynth.paAppend )
                    end
                end
                lista = vcat(lista, tmp )
            elseif tipo <: Array{Int64,1}
                tmp = quote
                    if $s != nothing
                       Main.VapourSynth.propSetIntArray( vsmap, $t, $s )
                    end
                end
                lista = vcat(lista, tmp )
            elseif tipo <: AbstractFloat
                tmp = quote
                    if $s != nothing
                       Main.VapourSynth.propSetFloat( vsmap, $t, $s, Main.VapourSynth.paAppend )
                    end
                end
                lista = vcat(lista, tmp )
            elseif tipo <: Array{Float64,1}
                tmp = quote
                    if $s != nothing
                       Main.VapourSynth.propSetFloatArray( vsmap, $t, $s )
                    end
                end
                lista = vcat(lista, tmp)
            elseif tipo <: AbstractString
                tmp = quote
                    if $s != nothing
                       Main.VapourSynth.propSetData( vsmap, $t, $s, Main.VapourSynth.paAppend )
                    end
                end
                lista = vcat(lista, tmp)
            elseif tipo <: VSNodeRef
                tmp = quote
                    if $s != nothing
                       Main.VapourSynth.propSetNode( vsmap, $t, $s, Main.VapourSynth.paAppend )
                    end
                end
                lista = vcat(lista, tmp)
            elseif tipo <: VSFrameRef
                tmp = quote
                    if $s != nothing
                       Main.VapourSynth.propSetFrame( vsmap, $t, $s, Main.VapourSynth.paAppend )
                    end
                end
                lista = vcat(lista, tmp )
            elseif tipo <: VSFuncRef
                tmp = quote
                    if $s != nothing
                       Main.VapourSynth.propSetFunc( vsmap, $t, $s, Main.VapourSynth.paAppend )
                    end
                end
                lista = vcat(lista, tmp)
            end
        end
    end

    #(t,s,ex,tipo,mandatory) = args[1]

    #println( tipo )

    lista = vcat(lista, :(tmp = Main.VapourSynth.vsinvoke($ptr, $Funcname, vsmap )) )
    #lista = vcat(lista, :(println("----- ok ----") ) )
    lista = vcat(lista, :(error = Main.VapourSynth.getError( tmp )))

    #error_mng = quote
    #    if error != nothing
    #        println("|ERROR|", error)
    #    end
    #end
    #lista = vcat(lista, error_mng) #:(println("|ERROR|", error)) )

    #lista = vcat(lista, :(println(Main.VapourSynth.vsmap2list( tmp )) ))
    lista = vcat(lista, :(tmp = Main.VapourSynth.vsmap2list( tmp )) )
    tmp1 = quote
        if Main.length( tmp ) == 1
            tmp = tmp[1][2]
            #println(typeof(tmp))
            #if tmp <: Ptr{Main.VapourSynth.VSNodeRef}
            if typeof(tmp) == Ptr{Main.VapourSynth.VSNodeRef}
                tmp = Main.VapourSynth.Clip(tmp)
            end
            #return tmp
        #else
            #return tmp
        end
        return tmp
    end
    lista = vcat(lista, tmp1)


    f_body = Expr(:block,lista...)
    f_declare = Expr( :function, f_call, f_body )
    #if funcname == "trim"
    #    print(f_declare)
    #end
    f_declare
end

"""
function_name = :foobar
sig = (Int, Float64, Int32)
variables = [:a, :q, :d]
body = :(a + q * d)
"""
function create_function_expr(function_name, sig, variables, body)
	Expr(:function,
		Expr(:call,
			function_name,
			[Expr(:(::), s, t) for (s, t) in zip(variables, sig)]...),
		body
	)
end

]#

#[

"""
Calls a function within a plugin

There's no way to query the defaults. If julia allows more complex types introduce an
"empty argument" type and use as the default or something to get around it. That way you always have a default.

Python allows everything everywhere, you simply get a list and a dict of unnamed and named arguments
respectively and then you can solve things yourself.
"""
function callpluginfunction( plugin::Plugin, funcname::String, funcargs; kwargs...)
    # Checks the function is within the plugin
    functionnames = [item[1] for item in plugin.functions]
    if !(funcname in functionnames)
        error("""vsplugins.jl - callpluginfunction: function "$(funcname)" not included in plugin "$(plugin.id)".""")
    end

    # Checking all kwargs are within funcargs
    # ERROR: estamos comparando texto con un símbolo
    keys = [Symbol(i[1]) for i in funcargs]
    mandatorykeys = [!(i[2] == "opt") ? Symbol(i[1])  : nothing for i in funcargs ]
    for (k,v) in kwargs
        if !(k in keys)
            error("""vsplugins.jl - callpluginfunction: provided keyword "$(k)" is not within the allowed function arguments: $(keys).""")
        end
    end

    # Checking at least mandatory keys are provided.

    kwkeys = [k for (k,v) in kwargs]
    #print(mandatorykeys)
    for k in mandatorykeys
        if !(k in kwkeys)
            error("""vsplugins.jl - callpluginfunction: mandatory key "$(k)" not included in your keywords: "$(kwkeys)".""")
        end
    end
    #println("ok")
    # Creating a list with the provided keywords
    arglist = []
    for param in funcargs
        #if param[1] in kwkeys
        for (k,v) in kwargs
            if k == Symbol( param[1] )
                arglist = [ arglist; (param[1], v)]
            end
        end
    end
    #println("$(arglist)")
    vsmap = list2vsmap( arglist )
    newmap = invoke( plugin.ptr, funcname, vsmap)
    vsmap2list( newmap )
end
]#