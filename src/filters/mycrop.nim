import ../vapoursynth
import options, strformat
##[
Let's implement the CropRel function from the `simplefilters.c <https://github.com/vapoursynth/vapoursynth/blob/master/src/core/simplefilters.c#L260>`_.

It requires `left`, `right`, `top` and `bottom` parameters  
]##


type
  CropRelData* {.bycopy.} = object
    node*:ptr VSNodeRef
    vi*:ptr VSVideoInfo
    left*:int
    right*:int
    top*:int
    bottom*:int

# Don't touch the following function signature
proc mycropInit( `in`: ptr VSMap, 
                `out`: ptr VSMap, 
                userData: ptr pointer, 
                node: ptr VSNode,
                core: ptr VSCore, 
                vsapi: ptr VSAPI) {.cdecl,exportc.} =
  ## This function sets the VideoInfo data for the output node
  ## No need to modify it unless you change size or format of the output frame.
  let data = cast[ptr CropRelData](userData[])
  data.vi.width  = data.vi.width - data.left.cint - data.right.cint
  data.vi.height = data.vi.height - data.top.cint - data.bottom.cint
  vsapi.setVideoInfo(data.vi, 1.cint, node)  # Set videoinfo in node

# Don't touch the following function signature
proc mycropGetFrame( n:cint,
                    activationReason:cint,
                    userData:ptr pointer,
                    frameData:ptr pointer, 
                    frameCtx: ptr VSFrameContext,
                    core:ptr VSCore,
                    vsapi:ptr VSAPI ):ptr VSFrameRef {.cdecl,exportc.} =
  ##[
  This function performs the data processing.

  - `n`: frame number
  - `activationReason`:
  - `userData`: contains the data given by the user
  - `frameData`: ??
  - `frameCtx`: ??
  ]##
  let data = cast[ptr CropRelData](userData[])

  if activationReason.VSActivationReason == arInitial:
      # The following requests a frame from a node and returns immediately.
      # The requested frame can then be retrieved using `getFrameFilter`, 
      # when the filter’s activation reason is `arAllFramesReady` or `arFrameReady`.
      vsapi.requestFrameFilter(n.cint, data.node, frameCtx)


  elif activationReason.VSActivationReason == arAllFramesReady:
      # It is safe to request a frame more than once. An unimportant consequence
      # of requesting a frame more than once is that the getframe function may be
      # called more than once for the same frame with reason arFrameReady.
      # It is best to request frames in ascending order, i.e. n, n+1, n+2, etc.
      let src:ptr VSFrameRef = vsapi.getFrameFilter(n.cint, data.node, frameCtx)
      let fi = vsapi.getFrameFormat(src)
      let width:int  = vsapi.getFrameWidth(src, 0)
      let height:int = vsapi.getFrameHeight(src, 0)
      
      # Message: if you use this in a filter (I will kill you)
      #let y = if (fi.id == pfCompatBGR32): (height - d.height - d.top) : d.top
      
      # Create the destination frame with proper width/height 
      let dst:ptr VSFrameRef = vsapi.newVideoFrame(fi, data.vi.width, data.vi.height, src, core)
      
      for plane in 0..<fi.numPlanes:
        let srcstride = vsapi.getStride(src, plane)
        let dststride = vsapi.getStride(dst, plane)
        #const uint8_t *srcdata = vsapi->getReadPtr(src, plane);
        var srcdata = cast[pointer](vsapi.getReadPtr(src, plane))
        #uint8_t *dstdata = vsapi->getWritePtr(dst, plane);
        var dstdata = cast[pointer](vsapi.getWritePtr(dst, plane))
        # Jump the top lines (bearing in mind the subSampling)
        let jumpTop = data.top shr (if plane > 0: fi.subSamplingH else: 0)
        srcdata = cast[pointer](cast[int](srcdata) + srcstride * jumpTop)
        # Jump the "left" bytes
        let jumpLeft = data.left shr (if plane > 0: fi.subSamplingW else: 0)
        srcdata = cast[pointer](cast[int](srcdata) +  jumpLeft * fi.bytesPerSample)
        
        # vs_bitblt(dstdata, dststride, srcdata, srcstride, (d->width >> (plane ? fi->subSamplingW : 0)) * fi->bytesPerSample, vsapi->getFrameHeight(dst, plane));
        if data.vi.height > 0:
          let tmp = data.vi.width shr (if plane > 0:  fi.subSamplingW else: 0)
          let row_size = tmp * fi.bytesPerSample
          if srcstride == dststride and srcstride == row_size:
            copyMem(dstdata, srcdata, row_size * data.vi.height) # dest, source, size
          else:
            for i in 0..<data.vi.height:
              copyMem(dstdata, srcdata, row_size)
              srcdata = cast[pointer](cast[int](srcdata) + srcstride)
              dstdata = cast[pointer](cast[int](dstdata) + dststride)

      # Create destination frame as a copy of the original one.
      #let dst:ptr VSFrameRef = API.copyFrame(src, CORE)
      vsapi.freeFrame(src)       

      #if (d.top and 1) {
      #    VSMap *props = vsapi->getFramePropsRW(dst);
      #    int error;
      #    int64_t fb = vsapi->propGetInt(props, "_FieldBased", 0, &error);
      #    if (fb == 1 || fb == 2)
      #        vsapi->propSetInt(props, "_FieldBased", (fb == 1) ? 2 : 1, paReplace);
            
      return dst
  return nil

# Don't touch the following function signature
proc mycropFree(userData:pointer, core:ptr VSCore, vsapi:ptr VSAPI) {.cdecl,exportc.} =
  ## This function cleans userData and the input node.
  let data = cast[ptr CropRelData](userData)
  vsapi.freeNode(data.node)
  dealloc(data)

# You can customize the following function signature up to your needs
proc MyCropRel*(inClip:ptr VSMap; left=none(Natural);right=none(Natural);top=none(Natural);bottom=none(Natural)):ptr VSMap =
  ##[
  This filter crops the frame given the `left`, `right`, `top` and `bottom` relative
  (all of them optional parameters). This values are all relative.
  
  These use Nim's Natural type (from 0 to high(int)).
  ]##

  # DATA VALIDATION
  # - Make sure we have an input node
  let tmpSeq = inClip.toSeq    # Convert the VSMap into a sequence
  if tmpSeq.len == 0:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  #let clip = tmpSeq[0].nodes[0] # This is a node

  # - Check the inputs make sense
  #if (top+bottom) >= 0 or (left+bottom) >= 0

  # Prepare the UserData with the input parameters
  var data:CropRelData
  
  data.node   = inClip.propGetNode( "clip", 0 )    # A pointer to the input node
  data.vi     = API.getVideoInfo(data.node)        # A pointer to the Video Info
  # - Defaults
  data.left   = 0
  data.right  = 0
  data.top    = 0
  data.bottom = 0 

  # - Assign the function parameters (if given)
  if left.isSome:   data.left   = left.get
  if right.isSome:  data.right  = right.get
  if top.isSome:    data.top    = top.get
  if bottom.isSome: data.bottom = bottom.get

  # - Data validation
  if (data.top + data.bottom) >= data.vi.height or (data.left + data.right) >= data.vi.width:
    raise newException(ValueError, "Cropped area too big")
  
  let divHorizontal = 1 shl data.vi.format.subSamplingW  # vi=VideoInfo
  let divVertical   = 1 shl data.vi.format.subSamplingH 
  if (data.left mod divHorizontal) > 0:
    raise newException(ValueError, &"left={data.left} not divisible by {divHorizontal}")
  if (data.top mod divVertical) > 0:
    raise newException(ValueError, &"top={data.top} not divisible by {divVertical}")
  if ((data.vi.width-data.left-data.right) mod divHorizontal) > 0:
    raise newException(ValueError, &"New width should be divisible by {divHorizontal}")
  if ((data.vi.height-data.left-data.right) mod divVertical) > 0:
    raise newException(ValueError, &"New width should be divisible by {divVertical}")  

  # Create an empty map for `outClip` (the returned value)
  var outClip:ptr VSMap = createMap()

  # Passthrough for the no cropping case
  if (data.left == 0 and data.right == 0 and data.top == 0 and data.bottom == 0):
      outClip.append("clip", data.node) #vsapi->propSetNode(out, "clip", d.node, paReplace);
      echo repr data.node
      API.freeNode( data.node )
      return outClip

  # Move data to the heap (this is needed in order to have visibility )
  var dataInHeap = cast[ptr CropRelData]( alloc0(sizeof(data)) )
  dataInHeap[] = data    
  
  API.createFilter( inClip, outClip,       # Don't touch me
                    "FilterName".cstring,  # Useless (I believe), but aim to make it unique
                    mycropInit,            # The initialization function name
                    mycropGetFrame,        # The function performing the frame modification
                    mycropFree,            # Needed only if using user input
                    fmParallel.cint, 
                    0.cint, 
                    dataInHeap,
                    CORE )
  return outClip

#---------------------
#---   EXECUTION -----
#---------------------
# Reads the file, applies the Simple filter and saves the result in a file
Source("../../test/2sec.mkv").CropRel(top=some(150),bottom=some(150)).Savey4m("original.y4m")