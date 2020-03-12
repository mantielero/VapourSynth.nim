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
#import tables

type
  Map* = object
    key*: string
    `type`*:VSPropTypes
    data*:seq[string]
    integers*:seq[int]
    floats*:seq[float]
    nodes*:seq[ptr VSNodeRef]
    frames*:seq[ptr VSFrameRef]
    functions*:seq[ptr VSFuncRef]

# TODO: a user shouldn't have to deal with this functions
proc createMap*():ptr VSMap = 
  ## Creates a new property map. It must be deallocated later with freeMap().  
  return API.createMap()

proc freeMap*(vsmap:ptr VSMap) = API.freeMap(vsmap)   # TODO: hide me!!
  ## Frees a map and all the objects it contains.

proc clearMap*(vsmap:ptr VSMap) = API.clearMap(vsmap) ## \
  ## Deletes all the keys and their associated values from the map, leaving it empty.


proc setError*(vsmap:ptr VSMap, errorMessage:cstring) = API.setError(vsmap,errorMessage)
  ## Adds an error message to a map. The map is cleared first. The error message is copied. In this state the map may only be freed, cleared or queried for the error message.
  ##
  ## For errors encountered in a filter’s "getframe" function, use setFilterError.

proc getError*(vsmap:ptr VSMap):string = 
  ## Returns a pointer to the error message contained in the map, or NULL if there is no error message. The pointer is valid as long as the map lives.
  $API.getError(vsmap)


proc propDeleteKey*(vsmap:ptr VSMap, key:cstring):int = API.propDeleteKey(vsmap, key).int  ## \
  ## Removes the property with the given key. All values associated with the key are lost.
  ## Returns 0 if the key isn’t in the map. Otherwise it returns 1.  

proc len*(vsmap:ptr VSMap):int = 
  ## Returns the number of keys contained in a property map.
  API.propNumKeys(vsmap).int

proc propGetKey*(vsmap:ptr VSMap, idx:int):string = 
  ## Returns a key from a property map.
  ## 
  ## Passing an invalid index will cause a fatal error.
  ## 
  ## The pointer is valid as long as the key exists in the map.
  var key = $API.propGetKey(vsmap, idx.cint)
  #var x = newString(key.len)
  #copyMem(addr(x[0]), addr(key), key.len)
  return key

proc propGetType*(vsmap:ptr VSMap, key:string):VSPropTypes = 
  ## Returns the type of the elements associated with the given key in a property map.
  ## The returned value is one of VSPropTypes. If there is no such key in the map, the returned value is ptUnset.
  API.propGetType(vsmap, key.cstring).VSPropTypes

proc propNumElements*(vsmap:ptr VSMap, key:string):int = 
  ## Returns the number of elements associated with a key in a property map. Returns -1 if there is no such key in the map.
  API.propNumElements(vsmap, key.cstring).int

proc propGetData*(vsmap:ptr VSMap, key:string, idx:int, error:ptr cint):string = 
  ##[
  Retrieves arbitrary binary data from a map.
  
  Returns a pointer to the data on success, or NULL in case of error.

  The array returned is guaranteed to be NULL-terminated. The NULL byte is not considered to be part of the array (propGetDataSize doesn’t count it).

  The pointer is valid until the map is destroyed, or until the corresponding key is removed from the map or altered. If the map has an error set (i.e. if getError() returns non-NULL), VapourSynth will die with a fatal error:
  
  - `index`:  Zero-based index of the element. Use propNumElements() to know the total number of elements associated with a key.
  - `error`: One of VSGetPropErrors, or 0 on success. You may pass NULL here, but then any problems encountered while retrieving the property will cause VapourSynth to die with a fatal error.]##
  $API.propGetData(vsmap, key.cstring,idx.cint,error)

proc propGetDataSize*(vsmap:ptr VSMap, key:cstring, idx:int, error:ptr cint):int = 
  ## Returns the size in bytes of a property of type ptData (see VSPropTypes), or 0 in case of error. The terminating NULL byte added by propSetData() is not counted.
  API.propGetDataSize(vsmap, key,idx.cint,error).int


proc propGetInt*(vsmap:ptr VSMap, key:cstring, idx:int, error:ptr cint):int = 
  ##[
  Retrieves an integer from a map.
  
  Returns the number on success, or 0 in case of error.
  
  If the map has an error set (i.e. if getError() returns non-NULL), VapourSynth will die with a fatal error.
  
  - `index`: Zero-based index of the element. Use propNumElements() to know the total number of elements associated with a key.
  - `error`: One of , or 0 on success. You may pass NULL here, but then any problems encountered while retrieving the property will cause VapourSynth to die with a fatal error.
  ]##
  # unsafeAddr(error.cint)
  result = API.propGetInt(vsmap, key,idx.cint, error).int
  #echo repr(error)
  #proc(map:ptr VSMap, key:cstring, index:cint, error:ptr cint):int64 

proc propGetIntArray*(vsmap:ptr VSMap, key:string, error:ptr cint):ptr int64 = #seq[int] =   VSGetPropErrors
  ##[
  Retrieves an array of integers from a map. Use this function if there are a lot of numbers associated with a key, because it is faster than calling propGetInt() in a loop.

  Returns a pointer to the first element of the array on success, or NULL in case of error.
  
  If the map has an error set (i.e. if getError() returns non-NULL), VapourSynth will die with a fatal error.
  
  Use propNumElements() to know the total number of elements associated with a key.

  error
    One of VSGetPropErrors, or 0 on success.
    You may pass NULL here, but then any problems encountered while retrieving the property will cause VapourSynth to die with a fatal error.

  This function was introduced in API R3.1 (VapourSynth R26).
  ]##
  API.propGetIntArray(vsmap, key.cstring, error)



proc propGetFloat*(vsmap:ptr VSMap, key:string, idx:int, error:ptr cint):float =
  ##[
  Retrieves a floating point number from a map.
  Returns the number on success, or 0 in case of error.
  
  If the map has an error set (i.e. if getError() returns non-NULL), VapourSynth will die with a fatal error.
  index
    Zero-based index of the element.
    Use propNumElements() to know the total number of elements associated with a key.
  error
    One of VSGetPropErrors, or 0 on success.
   You may pass NULL here, but then any problems encountered while retrieving the property will cause VapourSynth to die with a fatal error.
  ]##
  API.propGetFloat(vsmap, key.cstring, idx.cint, error)

proc propGetFloatArray*(vsmap:ptr VSMap, key:string, error:ptr cint):seq[float] =
  ##[
    Retrieves an array of floating point numbers from a map. Use this function if there are a lot of numbers associated with a key, because it is faster than calling propGetFloat() in a loop.

    Returns a pointer to the first element of the array on success, or NULL in case of error.

    If the map has an error set (i.e. if getError() returns non-NULL), VapourSynth will die with a fatal error.

    Use propNumElements() to know the total number of elements associated with a key.

    error
            One of VSGetPropErrors, or 0 on success.
            You may pass NULL here, but then any problems encountered while retrieving the property will cause VapourSynth to die with a fatal error.
  ]##
  let p:pointer= API.propGetFloatArray(vsmap, key.cstring, error)
  let n = vsmap.propNumElements(key)
  #result = cast[seq[float]](p)[n]


proc propGetNode*( vsmap:ptr VSMap, key:string, idx:int, error:ptr cint):ptr VSNodeRef =
  ##[
`original doc <http://www.vapoursynth.com/doc/api/vapoursynth.h.html#propgetnode>`_

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

  ]##
  API.propGetNode(vsmap, key.cstring, idx.cint, error)

proc propGetFrame*( vsmap:ptr VSMap, key:string, idx:int, error:ptr cint):ptr VSFrameRef =
  ##[
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
  ]##
  API.propGetFrame(vsmap, key.cstring, idx.cint, error)

proc propGetFunc*( vsmap:ptr VSMap, key:string, idx:int, error:ptr cint):ptr VSFuncRef =
  ##[
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
  ]##
  API.propGetFunc(vsmap,key.cstring, idx.cint, error)

# SETTING DATA
proc propSetData*(vsmap:ptr VSMap, key:string, data:string, append:VSPropAppendMode) =
  #[
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
Returns 0 on success, or 1 if trying to append to a property with the wrong type.
  ]#
  let ret = API.propSetData(vsmap, key.cstring, data.cstring, data.len.cint, append.cint)
  if ret == 1:
    raise newException(ValueError, "trying to append to a property with the wrong type.")

proc propSetInt*(vsmap:ptr VSMap, key:string, val:int, append:VSPropAppendMode) =
  #[
        Adds a property to a map.
        Multiple values can be associated with one key, but they must all be the same type.
        key
            Name of the property. Alphanumeric characters and the underscore may be used.
        i
            Value to store.
        append
            One of VSPropAppendMode.
        Returns 0 on success, or 1 if trying to append to a property with the wrong type.
  ]#
  let ret = API.propSetInt(vsmap, key.cstring, val.cint, append.cint)
  if ret == 1:
    raise newException(ValueError, "trying to append to a property with the wrong type" )


proc propSetIntArray*(vsmap:ptr VSMap, key:string, arr:seq[int]) = #seq[int]) =
  ##[
  Adds an array of integers to a map. Use this function if there are a lot of numbers to add, because it is faster than calling propSetInt() in a loop.
 
  If map already contains a property with this key, that property will be overwritten and all old values will be lost.
 
  key
         Name of the property. Alphanumeric characters and the underscore may be used.
  i
            Pointer to the first element of the array to store.
  size
     Number of integers to read from the array. It can be 0, in which case no integers are read from the array, and the property will be created empty.

  Returns 0 on success, or 1 if size is negative.
  ]##
  let p = cast[ptr int64](unsafeAddr(arr[0]))
  let ret = API.propSetIntArray(vsmap, key.cstring, p, arr.len.cint)
  if ret == 1:
    raise newException(ValueError, "Size is negative")


proc propSetFloat*(vsmap:ptr VSMap, key:string, val:float, append:VSPropAppendMode) =
  ##[
  Adds a property to a map.
  
  Multiple values can be associated with one key, but they must all be the same type.
  
  key
    Name of the property. Alphanumeric characters and the underscore may be used.
  d
    Value to store.
  append
    One of VSPropAppendMode.

  Returns 0 on success, or 1 if trying to append to a property with the wrong type.
  ]##
  let ret = API.propSetFloat(vsmap, key.cstring, val.cdouble, append.cint)
  if ret == 1:
    raise newException(ValueError, "trying to append to a property with the wrong type" )



proc propSetFloatArray*(vsmap:ptr VSMap, key:string, val:seq[float]) =
#[
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
]#
  let p = cast[ptr cdouble](unsafeAddr(val[0]))
  let ret = API.propSetFloatArray(vsmap, key.cstring, p, val.len.cint)
  if ret == 1:
    raise newException(ValueError, "size is negative")


proc propSetNode*(vsmap:ptr VSMap, key:string, node:ptr VSNodeRef, append:VSPropAppendMode) =
  ##[
        Adds a property to a map.
        Multiple values can be associated with one key, but they must all be the same type.
        key
            Name of the property. Alphanumeric characters and the underscore may be used.
        node
            Value to store.
            This function will increase the node’s reference count, so the pointer should be freed when no longer needed.
  ]##
  let ret = API.propSetNode(vsmap, key.cstring, node, append.cint)
  if ret == 1:
    raise newException(ValueError, "trying to append to a property with the wrong type")

proc propSetFrame*(vsmap:ptr VSMap, key:string, frame:ptr VSFrameRef, append:VSPropAppendMode) =
  ##[
    Adds a property to a map.
    Multiple values can be associated with one key, but they must all be the same type.
    key
        Name of the property. Alphanumeric characters and the underscore may be used.
    f
        Value to store.
        This function will increase the frame’s reference count, so the pointer should be freed when no longer needed.
    append
        One of VSPropAppendMode.
  ]##
  let ret = API.propSetFrame(vsmap, key.cstring, frame, append.cint)
  if ret == 1:
    raise newException(ValueError, "trying to append to a property with the wrong type")


proc propSetFunc*(vsmap:ptr VSMap, key:string, `func`:ptr VSFuncRef, append:VSPropAppendMode) =
  ##[
  Adds a property to a map.
        Multiple values can be associated with one key, but they must all be the same type.
        key
            Name of the property. Alphanumeric characters and the underscore may be used.
        func
            Value to store.
            This function will increase the function’s reference count, so the pointer should be freed when no longer needed.
        append
            One of VSPropAppendMode.
  ]##
  let ret = API.propSetFunc(vsmap, key.cstring, `func`, append.cint)
  if ret == 1:
    raise newException(ValueError, "trying to append to a property with the wrong type")

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
]#

#[
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
    
]#

  
proc `[]`*(vsmap:ptr VSMap, idx:int):Map =   #tuple[key:string,`type`:VSPropTypes, elems:seq[string]] =
  let key = propGetKey(vsmap, idx)
  let t = propGetType(vsmap, key)
  var val:Map
  val.key = key
  val.`type` = t
  #[
ptUnset* = ('u').VSPropTypes
ptNode* = ('c').VSPropTypes
ptFrame* = ('v').VSPropTypes
ptFunction* = ('m').VSPropTypes
  ]#
  let nElems = vsmap.propNumElements(key)
    
  if t == ptData:
    var elems:seq[string]
    for i in 0..<nElems:
      elems &= vsmap.propGetData(key,i,nil)  
    val.data = elems

  elif t == ptInt:
    var elems:seq[int]
    for i in 0..<nElems:
      elems &= vsmap.propGetInt(key,i,nil)  
    val.integers = elems  

  elif t == ptFloat:
    var elems:seq[float]
    for i in 0..<nElems:
      elems &= vsmap.propGetFloat(key,i,nil)  
    val.floats = elems

  elif t == ptNode:
    var elems:seq[ptr VSNodeRef]
    for i in 0..<nElems:
      elems &= vsmap.propGetNode(key,i,nil)  
    val.nodes = elems

  elif t == ptFrame:
    var elems:seq[ptr VSFrameRef]
    for i in 0..<nElems:
      elems &= vsmap.propGetFrame(key,i,nil)  
    val.frames = elems

  elif t == ptFunction:
    var elems:seq[ptr VSFuncRef]
    for i in 0..<nElems:
      elems &= vsmap.propGetFunc(key,i,nil)  
    val.functions = elems
  
  #elif t == ptUnset:
  #  continue

  return val
#[
  ptUnset* = ('u').VSPropTypes
    ptInt* = ('i').VSPropTypes
    ptFloat* = ('f').VSPropTypes
    ptData* = ('s').VSPropTypes
    ptNode* = ('c').VSPropTypes
  ptFrame* = ('v').VSPropTypes
  ptFunction* = ('m').VSPropTypes  

      nodes*:seq[ptr VSNodeRef]
    frames*:seq[ptr VSFrameRef]
    functions:*seq[ptr VSFuncRef]
]#
proc toSeq*(vsmap:ptr VSMap):seq[ Map ] =
  #var result:seq[string]
  for idx in 0..<vsmap.len:
    result &= vsmap[idx]