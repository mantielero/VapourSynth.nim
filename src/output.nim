##[
Output
======

Enables piping a video or storing it in a file. The format emplyed is `YUV4MPEG2 <https://wiki.multimedia.cx/index.php/YUV4MPEG2>`_.

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
  #echo repr vinfo
  #echo "WIDTH: ",vinfo.width
  #echo "HEIGHT: ",vinfo.height
  result = &"YUV4MPEG2 C{format} W{vinfo.width} H{vinfo.height} F{vinfo.fpsNum}:{vinfo.fpsDen} Ip A0:0"
  #echo result

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




proc writeY4mFrames(strm:FileStream, node:ptr VSNodeRef):int =
  # Y-Cb-Cr plane order
  # Y is luminance. It is 8 bits (one byte) per pixel. but you must watch the line stride.
  # The U and V planes are one quarter (half the height and half the width) the resolution of the Y plane. So each byte is 4 pixels (2 wide 2 tall).
  # YUV 4:2:0 (I420/J420/YV12) It has the luma "luminance" plane Y first, then the U chroma plane and last the V chroma plane.

  let vinfo = API.getVideoInfo(node) # video info pointer
  let nframes =vinfo.numFrames 
  for i in 0..<nframes:
    #echo "Writting frame: ", i
    strm.writeLine("FRAME")
    let frame = node.getFrame(i)
    let format = frame.getFrameFormat#.toFormat
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
  #let d = vsmap.toSeq
  #let node = d[0].nodes[0]
  let header = y4mheader( node )
  let strm = newFileStream(stdout)
  strm.write(header & "\n" )
  discard strm.writeY4mFrames( node ) 
  API.freeMap(vsmap)
  API.freeNode(node)  

proc Savey4m*(vsmap:ptr VSMap, filename:string):int =
  ## Saves the video in `filename`
  let node = getFirstNode(vsmap)
  #let d = vsmap.toSeq
  #let node = d[0].nodes[0]  
  let strm = newFileStream(filename, fmWrite)
  
  let header = y4mheader(node)
  strm.writeLine( header )
  let nframes = strm.writeY4mFrames( node ) 
  strm.close()
  API.freeMap(vsmap)
  API.freeNode(node)
  return nframes


proc frameDoneCallback(userData: pointer; frame: ptr VSFrameRef; n: cint; node: ptr VSNodeRef; errorMsg: cstring) {.cdecl.} =
  freeFrame( frame )



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



#------------------
# ASYNC calls
#------------------
type
  FrameRequest {.bycopy.} = object
    nframes*: int       # Total number of frames
    nthreads*: int      # Number of threads available
    completedFrames*: int # Number of frames already processed
    requestedFrames*: int # Number of frames already requested 


proc callback( reqsData: pointer, 
               frame: ptr VSFrameRef, 
               n: cint, 
               node: ptr VSNodeRef, 
               errorMsg: cstring) {.cdecl.} = 
  #[
  Function of the client application called by the core when a requested frame is ready, after a call to getFrameAsync().

  If multiple frames were requested, they can be returned in any order. Client applications must take care of reordering them.

  This function is only ever called from one thread at a time.

  getFrameAsync() may be called from this function to request more frames.    
  ]#
  setupForeignThreadGc()
  var reqs = cast[ptr FrameRequest](reqsData) # Recover the data from the heap
  
  # Do something with the frame
  API.freeFrame( frame )
  reqs.completedFrames += 1

  # Once a frame is completed, we request another frame while there are available
  if reqs.requestedFrames < reqs.nframes:
    API.getFrameAsync( reqs.requestedFrames.cint, node, callback, reqsData)
    reqs.requestedFrames += 1    


proc NullAsync*(vsmap:ptr VSMap):int =
  var reqs:FrameRequest
  reqs.nthreads = getNumThreads()  # Get the number of threads


  let node = getFirstNode(vsmap)
  #API.freeMap(vsmap)  
  let vinfo = API.getVideoInfo(node) # video info pointer
  let nframes = vinfo.numFrames 
  reqs.nframes = vinfo.numFrames
  reqs.completedFrames = 0
  reqs.requestedFrames = 0

  let initialRequest = min(reqs.nthreads, reqs.nframes)

  var dataInHeap = cast[ptr FrameRequest](alloc0(sizeof(reqs)))
  dataInHeap[] = data
  for i in 0..<initialRequest:  # 
    API.getFrameAsync( i, node, callback, dataInHeap)
    dataInHeap.requestedFrames += 1
    
  #let frame = node.getFrame(0)
  API.freeFrame(frame)
  API.freeMap(vsmap)
  API.freeNode(node)
  return nframes
  
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

#[
  oid VSCore::createFilter(const VSMap *in, VSMap *out, const std::string &name, VSFilterInit init, VSFilterGetFrame getFrame, VSFilterFree free, VSFilterMode filterMode, int flags, void *instanceData, int apiMajor) {
    try {
        PVideoNode node(std::make_shared<VSNode>(in, out, name, init, getFrame, free, filterMode, flags, instanceData, apiMajor, this));
        for (size_t i = 0; i < node->getNumOutputs(); i++) {
            // fixme, not that elegant but saves more variant poking code
            VSNodeRef *ref = new VSNodeRef(node, static_cast<int>(i));
            vs_internal_vsapi.propSetNode(out, "clip", ref, paAppend);
            delete ref;
        }
    } catch (VSException &e) {
        vs_internal_vsapi.setError(out, e.what());
    }
}
]#

#[
requests = info.numThreads;  # Miramos el número de hilos

int requestStart = completedFrames;

# Petición inicial. El mínimo de: número de hilos, la diferencia entre el número total de frames y el número de frames ya completados
int intitalRequestSize = std::min(requests, totalFrames - requestStart);

# Frames solicitados. Los completados + la petición inicial.
requestedFrames = requestStart + intitalRequestSize;

# Pedimos frames desde el comienzo (requestStart) hasta ese valor más el initialrequest
for (int n = requestStart; n < requestStart + intitalRequestSize; n++) {
    vsapi->getFrameAsync(n, node, frameDoneCallback, nullptr);
    if (alphaNode)
        vsapi->getFrameAsync(n, alphaNode, frameDoneCallback, nullptr);
}



# Una vez en framDOneCallBack, es autosostenido

]#

#[
type
  DrawFrameData {.bycopy.} = object
    node*: ptr VSNodeRef
    vi*: ptr VSVideoInfo
    width*: Natural
    height*: Natural


proc DrawFrame*(inClip: ptr VSMap): ptr VSMap =
  checkContainsJustOneNode(inClip)
  var data: DrawFrameData
  data.node = inClip.propGetNode("clip", 0)
  data.vi = API.getVideoInfo(data.node)
  let divHorizontal = 1 shl data.vi.format.subSamplingW
  let divVertical = 1 shl data.vi.format.subSamplingH
  var outClip: ptr VSMap = createMap()
  data.width = data.vi.width.Natural
  data.height = data.vi.height.Natural
  var dataInHeap = cast[ptr DrawFrameData](alloc0(sizeof(data)))
  dataInHeap[] = data
  API.createFilter(inClip, outClip, "Thisisafilter".cstring, DrawFrameInit,
                   DrawFrameGetFrame, DrawFrameFree, fmParallel.cint, 0.cint,
                   cast[pointer](dataInHeap), CORE)
  return outClip

]#