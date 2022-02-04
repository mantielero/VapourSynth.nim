##[
VSMap
=====

A VSMap is a list of key/value pairs. Plenty of functions enable
reading and manipulating them.

VSMap is a container that stores (key,value) pairs. The keys are
strings and the values can be (arrays of) integers, floating point
numbers, arrays of bytes, VSNodeRef, VSFrameRef, or VSFuncRef.

The pairs in a VSMap are sorted by key.

In VapourSynth, VSMaps have several uses:

- storing filters’ arguments and return values
- storing user-defined functions’ arguments and return values
- storing the properties attached to frames

Only alphanumeric characters and the underscore may be used in keys.

Creating and destroying a map can be done with createMap() and
freeMap(), respectively.

A map’s contents can be retrieved and modified using a number of
functions, all prefixed with "prop".

A map’s contents can be erased with clearMap().
]##
#[
TODO: rename propGetInt into getInt. We cannot go to "get" because 
the result value cannot be overloaded

]#
import strformat
import options

#[
type
  Map* = object
    key*: cstring
    `type`*:VSPropertyType
    data*:seq[string]
    integers*:seq[int]
    floats*:seq[float]
    nodes*:seq[ptr VSNodeRef]
    frames*:seq[ptr VSFrameRef]
    functions*:seq[ptr VSFuncRef]
]#
# TODO: a user shouldn't have to deal with this functions
proc createMap*():ptr VSMap = 
  ## Creates a new property map. It must be deallocated later with
  ## freeMap().  
  API.createMap()

proc freeMap*(vsmap:ptr VSMap) =
  ## Frees a map and all the objects it contains.
  API.freeMap(vsmap)

proc clearMap*(vsmap:ptr VSMap) = 
  ## Deletes all the keys and their associated values from the map,
  ## leaving it empty.
  API.clearMap(vsmap)


proc setError*(vsmap:ptr VSMap, errorMessage:cstring) = 
  ## Adds an error message to a map. The map is cleared first. The error message is copied. In this state the map may only be freed, cleared or queried for the error message.
  ##
  ## For errors encountered in a filter’s "getframe" function, use setFilterError.
  API.mapSetError(vsmap, errorMessage)

proc getError*(vsmap:ptr VSMap):string = 
  ## Returns a pointer to the error message contained in the map, or NULL if there is no error message. The pointer is valid as long as the map lives.
  $API.mapGetError(vsmap)


proc propDeleteKey*(vsmap:ptr VSMap, key:cstring):int = API.mapDeleteKey(vsmap, key).int  ## \
  ## Removes the property with the given key. All values associated with the key are lost.
  ## Returns 0 if the key isn’t in the map. Otherwise it returns 1.  

proc len*(vsmap:ptr VSMap):int = 
  ## Returns the number of keys contained in a property map.
  API.mapNumKeys(vsmap).int

proc checkLimits(vsmap:ptr VSMap, key:string, idx: int) =
  assert( idx >= 0, "`idx` shall be >= 0")
  assert( idx < vsmap.len, "`idx` shall be <" & $vsmap.len & " but got: " & $idx)


proc checkError(error:VSMapPropertyError, key:string, idx:int) =
  #echo "ERROR"                                                                  
  case error
  of peIndex:
    raise newException(ValueError, "the index " & $idx & " is out of range")
  of peType:
    raise newException(ValueError, "the VSMap's key=" & key & " does not contain strings")
  else: # peUnset:
    discard  

proc key*(vsmap:ptr VSMap, idx:int):cstring = 
  ## Returns a key from a property map.
  assert(idx >= 0, "`idx` shall be >= 0")
  assert(idx < vsmap.len, "`idx` shall be <= " & $vsmap.len)
  #if idx < 0:
  #  raise newException(ValueError, )
  #elif idx >= vsmap.len:
  #  raise newException(ValueError, &"`idx` shall be <= {vsmap.len}")
  #var key = $API.propGetKey(vsmap, idx.cint)
  #var x = newString(key.len)
  #copyMem(addr(x[0]), addr(key), key.len)
  #return key
  return API.mapGetKey(vsmap, idx.cint)

proc `type`*(vsmap:ptr VSMap, key:cstring):VSPropertyType = 
  ## Returns the type of the elements associated with the given key in a property map.
  ## The returned value is one of VSPropertyType. If there is no such key in the map, the returned value is ptUnset.
  API.mapGetType(vsmap, key).VSPropertyType

proc len*(vsmap:ptr VSMap, key:cstring):int = 
  ## Returns the number of elements associated with a key in a property map. Returns -1 if there is no such key in the map.
  API.mapNumElements(vsmap, key).int

proc propGetData*(vsmap:ptr VSMap, key:cstring, idx:int):string = 
  ## Given a `key` retrieves the string stored at position `idx` from a map.
  #checkLimits(vsmap, key.string, idx)

  var err = peUnset.cint
  var perr = cast[ptr cint](unsafeAddr(err))  
  result = $API.mapGetData(vsmap, key, idx.cint, perr)
  #checkError(err.VSMapPropertyError, key.string, idx)


proc propGetDataSize*(vsmap:ptr VSMap, key:string, idx:int ):int = 
  ## Returns the size in bytes of a property of type ptData (see VSPropertyType), or 0 in case of error. The terminating NULL byte added by propSetData() is not counted.
  checkLimits(vsmap, key, idx)  
  var err = peUnset.cint
  var perr = cast[ptr cint](unsafeAddr(err))  
  result = API.mapGetDataSize(vsmap, key.cstring,idx.cint,perr).int
  checkError(err.VSMapPropertyError, key, idx)

proc propGetInt*(vsmap:ptr VSMap, key:string, idx:int):int = 
  ## Given a `key` retrieves the integer value stored at position `idx` from a map.
  checkLimits(vsmap, key, idx)  
  var err = peUnset.cint
  var perr = cast[ptr cint](unsafeAddr(err))  
  result = API.mapGetInt(vsmap, key.cstring, idx.cint, perr).int
  checkError(err.VSMapPropertyError, key, idx)

proc propGetFloat*(vsmap:ptr VSMap, key:string, idx:int):float =
  ## Given a `key` retrieves the integer value stored at position `idx` from a map.
  checkLimits(vsmap, key, idx)  
  var err = peUnset.cint
  var perr = cast[ptr cint](unsafeAddr(err)) 
  result = API.mapGetFloat(vsmap, key.cstring, idx.cint, perr).float
  checkError(err.VSMapPropertyError, key, idx)

proc propGetIntArray*(vsmap:ptr VSMap, key:string):seq[int] = 
  ## Retrieves an array of integers from a map.
  var err = peUnset.cint
  var perr = cast[ptr cint](unsafeAddr(err))
  let address = API.mapGetIntArray(vsmap, key.cstring, perr)
  let size = vsmap.len(key)
  if err.VSMapPropertyError == peType:
    raise newException(ValueError, &"the VSMap's key=\"{key}\" does not contain strings")

  var data = newSeq[int](size)
  if size != 0:
    copyMem(addr data[0], address, size)
  result = data

proc propGetFloatArray*(vsmap:ptr VSMap, key:string):seq[float] =
  ## Retrieves an array of floating point numbers from a map.
  var err = peUnset.cint
  var perr = cast[ptr cint](unsafeAddr(err)) 
  let address = API.mapGetFloatArray(vsmap, key.cstring, perr)
  let size = vsmap.len(key)
  if err.VSMapPropertyError == peType:
    raise newException(ValueError, &"the VSMap's key=\"{key}\" does not contain strings")

  var data = newSeq[float](size)
  if size != 0:
    copyMem(addr data[0], address, size)
  result = data

proc propGetNode*( vsmap:ptr VSMap, key:string, idx:int):ptr VSNode =
  ## Retrieves a node from a map.
  checkLimits(vsmap, key, idx)
  var err = peUnset.cint
  var perr = cast[ptr cint](unsafeAddr(err))   
  result = API.mapGetNode(vsmap, key.cstring, idx.cint, perr)  
  checkError(err.VSMapPropertyError, key, idx)

proc propGetFrame*( vsmap:ptr VSMap, key:string, idx:int):ptr VSFrame =
  ## Retrieves a frame from a map.
  checkLimits(vsmap, key, idx)   
  var err = peUnset.cint
  var perr = cast[ptr cint](unsafeAddr(err))  
  result = API.mapGetFrame(vsmap, key.cstring, idx.cint, perr)
  checkError(err.VSMapPropertyError, key, idx)    

proc propGetFunc*( vsmap:ptr VSMap, key:string, idx:int ):ptr VSFunction =
  ## Retrieves a function from a map.
  checkLimits(vsmap, key, idx)   
  var err = peUnset.cint
  var perr = cast[ptr cint](unsafeAddr(err))  
  result = API.mapGetFunction(vsmap,key.cstring, idx.cint, perr)
  checkError(err.VSMapPropertyError, key, idx)


#------------------------------------------------

# Setting data
proc append*(vsmap:ptr VSMap, key:string, data:string) =
  ## appends a string
  let ret = API.mapSetData(vsmap, key.cstring, data.cstring, data.len.cint, ptData.cint, maAppend.cint)
  if ret == 1:
    raise newException(ValueError, "trying to append a string to a property with the wrong type")

#[
    mapSetData*: proc (map: ptr VSMap; key: cstring; data: cstring; size: cint;
                       `type`: cint; append: cint): cint
]#

proc append*(vsmap:ptr VSMap, key:string, data:int) =
  ## appends an integer
  let ret = API.mapSetInt(vsmap, key.cstring, data.cint, maAppend.cint)
  if ret == 1:
    raise newException(ValueError, "trying to append an integer to a property with the wrong type")  

proc append*(vsmap:ptr VSMap, key:string, data:float) =
  ## appends a float
  let ret = API.mapSetFloat(vsmap, key.cstring, data.cdouble, maAppend.cint)
  if ret == 1:
    raise newException(ValueError, "trying to append a float to a property with the wrong type")

proc append*(vsmap:ptr VSMap, key:string, data:ptr VSNode) =
  ## appends a node
  let ret = API.mapSetNode(vsmap, key.cstring, data, maAppend.cint)
  if ret == 1:
    raise newException(ValueError, "trying to append a node to a property with the wrong type")

proc append*(vsmap:ptr VSMap, key:string, data:ptr VSFrame) =
  ## appends am integer
  let ret = API.mapSetFrame(vsmap, key.cstring, data, maAppend.cint)
  if ret == 1:
    raise newException(ValueError, "trying to append a frame to a property with the wrong type")

proc append*(vsmap:ptr VSMap, key:string, data:ptr VSFunction) =
  ## appends am integer
  let ret = API.mapSetFunction(vsmap, key.cstring, data, maAppend.cint)
  if ret == 1:
    raise newException(ValueError, "trying to append a function to a property with the wrong type")

proc set*(vsmap:ptr VSMap, key:string, data:seq[int]) =
  ## sets an integer sequence to a key
  let p = cast[ptr int64](unsafeAddr(data[0]))
  let ret = API.mapSetIntArray(vsmap, key.cstring, p, data.len.cint)
  # proc (map: ptr VSMap; key: cstring; i: ptr cint; size: cint): cint
  if ret == 1:
    raise newException(ValueError, "trying to set an integer sequence to a property with the wrong type")

#[
    mapSetIntArray*: proc (map: ptr VSMap; key: cstring; i: ptr int64;
                           size: cint): cint
]#

proc set*(vsmap:ptr VSMap, key:string, data:seq[float]) =
  ## sets an integer sequence to a key
  let ret = API.mapSetFloatArray(vsmap, key.cstring, unsafeAddr(data[0]), data.len.cint)
  if ret == 1:
    raise newException(ValueError, "trying to set a float sequence to a property with the wrong type")


#--- The following should be removed in the future
#[
proc propSetData*(vsmap:ptr VSMap, key:string, data:string, append:VSPropAppendMode) =
  ## Appends/Replace/Touch a string to a particular key in a map.
  let ret = API.propSetData(vsmap, key.cstring, data.cstring, data.len.cint, append.cint)
  if ret == 1:
    raise newException(ValueError, "trying to append to a property with the wrong type.")
]#

#[
# ===================================
#        Friendly API
# ===================================
]#

type
  Item = tuple[key:cstring, `type`:VSPropertyType]
  VSType = string | int | float | ptr VSNode | ptr VSFrame | VSFunction

iterator keys*(vsmap:ptr VSMap):cstring =
  for idx in 0..<vsmap.len:
    yield vsmap.key(idx)

iterator items*(vsmap:ptr VSMap):Item =
  for idx in 0..<vsmap.len:
    let key = vsmap.key(idx)
    let t = vsmap.`type`(key)
    var tmp:Item #= (key: key, `type`: t)
    tmp.key = key
    tmp.`type` = t
    yield tmp

proc len*(vsmap:ptr VSMap, item:Item):int =
  vsmap.len(item.key)

#[
iterator items*(vsmap:ptr VSMap, item:Item):VSType = 
  # Iterate on the available items
  #result = newSeq[VSType]()
  for idx in 0..<vsmap.len(item):
    if item.`type` == ptData:
      yield vsmap.propGetData($item.key,idx)  

    elif item.`type` == ptInt:
      yield vsmap.propGetInt($item.key,idx)  

    elif item.`type` == ptFloat:
      yield vsmap.propGetFloat($item.key,idx)   

    elif item.`type` == ptNode:
      yield vsmap.propGetNode($item.key,idx)   

    elif item.`type` == ptFrame:
      yield vsmap.propGetFrame($item.key,idx)   

    elif item.`type` == ptFunction:
      yield vsmap.propGetFunc($item.key,idx)  
]#


proc `$`*(prop:VSPropertyType):string = 
  case prop:
    of ptUnset:      "ptUnset"
    of ptInt:        "ptInt"
    of ptFloat:      "ptFloat"  
    of ptData:       "ptData"
    of ptFunction:   "ptFunction"
    of ptVideoNode:  "ptVideoNode"
    of ptAudioNode:  "ptAudioNode"  
    of ptVideoFrame: "ptVideoFrame"
    of ptAudioFrame: "ptAudioFrame"
    else:            "!!VSPropertyType Unknown"


proc `$`*(vsmap:ptr VSMap):string =
  result = &"VSMap \n" #& $vsmap  ({vsmap})
  var counter = 0
  for item in vsmap.items:
    result &= &"  idx #{counter:3}     key: \"{$item.key}\"\n"  
    result &= &"              type: {$item.`type`}\n"
    result &= &"            length: {vsmap.len(item)}\n"
    for i in 0..<vsmap.len(item):
      case item.`type`
      of ptInt: result &= &"     [{i:8.}#]    {vsmap.propGetInt($item.key, i)}\n"
      of ptFloat: result &= &"     [{i:8.}#]    {vsmap.propGetFloat($item.key, i)}\n"
      of ptData: result &= &"     [{i:8.}#]    {vsmap.propGetData($item.key, i)}\n"      
      else: result &= &"TBD in vsmap.nim"

    if item.`type` == ptVideoNode or item.`type` == ptAudioNode:
      result &= &"    n: {vsmap.len(item)}"
    counter += 1

      
#proc `[]`*(vsmap:ptr VSMap, item:Item):int  =
#  vsmap.len(item.key)

 




#[
proc get*(vsmap:ptr VSMap, idx:int):Map =  
  # This enables getting item at position `idx` from an vsmap
  let key = vsmap.key(idx)
  let t = vsmap.`type`( key)
  var val:Map
  val.key = key
  val.`type` = t
  let nElems = vsmap.len(key)
    
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
]#
#[
proc toSeq*(vsmap:ptr VSMap):seq[ Map ] =
  ## Reads from VSMap into a sequence.
  for idx in 0..<vsmap.len:
    result &= vsmap.get(idx)
]#


#[
proc `[]`*(vsmap:ptr VSMap, idx:int;clip:int=0):vsmap =
  ## Returns something
  # Check the that the first item in the vsmap is a Node type
  let key = key(vsmap, 0)
  let t = propGetType(vsmap, key)
  if t != ptNode:
    raise newException(ValueError, "slicing on vsmap only works for node")  

  # Get all nodes
  let nNodes = vsmap.len(key)

  if clip > nNodes -1:
     raise newException(ValueError, &"referring to clip number={clip} when there are only {nNodes}")

  # Load the nodes available in 
  var elems:seq[ptr VSNodeRef]
  for i in 0..<nElems:
    elems &= vsmap.propGetNode(key,i)  
  val.nodes = elems  
]#

#iterator span*(vsmap: ptr VSMap; first, last: Natural): char {.inline.} =
#  assert last < vsmap.len
#  var idx: int = first
#  while i <= last:
#    yield a[i]
#    inc(i)
#[
proc getClip(vsmap:ptr VSMap, clip:Natural):ptr VSMap =
  ## Retrieves one specific clip when there are many available
  let key = key(vsmap, 0)
  let t   = vsmap.`type`(key)
  assert t == ptNode
  #if t != ptNode:
  #  raise newException(ValueError, "slicing on vsmap only works for node") 
  # How many nodes?
  let nNodes = vsmap.len(key)
  assert clip < nNodes - 1

  var new = createMap()
  let node = vsmap.propGetNode(key,0) 
  new.append("clip", node)
  return new
]#


proc getFirstNode*(vsmap:ptr VSMap):ptr VSNode =
  ## Retrieves a node from a map.
  ## Returns a pointer to the node on success, or NULL in case of error.
  ## This function increases the node’s reference count, so freeNode() must be used when the node is no longer needed.
  ## If the map has an error set (i.e. if getError() returns non-NULL), VapourSynth will die with a fatal error.  
  let key = key(vsmap,0)
  assert( key == "clip", "expecting \"clip\" as first item in VSMap" )
  
  return vsmap.propGetNode("clip",0)


proc getFirstNodes*(vsmap:ptr VSMap):seq[ptr VSNode] =
  ## Retrieves a node from a map.
  ## Returns a pointer to the node on success, or NULL in case of error.
  ## This function increases the node’s reference count, so freeNode() must be used when the node is no longer needed.
  ## If the map has an error set (i.e. if getError() returns non-NULL), VapourSynth will die with a fatal error.  
  let key = key(vsmap,0)
  assert( key == "clips", "expecting \"clip\" as first item in VSMap" )
  
  var tmp:seq[ptr VSNode]
  for i in 0..<vsmap.len("clips"):
    tmp &= vsmap.propGetNode("clips",i)
  return tmp

proc checkContainsJustOneNode*(inClip:ptr VSMap) =
  #let tmpSeq = inClip.toSeq    # Convert the VSMap into a sequence
  assert( inClip.len > 0, "the vsmap should contain at least one item")
  assert( inClip.len("clip") > 0, "the vsmap should contain one node" )
