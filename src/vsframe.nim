from VapourSynthWrapper import VSFrameRef
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
  #let errorSize = 256
  #var errorMsg = newString(errorSize)
  #echo "Frame number: ", frame_number
  #echo "vsframe>getFrame: ", "n=",frame_number, "  node=", repr node
  result = API.getFrame(frame_number.cint, node, nil, 0 )  #errorMsg, errorSize.cint)
  #echo "Frame Height: ", getFrameHeight(result,0)
  if result == nil:
    raise newException( ValueError, "requested frame does not exists")
  
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

#[
proc get*(plane:Plane, row:int, column:int):uint8 =
  if row < 0:
    raise newException(ValueError, "row <0")
  elif row >= plane.height:
    raise newException(ValueError, "row above height")
  elif column < 0: 
    raise newException(ValueError, "column <0") 
  elif column >= plane.width:  
    raise newException(ValueError, "column above width")  
  
  let address = cast[pointer](cast[int](plane.ptrIniRead) + column + row*plane.stride)
  cast[uint8](address)
  #plane.data[row+ column*plane.height]   # Datos por columnas
  #plane.data[row*plane.width+ column]     # Datos por filas
  
  #let tmp = row*plane.stride + column
  #let address = cast[uint](plane.`ptr`) + tmp.uint #*sizeof(uint8)
  #let address = cast[pointer]( cast[int](plane.`ptr`) + tmp )
  #cast[uint8](address)
  #cast[uint8]( plane.`ptr`)[row*plane.stride + column ]
]#
#[
https://stackoverflow.com/questions/22340279/extract-luminance-data-using-ffmpeg-libavfilter-specifically-pix-fmt-yuv420p-ty

uint8_t pixval;
for(int y = 0 ; y < height; ++y ) # Filas
{
    for(int x = 0 ; x < width; ++x )  # Columnas
    {
        pixval = data[0][x+(y*stride)];
    }
}
]#


proc getPlane*(frame:ptr VSFrameRef, plane:int):Plane =
  if frame == nil:
    raise newException(ValueError, "called with nil pointer")
  let frameFormat = getFrameFormat(frame)
  #echo "FRAME FORMAT------------> ", repr frameFormat
  #echo frameFormat.bytesPerSample
  #let format = frameFormat.toFormat
  if plane > frameFormat.numPlanes-1:
    raise newException(ValueError, "the plane requested is above the number of planes available")

  let width  = getFrameWidth( frame, plane )
  let height = getFrameHeight( frame, plane )
  let stride = getStride(frame, plane )
  let planeptr = getReadPtr(frame, plane)  # Plane pointer
  let planeptrW = getWritePtr(frame, plane)
  let ssW = if plane > 0: frameFormat.subSamplingW else: 0
  let ssH = if plane > 0: frameFormat.subSamplingH else: 0 
  let bytesPerSample = frameFormat.bytesPerSample.int
  Plane( width:width, 
         height:height, 
         idx:plane,
         ptrIniRead:planeptr, 
         ptrCurRead:planeptr, 
         ptrIniWrite:planeptrW, 
         ptrCurWrite:planeptrW, 
         rowSize: (width shr ssW ) * bytesPerSample,         
         stride:stride,
         subSamplingW:ssW,
         subSamplingH:ssH,
         bytesPerSample: bytesPerSample )

iterator planes*(frame:ptr VSFrameRef):Plane =
  let format = getFrameFormat(frame).toFormat
  for i in 0..<format.numPlanes:
    let width  = getFrameWidth( frame, i )
    let height = getFrameHeight( frame, i )
    let stride = getStride(frame, i )
    let planeptr = getReadPtr(frame, i)  # Plane pointer
    let planeptrW = getWritePtr(frame, i)
    let ssW = if i > 0: format.subSamplingW else: 0
    let ssH = if i > 0: format.subSamplingH else: 0
    yield Plane( width:width, 
                 height:height, 
                 idx:i, 
                 ptrIniRead:planeptr, 
                 ptrCurRead:planeptr, 
                 ptrIniWrite:planeptrW,
                 ptrCurWrite:planeptrW,
                 rowSize: (width shr ssW ) * format.bytesPerSample,
                 stride:stride,
                 subSamplingW:ssW,
                 subSamplingH:ssH,
                 bytesPerSample: format.bytesPerSample)

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


# TODO: This should take into account the bytesPerSample
proc get*(plane:var Plane, row:int, col:int):int = 
  if row < 0 or col < 0 or row > plane.height-1 or col > plane.width-1:
    return 0
  var tmp = cast[ptr UncheckedArray[uint8]](cast[int](plane.ptrIniRead) + plane.stride * row )
  return int(tmp[col * plane.bytesPerSample])

proc set*(plane:var Plane, row:int, col:int, val:uint8) = 
  var tmp = cast[ptr UncheckedArray[uint8]](cast[int](plane.ptrIniWrite) + plane.stride * row )
  tmp[col * plane.bytesPerSample] = val
