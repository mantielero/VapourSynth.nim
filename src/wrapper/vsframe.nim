# the built-in procedure GCunref has to be called before freeing the untraced memory manually:
# # tell the GC that the string is not needed anymore:
#GCunref(d.s)
#
# free the memory:
#dealloc(d)

import streams, strformat

type
  Format*  = object 
    name*: string #array[32, char]
    id*: VSPresetFormat
    colorFamily*: VSColorFamily
    sampleType*: VSSampleType
    bitsPerSample*: int
    bytesPerSample*: int
    subSamplingW*: int
    subSamplingH*: int
    numPlanes*: int   

  VideoInfo* = object 
    format*: Format
    fpsNum*: int
    fpsDen*: int
    width*: int
    height*: int
    numFrames*: int
    flags*: int

#[
  Plane* = object
    #width*: int
    #height*: int
    idx*: int              ## Plane position starting at 0
    #ptrIniRead*: uint   ## Initial position (read pointer)
    #ptrCurRead*: pointer   ## Current position (read pointer)
    ptrIniWrite*: uint  ## Initial position (write pointer)   
    #ptrCurWrite*: pointer  ## Current position (write pointer)
    #rowSize*:int           ## Bytes per row
    stride*:uint            ## Ammount of data to next row
    subSamplingW:int
    subSamplingH:int
    bytesPerSample:int
    rows:seq[ptr UncheckedArray[uint8]]   ## Pointers to each row
]#

# TODO: it seems to fail in some ciscunstances
proc toFormat*(format:ptr VSFormat):Format =
  # Get name
  if format == nil:
    raise newException(ValueError, "called with nil pointer")
  let n = format.name.len  # Normally 32
  var name = newString(n)
  for i in 0..<n:
    let letter = format.name[i]
    if letter != '\x00':
      name &= letter
  result = Format( name: name,
                   id: format.id.VSPresetFormat,
                   colorFamily: format.colorFamily.VSColorFamily,
                   sampleType: format.sampleType.VSSampleType,
                   bitsPerSample: format.bitsPerSample.int,
                   bytesPerSample: format.bytesPerSample.int,
                   subSamplingW: format.subSamplingW.int,
                   subSamplingH: format.subSamplingH.int,
                   numPlanes: format.numPlanes.int )  

proc getVideoInfo*(node:ptr VSNodeRef):VideoInfo =
    let vinfo = API.getVideoInfo(node)
    #let tmp = cast[VSVideoInfo](vinfo)
    let format = vinfo.format.toFormat
    result = VideoInfo( format: format,
                        fpsNum: vinfo.fpsNum.int,
                        fpsDen: vinfo.fpsDen.int,
                        width: vinfo.width.int,
                        height: vinfo.height.int,
                        numFrames: vinfo.numFrames.int,
                        flags: vinfo.flags.int )

proc getFrameFormat*(frame:ptr VSFrameRef):ptr VSFormat =
  doAssert( frame != nil, "called with a nil pointer")
  #if frame == nil:
  #  raise newException(ValueError,"called with a nil pointer")
  result = API.getFrameFormat(frame) 

proc width*(frame:ptr VSFrameRef, plane:int):cint =
  ## Returns the width of a plane of a given frame, in pixels. The width depends on the plane number because of the possible chroma subsampling.
  return API.getFrameWidth(frame, plane.cint)


proc height*(frame:ptr VSFrameRef, plane:int):cint =
  ## Returns the height of a plane of a given frame, in pixels. The height depends on the plane number because of the possible chroma subsampling.
  return API.getFrameHeight(frame, plane.cint)

proc getFrame*(node:ptr VSNodeRef, frame_number:int):ptr VSFrameRef =
  ## http://www.vapoursynth.com/doc/api/vapoursynth.h.html#getframe
  let errorSize = 256
  var errorMsg = newString(errorSize)
  result = API.getFrame(frame_number.cint, node, unsafeAddr(errorMsg[0]), errorSize.cint) #nil, 0 )

  if result == nil:
    raise newException( ValueError, "failed: {errorMsg}")

  
proc freeFrame*(frame:ptr VSFrameRef) =
  ## Deletes a frame reference, releasing the caller’s ownership of the frame.
  ## It is safe to pass NULL.
  API.freeFrame(frame)




proc getReadPtr*(frame:ptr VSFrameRef, plane:int):pointer =
  return API.getReadPtr(frame, plane.cint)

proc getWritePtr*(frame:ptr VSFrameRef, plane:int):pointer =
  return API.getWritePtr(frame, plane.cint)

proc getStride*( frame: ptr VSFrameRef, plane:int ):uint =
  ## Returns the distance in bytes between two consecutive lines of a plane of a frame. The stride is always positive (`getStride <http://www.vapoursynth.com/doc/api/vapoursynth.h.html#getstride>`_).
  return API.getStride(frame, plane.cint).uint

#[
proc getPlane*(frame:ptr VSFrameRef, plane:Natural):Plane =
  doAssert(frame != nil, "called with nil pointer")
  #if frame == nil:
  #  raise newException(ValueError, "called with nil pointer")
  let frameFormat = getFrameFormat(frame)
  if plane > frameFormat.numPlanes-1:
    raise newException(ValueError, "the plane requested is above the number of planes available")

  #let width  = getFrameWidth( frame, plane )
  #let height = frame.height( plane )
  let stride = getStride(frame, plane )
  #let planeptr = cast[uint](getReadPtr(frame, plane))  # Plane pointer
  let planeptrW = cast[uint](getWritePtr(frame, plane))
  let ssW = if plane > 0: frameFormat.subSamplingW else: 0
  let ssH = if plane > 0: frameFormat.subSamplingH else: 0 
  let bytesPerSample = frameFormat.bytesPerSample #.int
  # TODO: to deal with bigger bytes per sample
  #var rows = newSeq[ptr UncheckedArray[uint8]](height)
  #newSeq(rowPointers, height)
  let ini = cast[uint](planeptrW)
  #var rows:openArray[uint8]
  #for row in 0..<height:
  #  rows[row] = cast[ptr UncheckedArray[uint8]]( ini + row.uint * stride )
  
  #let rowSize = width * bytesPerSample
  Plane( #width:width, 
         #height:height, 
         idx:plane,
         #ptrIniRead:planeptr, 
         #ptrCurRead:planeptr, 
         ptrIniWrite:planeptrW, 
         #ptrCurWrite:planeptrW, 
         #rowSize: rowSize,         
         stride:stride,
         subSamplingW:ssW,
         subSamplingH:ssH,
         bytesPerSample: bytesPerSample,
         #rows:rows 
         )
]#
#[
proc `[]`*(frame:ptr VSFrameRef, plane:Natural):Plane =
  getPlane(frame, plane)

iterator planes*(frame:ptr VSFrameRef):Plane =
  let format = getFrameFormat(frame).toFormat
  for i in 0..<format.numPlanes:
    yield getPlane(frame, i)
]#

#[
proc goto*(plane:var Plane, row:Natural, col:Natural) = 
  let nrow = row shr plane.subSamplingH
  let ncol = col shr plane.subSamplingW
  plane.ptrCurRead = cast[pointer](cast[int](plane.ptrIniRead) + plane.stride * nrow +  ncol * plane.bytesPerSample)
  plane.ptrCurWrite= cast[pointer](cast[int](plane.ptrIniWrite) + plane.stride * nrow +  ncol * plane.bytesPerSample)  
]#

#[
proc copy*(src:var Plane, dst:var Plane, rows:Natural; cols:Natural=0) =
  let nrow = rows shr src.subSamplingH
  var ncol = 0
  if cols == 0:
    ncol = src.rowSize shr src.subSamplingW
  else:
    ncol = cols shr src.subSamplingW
  #echo "ROWS: ", nrow, "    COLS: ", ncol
  #if src.rowSize == src.stride and src.rowSize == dst.stride:
  #  copyMem(dst.ptrCurWrite, src.ptrCurRead, src.rowSize * n) # dest, source, size
  #else:
  for i in 0..<nrow:
      copyMem(dst.ptrCurWrite, src.ptrCurRead, ncol * src.bytesPerSample)
      src.ptrCurRead  = cast[pointer](cast[int](src.ptrCurRead) + src.stride)
      dst.ptrCurWrite = cast[pointer](cast[int](dst.ptrCurWrite) + dst.stride)  
]#

proc newVideoFrame*(src:ptr VSFrameRef,width:Natural,height:Natural):ptr VSFrameRef =
  let fi = API.getFrameFormat(src)
  API.newVideoFrame(fi, width.cint, height.cint, src, CORE)

#------------------------------
# HELPER FUNCTIONS

# TODO: This should take into account the bytesPerSample
#[
proc get*(plane:var Plane, row:int, col:int):int = 
  if row < 0 or col < 0 or row > plane.height-1 or col > plane.width-1:
    return 0
  var tmp = cast[ptr UncheckedArray[uint8]](plane.ptrIniRead + plane.stride * row.uint )
  return int(tmp[col * plane.bytesPerSample])
]#
#[
proc set*(plane:var Plane, row:int, col:int, val:uint8) = 
  var tmp = cast[ptr UncheckedArray[uint8]](plane.ptrIniWrite + plane.stride * row.uint )
  tmp[col * plane.bytesPerSample] = val
]#
#[
proc `[]`*(plane:Plane, row:int, col:int):int =
  # It provides a naive extrapolation
  var r = row
  var c = col
  let w = plane.width-1
  let h = plane.height-1    
  if r < 0:
    r = row
  elif r > h:
    r = h
  if c < 0:
    c = 0
  elif c > w:
    c = w

  return plane.rows[r][c].int
  #cast[int](plane.ptrIniWrite) + plane.stride * row
]#

#[
proc `[]=`*(plane:Plane, row:int, col:int, val:uint8) =
  var r = row
  var c = col
  let w = plane.width-1
  let h = plane.height-1  
  if r < 0 or r > h:
    raise newException(ValueError, &"row should be between [0,{h}] but row={row}")
  if c < 0 or c > w:
    raise newException(ValueError, &"col should be between [0,{w}] but col={col}")
  
  plane.rows[r][c] = val #.uint8
]#

#[
proc row(initptr:ptr uint8, row:int, stride:uint, height:uint) =
  let ini = cast[uint](initptr)
  let p = cast[ptr UncheckedArray[uint8]]( ini + row * stride )
  return proc(row:int):int =
    var r = row
    if row < 0:
      r = 0
    elif row > height -1:
      r = row
    p[r].int
]#
#template `[]`*(plane:Plane, row:int, col:int):int = 
#  cast[ptr uint8]( plane.ptrIniWrite + row.uint * plane.stride + col.uint)[].int
#[
template `[]=`*(plane:Plane, row:int, col:int, val:uint8) =
  cast[ptr uint8]( plane.ptrIniWrite + row.uint * plane.stride + col.uint)[] = val
]#
#[
template `[]`*(plane:Plane, row:int):ptr UncheckedArray[uint8] = 
  plane.rows[row]
]#
#[
template `[]`*(plane:Plane, row:int, col:int):int32 = 
  plane.rows[row][col].int32
]#
#template copyRow() = 

#[
template `[]`*(p:ptr uint8, col:Natural):int8 =
  ## Doesn't take into account the subsampling. A row is a row.
  var r = row
  if row < 0:
    r = 0
  elif row > plane.height-1:
    r = plane.height-1
  cast[ptr uint8](plane.ptrIniWrite + plane.stride * r.uint) 
]#
#proc `[]`(p:ptr uint8, col:int):int =
  


#[
proc `[]`*(frame:ptr VSFrameRef, plane:Natural):proc(row:int):ptr uint8 =
  assert(frame != nil, "called with nil pointer")
  let frameFormat = getFrameFormat(frame)
  let n = plane
  assert(plane < frameFormat.numPlanes, "the plane requested is above the number of planes available")

  let width  = getFrameWidth( frame, plane )
  let height = getFrameHeight( frame, plane )
  let stride = getStride(frame, plane )
  #let planeptr = getReadPtr(frame, plane)  # Plane pointer
  let p = getWritePtr(frame, plane)
  let pint = cast[int](p)

  let ssW = if plane > 0: frameFormat.subSamplingW else: 0
  let ssH = if plane > 0: frameFormat.subSamplingH else: 0 
  let bytesPerSample = frameFormat.bytesPerSample #.int
  # TODO: to deal with bigger bytes per sample
  let rowSize = (width shr ssW) * bytesPerSample
  #if bytesPerSample == 1:
  return proc(row:int):ptr uint8 =
    return cast[ptr uint8](pint + stride * (row shr ssH))
  #else:
  #  return proc(row:int):int =
  #    return cast[ptr uint16](pint + stride * (row shr ssH))    
]#

#[
proc readFrame()

]#
#----------------

type
  Plane* = object 
    ini:uint
    stride:uint
  Row = ptr UncheckedArray[uint8]

proc numPlanes*(frame:ptr VSFrameRef):cint =  # Evitamos conversiones innecesarias
  ## Number of planes in a frame
  API.getFrameFormat( frame ).numPlanes  # Frame information


proc getPtr(frame:ptr VSFrameRef, plane:cint):uint =
  ## Retrieves an `uint` rather than the pointer in order to perform pointer arithmetic with it
  cast[uint]( API.getWritePtr(frame, plane) ) 

proc stride(frame:ptr VSFrameRef, plane:cint):uint =
  API.getStride( frame, plane ).uint
#type
#  Row = ptr UncheckedArray[uint8]

proc `[]`*(frame:ptr VSFrameRef, plane:cint, row:uint):ptr UncheckedArray[uint8] =
  let ini:uint = frame.getPtr(plane)            # Don't use other thing here
  let stride:uint = frame.getStride( plane )
  result = cast[ptr UncheckedArray[uint8]]( ini + row * stride )  
  #assert(result != nil)

proc `[]`*(frame:ptr VSFrameRef, plane:cint, row:cint):ptr UncheckedArray[uint8] =
  let ini:uint = frame.getPtr(plane)            # Don't use other thing here
  let stride:uint = frame.getStride( plane )
  result = cast[ptr UncheckedArray[uint8]]( ini + row.uint * stride )  

proc `[]`*(frame:ptr VSFrameRef, plane:cint ):Plane =
  let ini = frame.getPtr(plane)
  let stride = frame.stride(plane)
  return Plane(ini:ini,stride:stride)

proc `[]`*(plane:Plane, row:cint):Row = #ptr UncheckedArray[uint8] =
  cast[ptr UncheckedArray[uint8]]( plane.ini + row.uint * plane.stride )

#template `[]`*(plane:Plane, row:cint):untyped =
#  cast[ptr UncheckedArray[uint8]]( plane.ini + row.uint * plane.stride )

proc `[]`*(row:Row, r:cint):int32 =
  #echo "hola"
  row[r].int32




#---------------
type 
  Pplane = object
    data*: seq[int32]
    width*:Natural
    height*:Natural

proc ggetPlane*(frame:ptr VSFrameRef, plane:Natural):Pplane =
  # Only for uint8 (right now)
  if frame == nil:
    raise newException(ValueError, "called with nil pointer")
  let frameFormat = getFrameFormat(frame)
  if plane > frameFormat.numPlanes-1:
    raise newException(ValueError, "the plane requested is above the number of planes available")

  let width  = frame.width( plane )
  let height = frame.height(plane )
  var data   = newSeq[uint8](height * width)
  let stride = getStride(frame, plane )
  let ini    = cast[uint](getReadPtr(frame, plane))    
  for row in 0..<height:
    let p =  cast[ptr uint8](ini + row.uint * stride)
    copyMem(addr(data[row*width]),p , width) 

  let ssW = if plane > 0: frameFormat.subSamplingW else: 0
  let ssH = if plane > 0: frameFormat.subSamplingH else: 0 
  let bytesPerSample = frameFormat.bytesPerSample #.int

  var data2 = newSeq[int32](height * width)
  for i in 0..<height*width:
    data2[i] = data[i].int32
  return Pplane(data:data2, width:width, height:height)

proc `[]`*(plane:Pplane, row:int, col:int):int = 
  var r = row
  if r < 0:
    r = 0
  elif r > plane.height - 1:
    r= plane.height - 1
  
  var c = col
  if c < 0:
    c = 0
  elif c > plane.width - 1:
    c = plane.width - 1  

  return plane.data[ r * plane.width + c].int
  

 
