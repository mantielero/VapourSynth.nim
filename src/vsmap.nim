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
import strformat

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

proc checkLimits(vsmap:ptr VSMap, key:string, idx: int) =
  if idx < 0:
    raise newException(ValueError, "`idx` shall be >= 0")
  elif idx >= vsmap.len:
    raise newException(ValueError, &"for key=\"{key}\", `idx` shall be <= {vsmap.len}")

proc checkError(error:VSGetPropErrors, key:string, idx:int) =
  case error  
  of peIndex:
    raise newException(ValueError, &"the index \"{idx}\" is out of range")
  of peType:
    raise newException(ValueError, &"the VSMap's key=\"{key}\" does not contain strings")
  else: # peUnset:
    discard  

proc propGetKey*(vsmap:ptr VSMap, idx:int):string = 
  ## Returns a key from a property map.
  if idx < 0:
    raise newException(ValueError, "`idx` shall be >= 0")
  elif idx >= vsmap.len:
    raise newException(ValueError, &"`idx` shall be <= {vsmap.len}")
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

proc propGetData*(vsmap:ptr VSMap, key:string, idx:int):string = 
  ## Given a `key` retrieves the string stored at position `idx` from a map.
  checkLimits(vsmap, key, idx)
  var err = peUnset.cint
  result = $API.propGetData(vsmap, key.cstring, idx.cint, err)
  checkError(err.VSGetPropErrors, key, idx)

proc propGetDataSize*(vsmap:ptr VSMap, key:string, idx:int ):int = 
  ## Returns the size in bytes of a property of type ptData (see VSPropTypes), or 0 in case of error. The terminating NULL byte added by propSetData() is not counted.
  checkLimits(vsmap, key, idx)  
  var err = peUnset.cint  
  result = API.propGetDataSize(vsmap, key.cstring,idx.cint,err).int
  checkError(err.VSGetPropErrors, key, idx)

proc propGetInt*(vsmap:ptr VSMap, key:string, idx:int):int = 
  ## Given a `key` retrieves the integer value stored at position `idx` from a map.
  checkLimits(vsmap, key, idx)  
  var err = peUnset.cint  
  result = API.propGetInt(vsmap, key.cstring, idx.cint, err).int
  checkError(err.VSGetPropErrors, key, idx)

proc propGetFloat*(vsmap:ptr VSMap, key:string, idx:int):float =
  ## Given a `key` retrieves the integer value stored at position `idx` from a map.
  checkLimits(vsmap, key, idx)  
  var err = peUnset.cint  
  result = API.propGetFloat(vsmap, key.cstring, idx.cint, err).float
  checkError(err.VSGetPropErrors, key, idx)

proc propGetIntArray*(vsmap:ptr VSMap, key:string):seq[int] = 
  ## Retrieves an array of integers from a map.
  var err = peUnset.cint
  let address = API.propGetIntArray(vsmap, key.cstring, err)
  let size = vsmap.propNumElements(key)
  if err == peType:
    raise newException(ValueError, &"the VSMap's key=\"{key}\" does not contain strings")

  var data = newSeq[int](size)
  if size != 0:
    copyMem(addr data[0], address, size)
  result = data

proc propGetFloatArray*(vsmap:ptr VSMap, key:string):seq[float] =
  ## Retrieves an array of floating point numbers from a map.
  var err = peUnset.cint  
  let address = API.propGetFloatArray(vsmap, key.cstring, err)
  let size = vsmap.propNumElements(key)
  if err == peType:
    raise newException(ValueError, &"the VSMap's key=\"{key}\" does not contain strings")

  var data = newSeq[float](size)
  if size != 0:
    copyMem(addr data[0], address, size)
  result = data

proc propGetNode*( vsmap:ptr VSMap, key:string, idx:int):ptr VSNodeRef =
  ## Retrieves a node from a map.
  checkLimits(vsmap, key, idx)   
  var err = peUnset.cint   
  result = API.propGetNode(vsmap, key.cstring, idx.cint, err)  
  checkError(err.VSGetPropErrors, key, idx)  

proc propGetFrame*( vsmap:ptr VSMap, key:string, idx:int):ptr VSFrameRef =
  ## Retrieves a frame from a map.
  checkLimits(vsmap, key, idx)   
  var err = peUnset.cint   
  result = API.propGetFrame(vsmap, key.cstring, idx.cint, err)
  checkError(err.VSGetPropErrors, key, idx)    

proc propGetFunc*( vsmap:ptr VSMap, key:string, idx:int ):ptr VSFuncRef =
  ## Retrieves a function from a map.
  checkLimits(vsmap, key, idx)   
  var err = peUnset.cint  
  result = API.propGetFunc(vsmap,key.cstring, idx.cint, err)
  checkError(err.VSGetPropErrors, key, idx)




# Setting data
proc append(vsmap:ptr VSMap, key:string, data:string) =
  ## appends a string
  let ret = API.propSetData(vsmap, key.cstring, data.cstring, data.len.cint, paAppend.cint)
  if ret == 1:
    raise newException(ValueError, "trying to append a string to a property with the wrong type")

proc append(vsmap:ptr VSMap, key:string, data:int) =
  ## appends am integer
  let ret = API.propSetInt(vsmap, key.cstring, data.cint, paAppend.cint)
  if ret == 1:
    raise newException(ValueError, "trying to append an integer to a property with the wrong type")  

proc append(vsmap:ptr VSMap, key:string, data:float) =
  ## appends am integer
  let ret = API.propSetFloat(vsmap, key.cstring, data.cdouble, paAppend.cint)
  if ret == 1:
    raise newException(ValueError, "trying to append a float to a property with the wrong type")

proc append(vsmap:ptr VSMap, key:string, data:ptr VSNodeRef) =
  ## appends am integer
  let ret = API.propSetNode(vsmap, key.cstring, data, paAppend.cint)
  if ret == 1:
    raise newException(ValueError, "trying to append a node to a property with the wrong type")

proc append(vsmap:ptr VSMap, key:string, data:ptr VSFrameRef) =
  ## appends am integer
  let ret = API.propSetFrame(vsmap, key.cstring, data, paAppend.cint)
  if ret == 1:
    raise newException(ValueError, "trying to append a frame to a property with the wrong type")

proc append(vsmap:ptr VSMap, key:string, data:ptr VSFuncRef) =
  ## appends am integer
  let ret = API.propSetFunc(vsmap, key.cstring, data, paAppend.cint)
  if ret == 1:
    raise newException(ValueError, "trying to append a function to a property with the wrong type")

proc set(vsmap:ptr VSMap, key:string, data:seq[int]) =
  ## sets an integer sequence to a key
  let ret = API.propSetIntArray(vsmap, key.cstring, unsafeAddr(data[0]), data.len.cint)
  if ret == 1:
    raise newException(ValueError, "trying to set an integer sequence to a property with the wrong type")

proc set(vsmap:ptr VSMap, key:string, data:seq[float]) =
  ## sets an integer sequence to a key
  let ret = API.propSetFloatArray(vsmap, key.cstring, unsafeAddr(data[0]), data.len.cint)
  if ret == 1:
    raise newException(ValueError, "trying to set a float sequence to a property with the wrong type")


#--- The following should be removed in the future
proc propSetData*(vsmap:ptr VSMap, key:string, data:string, append:VSPropAppendMode) =
  ## Appends/Replace/Touch a string to a particular key in a map.
  let ret = API.propSetData(vsmap, key.cstring, data.cstring, data.len.cint, append.cint)
  if ret == 1:
    raise newException(ValueError, "trying to append to a property with the wrong type.")

proc propSetInt*(vsmap:ptr VSMap, key:string, val:int, append:VSPropAppendMode) =
  ## Adds a property to a map.
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
]#

#[
type 
  Tints      = tuple[key:string,value:seq[int]]
  Tfloats    = tuple[key:string,value:seq[float]] 
  Tstrings   = tuple[key:string,value:seq[string]]
  Tnodes     = tuple[key:string,value:seq[ptr VSNodeRef]]
  Tframes    = tuple[key:string,value:seq[ptr VSFrameRef]]
  Tfunctions = tuple[key:string,value:seq[ptr VSFuncRef]]
  Tunset     = tuple[key:string]
  

proc get(vsmap:ptr VSMap, idx:int):Tints|Tfloats|Tstrings|Tnodes|Tframes|Tfunctions|Tunset =
  ## Retrieves the value given an index (this is very important to take the first one)
  # Check range
  let n = vsmap.len
  if idx < 0:
    raise newException(ValueError, "VSMap index <0")  
  elif idx > n-1:
    raise newException(ValueError, "VSMap index > than the number of keys available") 

  # Retrieve key, type and number of elements for that key
  let key:string = propGetKey(vsmap, idx)
  let `type` = propGetType(vsmap, key)
  let nElems = vsmap.propNumElements(key)
    
  case `type`:
  of ptData:
    var elems:seq[string]
    var error:VSGetPropErrors = peUnset
    for i in 0..<nElems:
      elems &= vsmap.propGetData(key,i,nil)
    let tmp:Tstrings =   (key:key,value:elems)
    return tmp

  of ptInt:
    var elems:seq[int]
    for i in 0..<nElems:
      elems &= vsmap.propGetInt(key,i,nil)  
    let tmp:Tints =   (key:key,value:elems)
    return tmp

  of ptFloat:
    var elems:seq[float]
    for i in 0..<nElems:
      elems &= vsmap.propGetFloat(key,i,nil)  
    return (key,elems)

  of ptNode:
    var elems:seq[ptr VSNodeRef]
    for i in 0..<nElems:
      elems &= vsmap.propGetNode(key,i,nil)  
    return (key,elems)

  of ptFrame:
    var elems:seq[ptr VSFrameRef]
    for i in 0..<nElems:
      elems &= vsmap.propGetFrame(key,i,nil)  
    return (key,elems)

  of ptFunction:
    var elems:seq[ptr VSFuncRef]
    for i in 0..<nElems:
      elems &= vsmap.propGetFunc(key,i,nil)  
    return (key,elems)
  
  else: # ptUnset
    return (key, nil)
]# 
proc `[]`*(vsmap:ptr VSMap, idx:int):Map =
  # This enables getting item at position `idx` from an vsmap
  let key = propGetKey(vsmap, idx)
  let t = propGetType(vsmap, key)
  var val:Map
  val.key = key
  val.`type` = t
  let nElems = vsmap.propNumElements(key)
    
  if t == ptData:
    var elems:seq[string]
    for i in 0..<nElems:
      elems &= vsmap.propGetData(key,i)  
    val.data = elems

  elif t == ptInt:
    var elems:seq[int]
    for i in 0..<nElems:
      elems &= vsmap.propGetInt(key, i)  
    val.integers = elems  

  elif t == ptFloat:
    var elems:seq[float]
    for i in 0..<nElems:
      elems &= vsmap.propGetFloat(key,i)  
    val.floats = elems

  elif t == ptNode:
    var elems:seq[ptr VSNodeRef]
    for i in 0..<nElems:
      elems &= vsmap.propGetNode(key,i)  
    val.nodes = elems

  elif t == ptFrame:
    var elems:seq[ptr VSFrameRef]
    for i in 0..<nElems:
      elems &= vsmap.propGetFrame(key,i)  
    val.frames = elems

  elif t == ptFunction:
    var elems:seq[ptr VSFuncRef]
    for i in 0..<nElems:
      elems &= vsmap.propGetFunc(key,i)  
    val.functions = elems
  
  #elif t == ptUnset:
  #  continue

  return val

proc toSeq*(vsmap:ptr VSMap):seq[ Map ] =
  ## Reads from VSMap into a sequence.
  for idx in 0..<vsmap.len:
    result &= vsmap[idx]