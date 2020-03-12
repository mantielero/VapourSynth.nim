##[
The objective is to export videos as .y4m
function VSNodeRef:writeY4MHeader(file)
  local info = self:videoInfo()
  local format = info.format
  if not format or (format.colorFamily ~= core.colorFamily.YUV and format.colorFamily ~= core.colorFamily.GRAY) then
    error('y4m only supports YUV and Gray formats')
  end
  file:write(string.format("YUV4MPEG2 C%s W%d H%d F%d:%d Ip A0:0\n",
    y4mformat, info.width, info.height, tonumber(info.fpsNum), tonumber(info.fpsDen)))
end
]##
import strutils,strformat

proc y4mheader(node:ptr VSNodeRef):string =
  ## y4m stream header generator
  ##
  ## TODO: I: sólo considera vídeo progresivo (p)
  ##
  ## TODO: A: pixel aspect ratio desconocido (0:0)  
  let vinfo = getVideoInfo( node)
  if not (vinfo.format.colorFamily in [cmYUV, cmGray]):
    raise newException(ValueError, ".y4m only supports YUV and Gray formats")
  var format = ""

  let bitsPerSample = vinfo.format.bitsPerSample
  if vinfo.format.colorFamily == cmGray:
    if bitsPerSample > 8: 
      format &= &"mono{bitsPerSample}"
    else:
      format &= "mono"

  elif vinfo.format.colorFamily == cmYUV:
    # https://en.wikipedia.org/wiki/Chroma_subsampling#Types_of_sampling_and_subsampling
    # subSamplingW: 2nd and 3rd plane sampling in horizontal direction
    # subSamplingH: same for vertical direction
    let ssW = vinfo.format.subSamplingW
    let ssH = vinfo.format.subSamplingH
    var tmp = if (ssW, ssH) == (1,1): "420"
              elif (ssW, ssH) == (1,0): "422"
              elif (ssW, ssH) == (0,0): "444"
              elif (ssW, ssH) == (2,2): "410"
              elif (ssW, ssH) == (2,0): "411"
              elif (ssW, ssH) == (0,1): "440"
              else: raise newException(ValueError, "case not covered")
    format &= tmp
    tmp = if bitsPerSample > 8: &"p{bitsPerSample}" else: ""
    format &= tmp

  result = &"YUV4MPEG2 C{format} W{vinfo.width} H{vinfo.height} F{vinfo.fpsNum}:{vinfo.fpsDen} Ip A0:0"

#[
proc y4mframe(frame:ptr VSFrameRef):seq[uint8] =
  #var tmp = "FRAME\n"
  # https://wiki.multimedia.cx/index.php?title=YUV4MPEG2
  var tmp:seq[uint8]  
  let format = frame.getFrameFormat.toFormat
  for i in 0..<format.numPlanes:
    let plane = getPlane(frame, i)
    #echo plane
    #for hval in 1..plane.height:
    #  let ini   = plane.width * (hval - 1)
    #  let `end` = plane.width * hval - 1
    #  tmp &= plane.data[ini..`end`] #.string
    tmp &= plane.data
  return tmp    
]#




proc writeY4mFrames(strm:FileStream, node:ptr VSNodeRef) =
  let vinfo = getVideoInfo(node)
  for i in 0..<vinfo.numFrames:
    strm.writeLine("FRAME")
    let frame = node.getFrame(i)
    let format = frame.getFrameFormat.toFormat
    for i in 0..<format.numPlanes:
      let plane = frame.getPlane(i)
      let width = plane.width
      let height = plane.height
      let size = width * height

      for row in 0..<plane.height:
        let address = cast[pointer](cast[int](plane.`ptr`) + row*plane.stride)
        strm.writeData(address, plane.width)
    
    freeFrame( frame )  # Once we have dealt with all the planes
  strm.flush()

proc Pipey4m*(vsmap:ptr VSMap ) =
  let d = vsmap.toSeq
  let node = d[0].nodes[0]
  let header = y4mheader( node )
  let strm = newFileStream(stdout)
  strm.write(header & "\n" )
  strm.writeY4mFrames( node ) 

proc Savey4m*(vsmap:ptr VSMap, name:string) =
  # Y-Cb-Cr plane order
  # Yes data[0] is luminance. It is 8 bits (one byte) per pixel. but you must watch the line stride.
  # The U and V planes are one quarter (half the height and half the width) the resolution of the Y plane. So each byte is 4 pixels (2 wide 2 tall).
  let d = vsmap.toSeq
  let node = d[0].nodes[0]  
  let strm = newFileStream(name, fmWrite)
  
  #echo vinfo
  let header = y4mheader(node)
  #echo header
  strm.writeLine( header )
  strm.writeY4mFrames( node ) 

  strm.close()


#[
YUV 4:2:0 (I420/J420/YV12) It has the luma "luminance" plane Y first, then the U chroma plane and last the V chroma plane.

https://stackoverflow.com/questions/22340279/extract-luminance-data-using-ffmpeg-libavfilter-specifically-pix-fmt-yuv420p-ty
]#



#[
    let vinfo = getVideoInfo(node)
  for i in 0..<vinfo.numFrames:
      strm.write("FRAME\n")
      let frame = node.getFrame(i)
      #let framebin = y4mframe( frame )

      let format = frame.getFrameFormat.toFormat
      for i in 0..<format.numPlanes:
        let plane = frame.getPlane(i)
        #for r in 0..<plane.height: # 480
          #for c in 0..<plane.width: # 854          
            #strm.write(plane.get(r,c))       
        #strm.writeData(cast[ptr uint8](plane.data[0]), plane.data.len)#c+r*plane.width])
        #for x in plane.data:
        #  strm.write(x)

        #write(stdout,plane.data)
        #stdout.writeData(unsafeAddr plane.data, plane.data.len)

      freeFrame( frame )
]#