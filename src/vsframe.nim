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

  Plane* = object
    width*: int
    height*: int
    idx*: int              ## Plane position starting at 0
    ptrIniRead*: pointer   ## Initial position (read pointer)
    ptrCurRead*: pointer   ## Current position (read pointer)
    ptrIniWrite*: pointer  ## Initial position (write pointer)   
    ptrCurWrite*: pointer  ## Current position (write pointer)
    rowSize*:int           ## Bytes per row
    stride*:int            ## Ammount of data to next row
    subSamplingW:int
    subSamplingH:int
    bytesPerSample:int
    rows:seq[ptr UncheckedArray[uint8]]   ## Pointers to each row


# TODO: it seems to fail in some ciscunstances
proc toFormat*(format:ptr VSFormat):Format =
  # Get name
  if format == nil:
    raise newException(ValueError, "called with nil pointer")
  let n = format.name.len  # Normally 32

  #var nameArray = cast[ptr UncheckedArray[char]](format.name)

  #let tmp:array[0..31,char] = format.name
  #echo tmp
  
  #echo repr format.name 
  var name = newString(n)
  #let name = ""
  #var letter = format.name[0]
  #let address = cast[ptr char](format.name)
  for i in 0..<n:
  #  letter = cast[char](cast[int](format.name) + i)
    let letter = format.name[i]
    if letter != '\x00':
      #name &= format.name[i]
      name &= letter
  #name = name.strip(chars={'\x00'})
  #echo name

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
    let tmp = cast[VSVideoInfo](vinfo)
    #echo "------ VINFO ----------------"
    #echo repr vinfo
    #echo "----------------------\n\n\n"
    let format = vinfo.format.toFormat
    result = VideoInfo( format: format,
                        fpsNum: vinfo.fpsNum.int,
                        fpsDen: vinfo.fpsDen.int,
                        width: vinfo.width.int,
                        height: vinfo.height.int,
                        numFrames: vinfo.numFrames.int,
                        flags: vinfo.flags.int )
    #echo repr result

proc getFrameFormat*(frame:ptr VSFrameRef):ptr VSFormat =
  if frame == nil:
    raise newException(ValueError,"called with a nil pointer")
  result = API.getFrameFormat(frame) 
  #result = format.toFormat

proc getFrameWidth*(frame:ptr VSFrameRef, plane:int):int =
  ## Returns the width of a plane of a given frame, in pixels. The width depends on the plane number because of the possible chroma subsampling.
  return API.getFrameWidth(frame, plane.cint).int


proc getFrameHeight*(frame:ptr VSFrameRef, plane:int):int =
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

proc getStride*( frame: ptr VSFrameRef, plane:int ):int =
  ## Returns the distance in bytes between two consecutive lines of a plane of a frame. The stride is always positive (`getStride <http://www.vapoursynth.com/doc/api/vapoursynth.h.html#getstride>`_).
  return API.getStride(frame, plane.cint)

proc getPlane*(frame:ptr VSFrameRef, plane:Natural):Plane =
  if frame == nil:
    raise newException(ValueError, "called with nil pointer")
  let frameFormat = getFrameFormat(frame)
  if plane > frameFormat.numPlanes-1:
    raise newException(ValueError, "the plane requested is above the number of planes available")

  let width  = getFrameWidth( frame, plane )
  let height = getFrameHeight( frame, plane )
  let stride = getStride(frame, plane )
  let planeptr = getReadPtr(frame, plane)  # Plane pointer
  let planeptrW = getWritePtr(frame, plane)
  let ssW = if plane > 0: frameFormat.subSamplingW else: 0
  let ssH = if plane > 0: frameFormat.subSamplingH else: 0 
  let bytesPerSample = frameFormat.bytesPerSample #.int
  # TODO: to deal with bigger bytes per sample
  var rowPointers:seq[ptr UncheckedArray[uint8]] = @[]
  newSeq(rowPointers, height)
  let ini = cast[int](planeptrW)
  for row in 0..<height:
    rowPointers[row] = cast[ptr UncheckedArray[uint8]]( ini + row * stride )
  let rowSize = width * bytesPerSample
  Plane( width:width, 
         height:height, 
         idx:plane,
         ptrIniRead:planeptr, 
         ptrCurRead:planeptr, 
         ptrIniWrite:planeptrW, 
         ptrCurWrite:planeptrW, 
         rowSize: rowSize,         
         stride:stride,
         subSamplingW:ssW,
         subSamplingH:ssH,
         bytesPerSample: bytesPerSample,
         rows:rowPointers )

proc `[]`*(frame:ptr VSFrameRef, plane:Natural):Plane =
  getPlane(frame, plane)

iterator planes*(frame:ptr VSFrameRef):Plane =
  let format = getFrameFormat(frame).toFormat
  for i in 0..<format.numPlanes:
    yield getPlane(frame, i)

proc goto*(plane:var Plane, row:Natural, col:Natural) = 
  let nrow = row shr plane.subSamplingH
  let ncol = col shr plane.subSamplingW
  plane.ptrCurRead = cast[pointer](cast[int](plane.ptrIniRead) + plane.stride * nrow +  ncol * plane.bytesPerSample)
  plane.ptrCurWrite= cast[pointer](cast[int](plane.ptrIniWrite) + plane.stride * nrow +  ncol * plane.bytesPerSample)  

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

proc newVideoFrame*(src:ptr VSFrameRef,width:Natural,height:Natural):ptr VSFrameRef =
  let fi = API.getFrameFormat(src)
  API.newVideoFrame(fi, width.cint, height.cint, src, CORE)

#------------------------------
# HELPER FUNCTIONS

# TODO: This should take into account the bytesPerSample
proc get*(plane:var Plane, row:int, col:int):int = 
  if row < 0 or col < 0 or row > plane.height-1 or col > plane.width-1:
    return 0
  var tmp = cast[ptr UncheckedArray[uint8]](cast[int](plane.ptrIniRead) + plane.stride * row )
  return int(tmp[col * plane.bytesPerSample])

proc set*(plane:var Plane, row:int, col:int, val:uint8) = 
  var tmp = cast[ptr UncheckedArray[uint8]](cast[int](plane.ptrIniWrite) + plane.stride * row )
  tmp[col * plane.bytesPerSample] = val


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

proc `[]=`*(plane:Plane, row:int, col:int, val:uint8) =
  var r = row
  var c = col
  let w = plane.width-1
  let h = plane.height-1  
  if r < 0 or r > h:
    raise newException(ValueError, &"row should be between [0,{h}] but row={row}")
  if c < 0 or c > w:
    raise newException(ValueError, &"col should be between [0,{w}] but col={col}")
  
  plane.rows[r][c] = val.uint8
#proc `[]`(p:Plane, row:Natural):rowPtr =
#  cast[int](plane.ptrIniWrite) + plane.stride * row
