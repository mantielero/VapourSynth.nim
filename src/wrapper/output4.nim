##[
Output
======

Enables piping a video or storing it in a file. The format emplyed is `YUV4MPEG2 <https://wiki.multimedia.cx/index.php/YUV4MPEG2>`_.

]##
import strutils,strformat
import locks
import tables
import std/streams

type
  FrameRequest {.bycopy.} = object
    numFrames*: int       # Total number of frames
    nthreads*: int        # Number of threads available
    completedFrames*: int # Number of frames already processed
    requestedFrames*: int # Number of frames already requested 
    frames: Table[int,ptr VSFrame]
    current:int           # Current frame to write
    strm:FileStream

var 
  reqs:FrameRequest
  lock: Lock
  cond : Cond  


proc y4mheader(node:ptr VSNode):string =
  ## y4m stream header generator
  ##
  ## TODO: I: sólo considera vídeo progresivo (p)
  ##
  ## TODO: A: pixel aspect ratio desconocido (0:0)  
  let vinfo = getVideoInfo( node)

  if not (node.getColorFamily() in [cfYUV, cfGray]):  # vinfo.format.colorFamily
    raise newException(ValueError, ".y4m only supports YUV and Gray formats")
  var format = ""

  let bitsPerSample = vinfo.format.bitsPerSample
  if vinfo.format.colorFamily == cfGray:
    if bitsPerSample > 8: 
      format &= &"mono{bitsPerSample}"
    else:
      format &= "mono"

  elif vinfo.format.colorFamily == cfYUV:
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


proc frameDoneCallback( reqsData: pointer, 
                        frame: ptr VSFrame, 
                        n: cint, 
                        node: ptr VSNode, 
                        errorMsg: cstring) {.cdecl.} = 
  #[
  Function of the client application called by the core when a requested frame is ready, after a call to getFrameAsync().

  If multiple frames were requested, they can be returned in any order. Client applications must take care of reordering them.
  ]#
  setupForeignThreadGc()

  # Do something with the frame
  if frame != nil:
    reqs.frames[n.int] = frame  # Store the new frame in the buffer
    #echo "Completed: ", n
    # Write to file everything you can
    #if reqs.current == nil:
    var k = reqs.current + 1 
    while reqs.frames.hasKey( k ):
      #echo "Writing: ", k
      #echo repr reqs.frames
      let f = reqs.frames[k]
      #echo f.width(0)
      #echo repr f
      let format = API.getVideoFrameFormat(f) #f.getFrameFormat#.toFormat    
      reqs.strm.writeLine("FRAME")

      for i in 0..<format.numPlanes:
        #let plane = frame.getPlane(i)
        let width  = f.width( i )
        let height = f.height( i )      
        #let width = plane.width
        #let height = plane.height
        #let size = width * height
        let init = cast[uint]( getReadPtr(f, i) )
        let stride = f.getStride(i)
        for row in 0..<height:
          let address = cast[pointer]( init + row.uint * stride)
          reqs.strm.writeData(address, width.int)
      reqs.frames.del(k)
      API.freeFrame( f )
      reqs.current += 1
      k = reqs.current

    reqs.completedFrames += 1

    # Once a frame is completed, we request another frame while there are available
    if reqs.requestedFrames < reqs.numFrames:
      API.getFrameAsync( reqs.requestedFrames.cint, node, frameDoneCallback, nil)
      #echo "Requested: ", reqs.requestedFrames
      reqs.requestedFrames += 1   

    if (reqs.completedFrames == reqs.numFrames):
      cond.signal()
  else:
    raise newException(ValueError, "Failed to get frame")
#[ 
proc writeY4mFramesAsync(strm:FileStream, node:ptr VSNode):int =
  # Y-Cb-Cr plane order
  # Y is luminance. It is 8 bits (one byte) per pixel. but you must watch the line stride.
  # The U and V planes are one quarter (half the height and half the width) the resolution of the Y plane. So each byte is 4 pixels (2 wide 2 tall).
  # YUV 4:2:0 (I420/J420/YV12) It has the luma "luminance" plane Y first, then the U chroma plane and last the V chroma plane.
  reqs.nthreads = getNumThreads()  # Get the number of threads
  let vinfo = API.getVideoInfo(node) # video info pointer
  reqs.numFrames = vinfo.numFrames
  reqs.completedFrames = 0
  reqs.requestedFrames = 0
  reqs.current = -1
  reqs.strm = strm
  #echo "ok"
  let initialRequest = min(reqs.nthreads, reqs.numFrames)
  reqs.frames = initTable[int,ptr VSFrameRef]()  # Buffer
  initLock(lock)
  for i in 0..<initialRequest: 
    API.getFrameAsync( i.cint, node, frameDoneCallback, nil) #dataInHeap)
    #echo "Requested: ", i
    reqs.requestedFrames += 1
  cond.wait(lock)
  #API.freeMap(vsmap)
  #API.freeNode(node)


  #for i in 0..<nframes:
    #echo "Writting frame: ", i

    
  #  freeFrame( frame )  # Once we have dealt with all the planes
  strm.flush()
  return reqs.numFrames

 ]#






proc writeY4mFrames(strm:FileStream, node:ptr VSNode):int =
  # Y-Cb-Cr plane order
  # Y is luminance. It is 8 bits (one byte) per pixel. but you must watch the line stride.
  # The U and V planes are one quarter (half the height and half the width) the resolution of the Y plane. So each byte is 4 pixels (2 wide 2 tall).
  # YUV 4:2:0 (I420/J420/YV12) It has the luma "luminance" plane Y first, then the U chroma plane and last the V chroma plane.

  let vinfo = API.getVideoInfo(node) # video info pointer
  let nframes = vinfo.numFrames 
  for i in 0..<nframes:
    #echo "Writting frame: ", i
    strm.writeLine("FRAME")
    let frame = node.getFrame(i)
    let format = frame.getVideoFrameFormat#.toFormat
    for i in 0..<format.numPlanes:
      #let plane = frame.getPlane(i)
      let width  = frame.width( i )
      let height = frame.height( i )      
      #let width = plane.width
      #let height = plane.height
      #let size = width * height
      let init = cast[int]( getReadPtr(frame, i) )
      let stride = getStride(frame, i)
      for row in 0..<height:
        let address = cast[pointer]( init + row.int * stride.int)
        strm.writeData(address, width.int)
    
    freeFrame( frame )  # Once we have dealt with all the planes
  strm.flush()
  return nframes

proc Pipey4m*(vsmap:ptr VSMap ) =
  ## Pipes the video to stdout. The video goes uncompressed in Y4M format
  let node = getFirstNode(vsmap)
  let header = y4mheader( node )
  let strm = newFileStream(stdout)
  strm.write(header & "\n" )
  discard strm.writeY4mFrames( node ) 
  API.freeMap(vsmap)
  API.freeNode(node)  
#[ 
proc Savey4m*(vsmap:ptr VSMap, filename:string):int =
  ## Saves the video in `filename`
  #echo "ok0"
  let node = getFirstNode(vsmap)
  #echo "ok1"  
  #let d = vsmap.toSeq
  #let node = d[0].nodes[0]  
  let strm = newFileStream(filename, fmWrite)
  
  let header = y4mheader(node)
  strm.writeLine( header )
  #let nframes = strm.writeY4mFrames( node )
  let nframes = strm.writeY4mFramesAsync( node ) 
  strm.close()
  API.freeMap(vsmap)
  API.freeNode(node)
  return nframes
 ]#

#[  No usar el single threaded
proc Null*(vsmap:ptr VSMap):int =
  let node = getFirstNode(vsmap)
  #API.freeMap(vsmap)  
  let vinfo = API.getVideoInfo(node) # video info pointer
  let nframes = vinfo.numFrames 
  for i in 0..<nframes:  
    let frame = node.getFrame(i)
    API.freeFrame( frame )
    #let frame =  API.getFrame(i, node, nil, 0.cint)
    #API.getFrameAsync(i, node, frameDoneCallback, nil)
    

  API.freeMap(vsmap)
  API.freeNode(node)
  return nframes
]#

proc doNothing( reqsData: pointer, 
                frame: ptr VSFrame, 
                n: cint, 
                node: ptr VSNode, 
                errorMsg: cstring) {.cdecl.} = 
  #[
  Function of the client application called by the core when a requested frame is ready, after a call to getFrameAsync().

  If multiple frames were requested, they can be returned in any order. Client applications must take care of reordering them.

  This function is only ever called from one thread at a time.

  getFrameAsync() may be called from this function to request more frames.    
  ]#
  setupForeignThreadGc()

  # Do something with the frame
  API.freeFrame( frame )
  reqs.completedFrames += 1

  # Once a frame is completed, we request another frame while there are available
  if reqs.requestedFrames < reqs.numFrames:
    API.getFrameAsync( reqs.requestedFrames.cint, node, doNothing, reqsData)
    #echo "Frame: ", reqs.requestedFrames
    reqs.requestedFrames += 1   

  if (reqs.completedFrames == reqs.numFrames):
    cond.signal()
#[ 
proc Null*(vsmap:ptr VSMap):int =
  reqs.nthreads = getNumThreads()  # Get the number of threads
  let node = getFirstNode(vsmap)
  let vinfo = API.getVideoInfo(node) # video info pointer
  reqs.numFrames = vinfo.numFrames
  reqs.completedFrames = 0
  reqs.requestedFrames = 0

  let initialRequest = min(reqs.nthreads, reqs.numFrames)
  initLock(lock)
  for i in 0..<initialRequest:  #
    API.getFrameAsync( i.cint, node, doNothing, nil) #dataInHeap)
    #echo "Frame: ", i
    reqs.requestedFrames += 1

  cond.wait(lock)
  API.freeMap(vsmap)
  API.freeNode(node)
  return reqs.numFrames
  ]#