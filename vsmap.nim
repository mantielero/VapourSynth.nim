##[
VSMap
=====

A VSMap is a list of key/value pairs. Plenty of functions enable reading and manipulating them.

VSMap is a container that stores (key,value) pairs. The keys are strings and the values can be (arrays of) integers, floating point numbers, arrays of bytes, VSNodeRef, VSFrameRef, or VSFuncRef.

The pairs in a VSMap are sorted by key.

In VapourSynth, VSMaps have several uses:

- storing filters’ arguments and return values
- storing user-defined functions’ arguments and return values
- storing the properties attached to frames

Only alphanumeric characters and the underscore may be used in keys.

Creating and destroying a map can be done with createMap() and freeMap(), respectively.

A map’s contents can be retrieved and modified using a number of functions, all prefixed with "prop".

A map’s contents can be erased with clearMap().
]##


# TODO: a user shouldn't have to deal with this functions
proc createMap(this:VS):ptr VSMap = this.vsapi.createMap() ## \  # TODO: hide me!!
  ## Creates a new property map. It must be deallocated later with freeMap().  

proc freeMap(this:VS, vsmap:ptr VSMap) = this.vsapi.freeMap(vsmap)   # TODO: hide me!!
  ## Frees a map and all the objects it contains.

proc clearMap(this:VS, vsmap:ptr VSMap) = this.vsapi.clearMap(vsmap) ## \
  ## Deletes all the keys and their associated values from the map, leaving it empty.


proc setError(this:VS, vsmap:ptr VSMap, errorMessage:cstring) = this.vsapi.setError(vsmap,errorMessage)
  ## Adds an error message to a map. The map is cleared first. The error message is copied. In this state the map may only be freed, cleared or queried for the error message.
  ##
  ## For errors encountered in a filter’s "getframe" function, use setFilterError.

proc getError(this:VS, vsmap:ptr VSMap):cstring = 
  ## Returns a pointer to the error message contained in the map, or NULL if there is no error message. The pointer is valid as long as the map lives.
  this.vsapi.getError(vsmap)


proc propDeleteKey(this:VS, vsmap:ptr VSMap, key:cstring):int = this.vsapi.propDeleteKey(vsmap, key).int  ## \
  ## Removes the property with the given key. All values associated with the key are lost.
  ## Returns 0 if the key isn’t in the map. Otherwise it returns 1.  

proc propNumKeys*(this:VS, vsmap:ptr VSMap):int = this.vsapi.propNumKeys(vsmap).int
  ## Returns the number of keys contained in a property map.

proc propGetKey*(this:VS, vsmap:ptr VSMap, idx:int):cstring = 
  ## Returns a key from a property map.
  ## 
  ## Passing an invalid index will cause a fatal error.
  ## 
  ## The pointer is valid as long as the key exists in the map.
  this.vsapi.propGetKey(vsmap, idx.cint)


proc propGetType*(this:VS, vsmap:ptr VSMap, key:cstring):VSPropTypes = 
  ## Returns the type of the elements associated with the given key in a property map.
  ## The returned value is one of VSPropTypes. If there is no such key in the map, the returned value is ptUnset.
  this.vsapi.propGetType(vsmap, key).VSPropTypes


proc propNumElements*(this:VS, vsmap:ptr VSMap, key:cstring):int = 
  ## Returns the number of elements associated with a key in a property map. Returns -1 if there is no such key in the map.
  this.vsapi.propNumElements(vsmap, key).int

proc propGetData*(this:VS, vsmap:ptr VSMap, key:cstring, idx:int, error:ptr cint):string = 
  ##[
  Retrieves arbitrary binary data from a map.
  
  Returns a pointer to the data on success, or NULL in case of error.

  The array returned is guaranteed to be NULL-terminated. The NULL byte is not considered to be part of the array (propGetDataSize doesn’t count it).

  The pointer is valid until the map is destroyed, or until the corresponding key is removed from the map or altered. If the map has an error set (i.e. if getError() returns non-NULL), VapourSynth will die with a fatal error:
  
  - `index`:  Zero-based index of the element. Use propNumElements() to know the total number of elements associated with a key.
  - `error`: One of VSGetPropErrors, or 0 on success. You may pass NULL here, but then any problems encountered while retrieving the property will cause VapourSynth to die with a fatal error.]##
  $this.vsapi.propGetData(vsmap, key,idx.cint,error)

proc propGetDataSize*(this:VS, vsmap:ptr VSMap, key:cstring, idx:int, error:ptr cint):int = 
  ## Returns the size in bytes of a property of type ptData (see VSPropTypes), or 0 in case of error. The terminating NULL byte added by propSetData() is not counted.
  this.vsapi.propGetDataSize(vsmap, key,idx.cint,error).int

#[ TODO: Fix error declaration
proc propGetInt*(this:VS, vsmap:ptr VSMap, key:cstring, idx:int, error:VSGetPropErrors):int = 
  ##[
  Retrieves an integer from a map.
  
  Returns the number on success, or 0 in case of error.
  
  If the map has an error set (i.e. if getError() returns non-NULL), VapourSynth will die with a fatal error.
  
  - `index`: Zero-based index of the element. Use propNumElements() to know the total number of elements associated with a key.
  - `error`: One of VSGetPropErrors, or 0 on success. You may pass NULL here, but then any problems encountered while retrieving the property will cause VapourSynth to die with a fatal error.
  ]##
  this.vsapi.propGetDataSize(vsmap, key,idx.cint,unsafeAddr(error.cint) ).int
]#


#[

"""
    const int64_t *propGetIntArray(const VSMap *map, const char *key, int *error)
        Retrieves an array of integers from a map. Use this function if there are a lot of numbers associated with a key, because it is faster than calling propGetInt() in a loop.
        Returns a pointer to the first element of the array on success, or NULL in case of error.
        If the map has an error set (i.e. if getError() returns non-NULL), VapourSynth will die with a fatal error.
        Use propNumElements() to know the total number of elements associated with a key.
        error
            One of VSGetPropErrors, or 0 on success.
            You may pass NULL here, but then any problems encountered while retrieving the property will cause VapourSynth to die with a fatal error.
        This function was introduced in API R3.1 (VapourSynth R26).
"""
function propGetIntArray( vsmap_p::Ptr{VSMap}, key::AbstractString, error::VSGetPropErrors )
    #int64_t propGetInt(const VSMap *map, const char *key, int index, int *error)
    ccall( vsapi.propGetIntArray, Ptr{Cintmax_t}, (Ptr{VSMap}, Cstring, Cint)  # Cstring vs Ptr{UInt8}
         , vsmap_p, key, C_NULL )
end

"""
Retrieves a floating point number from a map.
Returns the number on success, or 0 in case of error.
If the map has an error set (i.e. if getError() returns non-NULL), VapourSynth will die with a fatal error.
index
Zero-based index of the element.
Use propNumElements() to know the total number of elements associated with a key.
error
One of VSGetPropErrors, or 0 on success.
You may pass NULL here, but then any problems encountered while retrieving the property will cause VapourSynth to die with a fatal error.
"""
function propGetFloat( vsmap_p::Ptr{VSMap}, key::AbstractString, idx::Int64, error::VSGetPropErrors )
    value = ccall( vsapi.propGetFloat, Cdouble, (Ptr{VSMap}, Cstring, Cint, Cint)
                 , vsmap_p, key, idx, C_NULL )
    Float64(value)
end

"""
    const double *propGetFloatArray(const VSMap *map, const char *key, int *error)
        Retrieves an array of floating point numbers from a map. Use this function if there are a lot of numbers associated with a key, because it is faster than calling propGetFloat() in a loop.
        Returns a pointer to the first element of the array on success, or NULL in case of error.
        If the map has an error set (i.e. if getError() returns non-NULL), VapourSynth will die with a fatal error.
        Use propNumElements() to know the total number of elements associated with a key.
        error
            One of VSGetPropErrors, or 0 on success.
            You may pass NULL here, but then any problems encountered while retrieving the property will cause VapourSynth to die with a fatal error.
        This function was introduced in API R3.1 (VapourSynth R26).
"""
function propGetFloatArray( vsmap_p::Ptr{VSMap}, key::AbstractString, error::VSGetPropErrors )
    #int64_t propGetInt(const VSMap *map, const char *key, int index, int *error)
    ccall( vsapi.propGetFloatArray, Ptr{Cdouble}, (Ptr{VSMap}, Cstring, Cint)  # Cstring vs Ptr{UInt8}
         , vsmap_p, key, C_NULL )
end


"""
http://www.vapoursynth.com/doc/api/vapoursynth.h.html#propgetnode
        Retrieves a node from a map.
        Returns a pointer to the node on success, or NULL in case of error.
        This function increases the node’s reference count, so freeNode() must be used when the node is no longer needed.
        If the map has an error set (i.e. if getError() returns non-NULL), VapourSynth will die with a fatal error.
        index
            Zero-based index of the element.
            Use propNumElements() to know the total number of elements associated with a key.
        error
            One of VSGetPropErrors, or 0 on success.
            You may pass NULL here, but then any problems encountered while retrieving the property will cause VapourSynth to die with a fatal error.
"""
function propGetNode( vsmap_p::Ptr{VSMap}, key::AbstractString, idx::Int64, error::VSGetPropErrors  )
    value = ccall( vsapi.propGetNode, Ptr{VSNodeRef}, (Ptr{VSMap}, Cstring, Cint, Cint)  # VSNodeRef *propGetNode(const VSMap *map, const char *key, int index, int *error)
                 , vsmap_p, key, idx, C_NULL )
    value
end

"""
    const VSFrameRef *propGetFrame(const VSMap *map, const char *key, int index, int *error)
        Retrieves a frame from a map.
        Returns a pointer to the frame on success, or NULL in case of error.
        This function increases the frame’s reference count, so freeFrame() must be used when the frame is no longer needed.
        If the map has an error set (i.e. if getError() returns non-NULL), VapourSynth will die with a fatal error.
        index
            Zero-based index of the element.
            Use propNumElements() to know the total number of elements associated with a key.
        error
            One of VSGetPropErrors, or 0 on success.
            You may pass NULL here, but then any problems encountered while retrieving the property will cause VapourSynth to die with a fatal error.
"""
function propGetFrame( vsmap_p::Ptr{VSMap}, key::AbstractString, idx::Int64, error::VSGetPropErrors  )
    ccall( vsapi.propGetFrame, Ptr{VSFrameRef}, (Ptr{VSMap}, Cstring, Cint, Cint)  # VSNodeRef *propGetNode(const VSMap *map, const char *key, int index, int *error)
         , vsmap_p, key, idx, C_NULL )
end

"""
    VSFuncRef *propGetFunc(const VSMap *map, const char *key, int index, int *error)
        Retrieves a function from a map.
        Returns a pointer to the function on success, or NULL in case of error.
        This function increases the function’s reference count, so freeFunc() must be used when the function is no longer needed.
        If the map has an error set (i.e. if getError() returns non-NULL), VapourSynth will die with a fatal error.
        index
            Zero-based index of the element.
            Use propNumElements() to know the total number of elements associated with a key.
        error
            One of VSGetPropErrors, or 0 on success.
            You may pass NULL here, but then any problems encountered while retrieving the property will cause VapourSynth to die with a fatal error.
"""
function propGetFunc( vsmap_p::Ptr{VSMap}, key::AbstractString, idx::Int64, error::VSGetPropErrors  )
    ccall( vsapi.propGetFunc, Ptr{VSFuncRef}, (Ptr{VSMap}, Cstring, Cint, Cint)  # VSNodeRef *propGetNode(const VSMap *map, const char *key, int index, int *error)
         , vsmap_p, key, idx, C_NULL )
end


# SETTING DATA
"""
Adds a property to a map.
Multiple values can be associated with one key, but they must all be the same type.
- key
    Name of the property. Alphanumeric characters and the underscore may be used.
- data
    Value to store.
    This function copies the data, so the pointer should be freed when no longer needed.
- size
    The number of bytes to copy. If this is negative, everything up to the first NULL byte will be copied.
    This function will always add a NULL byte at the end of the data.
- append: one of VSPropAppendMode.
Returns 0 on success, or 1 if trying to append to a property with the wrong type.paAppend
"""
function propSetData( vsmap::Ptr{VSMap}, key::AbstractString, data::Union{AbstractString,Symbol}, append::VSPropAppendMode )
    # int propSetData(VSMap *map, const char *key, const char *data, int size, int append)
    err = ccall( vsapi.propSetData, Cint, (Ptr{VSMap}, Cstring, Cstring, Cint, Cint )
                 , vsmap, key, data, length(data), Int64(append) )
    Int64(err)
end

"""
        Adds a property to a map.
        Multiple values can be associated with one key, but they must all be the same type.
        key
            Name of the property. Alphanumeric characters and the underscore may be used.
        i
            Value to store.
        append
            One of VSPropAppendMode.
        Returns 0 on success, or 1 if trying to append to a property with the wrong type.
"""
function propSetInt( vsmap::Ptr{VSMap}, key::AbstractString, value::Union{Int64,Symbol}, append::VSPropAppendMode )
    #int propSetInt(VSMap *map, const char *key, int64_t i, int append)
    err = ccall( vsapi.propSetInt, Cint, (Ptr{VSMap}, Cstring, Cintmax_t, Cint )
                 , vsmap, key, value, Int(append) )
    if Int64(err) == 1
        error("propSetInt failed to append the key: $(key) with value: $(value)")
    end
end

"""
        Adds an array of integers to a map. Use this function if there are a lot of numbers to add, because it is faster than calling propSetInt() in a loop.
        If map already contains a property with this key, that property will be overwritten and all old values will be lost.
        key
            Name of the property. Alphanumeric characters and the underscore may be used.
        i
            Pointer to the first element of the array to store.
        size
            Number of integers to read from the array. It can be 0, in which case no integers are read from the array, and the property will be created empty.
        Returns 0 on success, or 1 if size is negative.
        This function was introduced in API R3.1 (VapourSynth R26).
"""
function propSetIntArray( vsmap::Ptr{VSMap}, key::AbstractString, value::Union{Array{Int64},Symbol} )
    #int propSetIntArray(VSMap *map, const char *key, const int64_t *i, int size)
    println(value)
    println(size(value))
    err = ccall( vsapi.propSetIntArray, Cint, (Ptr{VSMap}, Cstring, Ptr{Cintmax_t}, Cint )
                 , vsmap, key, value, length(value) )
    if Int64(err) == 1
        error("propSetIntArray failed to append the key: $(key) with value: $(value)")
    end
end

"""
Adds a property to a map.
Multiple values can be associated with one key, but they must all be the same type.
key
    Name of the property. Alphanumeric characters and the underscore may be used.
d
    Value to store.
append
    One of VSPropAppendMode.
Returns 0 on success, or 1 if trying to append to a property with the wrong type.
"""
function propSetFloat( vsmap::Ptr{VSMap}, key::AbstractString, value::Union{Float64,Symbol}, append::VSPropAppendMode )
    #int propSetFloat(VSMap *map, const char *key, double d, int append)
    err = ccall( vsapi.propSetFloat, Cint, (Ptr{VSMap}, Cstring, Cdouble, Cint )
               , vsmap, key, value, Int(append) )
    if Int64(err) == 1
        error("propSetFloat failed to append the key: $(key) with value: $(value)")
    end
end

"""
        Adds an array of floating point numbers to a map. Use this function if there are a lot of numbers to add, because it is faster than calling propSetFloat() in a loop.
        If map already contains a property with this key, that property will be overwritten and all old values will be lost.
        key
            Name of the property. Alphanumeric characters and the underscore may be used.
        d
            Pointer to the first element of the array to store.
        size
            Number of floating point numbers to read from the array. It can be 0, in which case no numbers are read from the array, and the property will be created empty.
        Returns 0 on success, or 1 if size is negative.
        This function was introduced in API R3.1 (VapourSynth R26).
"""
function propSetFloatArray( vsmap::Ptr{VSMap}, key::AbstractString, value::Union{Array{Float64},Symbol} )
    #int propSetIntArray(VSMap *map, const char *key, const int64_t *i, int size)
    err = ccall( vsapi.propSetFloatArray, Cint, (Ptr{VSMap}, Cstring, Ptr{Float64}, Cint )
                 , vsmap, key, value, length(value) )
    if Int64(err) == 1
        error("propSetFloatArray failed to append the key: $(key) with value: $(value)")
    end
end

"""
        Adds a property to a map.
        Multiple values can be associated with one key, but they must all be the same type.
        key
            Name of the property. Alphanumeric characters and the underscore may be used.
        node
            Value to store.
            This function will increase the node’s reference count, so the pointer should be freed when no longer needed.
        append
            One of VSPropAppendMode.
        Returns 0 on success, or 1 if trying to append to a property with the wrong type.
"""
function propSetNode( vsmap::Ptr{VSMap}, key::AbstractString, node::Ptr{VSNodeRef}, append::VSPropAppendMode ) #Union{Ptr{VSNodeRef},Symbol}
    # int propSetNode(VSMap *map, const char *key, VSNodeRef *node, int append)
    err = ccall( vsapi.propSetNode, Cint, (Ptr{VSMap}, Cstring, Ptr{VSNodeRef}, Cint )
                 , vsmap, key, node, Int64(append) )
    Int64(err)
end

"""
        Adds a property to a map.
        Multiple values can be associated with one key, but they must all be the same type.
        key
            Name of the property. Alphanumeric characters and the underscore may be used.
        f
            Value to store.
            This function will increase the frame’s reference count, so the pointer should be freed when no longer needed.
        append
            One of VSPropAppendMode.
        Returns 0 on success, or 1 if trying to append to a property with the wrong type.
"""
function propSetFrame( vsmap::Ptr{VSMap}, key::AbstractString, frame::Union{Ptr{VSFrameRef},Symbol}, size::Int64, append::VSPropAppendMode )
    # int propSetFrame(VSMap *map, const char *key, const VSFrameRef *f, int append)
    err = ccall( vsapi.propSetFrame, Cint, (Ptr{VSMap}, String, Ptr{VSFrameRef}, Cint )
                 , vsmap, key, frame, Int64(append) )
    Int64(err)
end

"""
        Adds a property to a map.
        Multiple values can be associated with one key, but they must all be the same type.
        key
            Name of the property. Alphanumeric characters and the underscore may be used.
        func
            Value to store.
            This function will increase the function’s reference count, so the pointer should be freed when no longer needed.
        append
            One of VSPropAppendMode.
        Returns 0 on success, or 1 if trying to append to a property with the wrong type.
"""
function propSetFunc( vsmap::Ptr{VSMap}, key::AbstractString, func::Union{Ptr{VSFuncRef},Symbol}, append::VSPropAppendMode )
    #int propSetFunc(VSMap *map, const char *key, VSFuncRef *func, int append)
    err = ccall( vsapi.propSetFunc, Cint, (Ptr{VSMap}, String, Ptr{VSFuncRef}, Cint )
                 , vsmap, key, func, Int64(append) )
    Int64(err)
end
]#


#[
# ===================================
#        Friendly API
# ===================================
"""
Gets the values from a VSMap.
The values are provided as a list. The keys as discarded since they are meaningless.
Example
=======
a = [ ("key1", 1)
    , ("key2", "Testing")
    , ("key3", 1.1)
    , ("key4", [1,2,3])
    , ("key5", [1.1,2.2,3.3])
     ]
vsmap = list2vsmap(a)
lista = vsmap2list(vsmap)
"""
function vsmap2list( vsmap::Ptr{VSMap} )
    n = propNumKeys( vsmap )
    items = []

    for i in 0:n-1
        key = propGetKey( vsmap, i )
        t   = propGetType( vsmap, key )
        n_items = propNumElements( vsmap, key)
        # Lista elementos
        data = []
        for elem in 0:n_items-1
            if t == ptData
               ptr = propGetData(  vsmap, key, elem, peUnset )
               cadena = unsafe_string(ptr)
               push!(data, cadena)
            elseif t == ptInt
               valor = propGetInt(  vsmap, key, elem, peUnset )
               #print(valor)
               push!(data, valor)
           elseif t == ptFloat
              valor = propGetFloat(  vsmap, key, elem, peUnset )
              #print(valor)
              push!(data, valor)
           elseif t == ptNode
              valor = propGetNode(  vsmap, key, elem, peUnset )
              #print("NODO: $(valor)\n")
              push!(data, valor)
           elseif t == ptFrame
              valor = propGetFrame(  vsmap, key, elem, peUnset )
              push!(data, valor)
           elseif t == ptFunction
              valor = propGetFunc( vsmap, key, elem, peUnset )
              push!(data, valor)
           else
              print("TODO: el tipo $(t) no está todavía soportado")
           end
        end
        if length(data) == 1
            data = data[1]
        end
        item = (key,data)
        #println(item)
        #items = [items item]
        push!(items, item)

    end
    items
end

"""
Creates a VSMap from an array.
a = [ ["key", value]
    , ["key", value]
    ]
"""
function list2vsmap( items ) #::Array{Any,1}
    vsmap = createMap()
    for item in items
        key = item[1]
        value = item[2]
        setvalue(vsmap, key, value)
    end
    vsmap
end

setvalue(vsmap::VSMap, key::String, value::Int) = propSetInt( vsmap, key, value, paAppend )
setvalue(vsmap::VSMap, key::String, value::Array{Int64,1}) = propSetIntArray( vsmap, key, value )
setvalue(vsmap::VSMap, key::String, value::AbstractFloat) = propSetFloat( vsmap, key, value, paAppend )
setvalue(vsmap::VSMap, key::String, value::Array{Float64,1}) = propSetFloatArray( vsmap, key, value )
setvalue(vsmap::VSMap, key::String, value::AbstractString) = propSetData( vsmap, key, value, paAppend )
setvalue(vsmap::VSMap, key::String, value::VSNodeRef) = propSetNode( vsmap, key, value, paAppend )
setvalue(vsmap::VSMap, key::String, value::VSFrameRef) = propSetFrame( vsmap, key, value, paAppend )
setvalue(vsmap::VSMap, key::String, value::VSFuncRef) = propSetFunc( vsmap, key, value, paAppend )
setvalue(vsmap::VSMap, key::String, value::Nothing) = nothing
#setvalue(vsmap::VSMap, key::String, value::Symbol) =
]#