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
    id*: int
    `ptr`*: pointer
    stride*:int

proc toFormat*(format:ptr VSFormat):Format =
  # Get name
  let n = format.name.len
  var name = newString(n)
  for i in 0..<n:
      name &= format.name[i]
  name = name.strip(chars={'\x00'})

  result = Format( name: name,
                   id: format.id.VSPresetFormat,
                   colorFamily: format.colorFamily.VSColorFamily,
                   sampleType: format.sampleType.VSSampleType,
                   bitsPerSample: format.bitsPerSample.int,
                   bytesPerSample: format.bitsPerSample.int,
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

proc getFrame*(node:ptr VSNodeRef, frame_number:int):ptr VSFrameRef =
  ## http://www.vapoursynth.com/doc/api/vapoursynth.h.html#getframe
  #let errorSize = 256
  #var errorMsg = newString(errorSize)
  #echo "Frame number: ", frame_number
  result = API.getFrame(frame_number.cint, node, nil, 0 )  #errorMsg, errorSize.cint)
  if result == nil:
    raise newException( ValueError, "requested frame does not exists")
  
proc freeFrame*(frame:ptr VSFrameRef) =
  ## Deletes a frame reference, releasing the caller’s ownership of the frame.
  ## It is safe to pass NULL.
  API.freeFrame(frame)

proc getFrameFormat*(frame:ptr VSFrameRef):ptr VSFormat =
  result = API.getFrameFormat(frame) 
  #result = format.toFormat

proc getFrameWidth*(frame:ptr VSFrameRef, plane:int):int =
  ## Returns the width of a plane of a given frame, in pixels. The width depends on the plane number because of the possible chroma subsampling.
  return API.getFrameWidth(frame, plane.cint).int

proc getFrameHeight*(frame:ptr VSFrameRef, plane:int):int =
  ## Returns the height of a plane of a given frame, in pixels. The height depends on the plane number because of the possible chroma subsampling.
  return API.getFrameHeight(frame, plane.cint)

proc getReadPtr*(frame:ptr VSFrameRef, plane:int):pointer =
  return API.getReadPtr(frame, plane.cint)

proc getWritePtr*(frame:ptr VSFrameRef, plane:int):pointer =
  return API.getWritePtr(frame, plane.cint)

proc getStride*( frame: ptr VSFrameRef, plane:int ):int =
  ## Returns the distance in bytes between two consecutive lines of a plane of a frame. The stride is always positive (`getStride <http://www.vapoursynth.com/doc/api/vapoursynth.h.html#getstride>`_).
  return API.getStride(frame, plane.cint)

proc get*(plane:Plane, row:int, column:int):uint8 =
  if row < 0:
    raise newException(ValueError, "row <0")
  elif row >= plane.height:
    raise newException(ValueError, "row above height")
  elif column < 0: 
    raise newException(ValueError, "column <0") 
  elif column >= plane.width:  
    raise newException(ValueError, "column above width")  
  
  let address = cast[pointer](cast[int](plane.`ptr`) + column + row*plane.stride)
  cast[uint8](address)
  #plane.data[row+ column*plane.height]   # Datos por columnas
  #plane.data[row*plane.width+ column]     # Datos por filas
  
  #let tmp = row*plane.stride + column
  #let address = cast[uint](plane.`ptr`) + tmp.uint #*sizeof(uint8)
  #let address = cast[pointer]( cast[int](plane.`ptr`) + tmp )
  #cast[uint8](address)
  #cast[uint8]( plane.`ptr`)[row*plane.stride + column ]

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
  let format = getFrameFormat(frame).toFormat
  if plane > format.numPlanes-1:
    raise newException(ValueError, "the plane requested is above the number of planes available")

  let width  = getFrameWidth( frame, plane )
  let height = getFrameHeight( frame, plane )
  let stride = getStride(frame, plane )
  let planeptr = getReadPtr(frame, plane)  # Plane pointer

  Plane(width:width, height:height, id:plane,`ptr`:planeptr, stride:stride)

#[
proc toSeq(frame:Plane, plane:int):seq[uint8] =
  var buffer = cast[ptr UncheckedArray[uint8]](plane.`ptr`)

  var data = newSeq[uint8](plane.width * plane.height)
  for row in 0..<plane.height:
    for col in 0..<plane.width:
      data[row*plane.width + col] = buffer[row*plane.stride+col]
]#