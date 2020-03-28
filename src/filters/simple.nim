import ../src/vapoursynth
import options

type
  SimpleData* {.bycopy.} = object
    node*:ptr VSNodeRef
    vi*:ptr VSVideoInfo
    x*:int
    y*:int
    width*:int
    height*:int

# Don't touch the following function signature
proc simpleInit( `in`: ptr VSMap, 
                `out`: ptr VSMap, 
                userData: ptr pointer, 
                node: ptr VSNode,
                core: ptr VSCore, 
                vsapi: ptr VSAPI) {.cdecl,exportc.} =
  ## This function sets the VideoInfo data for the output node
  ## No need to modify it unless you change size or format of the output frame.
  let data = cast[ptr SimpleData](userData[])
  vsapi.setVideoInfo(data.vi, 1.cint, node)  # Set videoinfo in node

# Don't touch the following function signature
proc simpleGetFrame( n:cint,
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
  let d = cast[ptr SimpleData](userData[])

  if activationReason.VSActivationReason == arInitial:
      # The following requests a frame from a node and returns immediately.
      # The requested frame can then be retrieved using `getFrameFilter`, 
      # when the filter’s activation reason is `arAllFramesReady` or `arFrameReady`.
      vsapi.requestFrameFilter(n.cint, d.node, frameCtx)

  elif activationReason.VSActivationReason == arAllFramesReady:
      # It is safe to request a frame more than once. An unimportant consequence
      # of requesting a frame more than once is that the getframe function may be
      # called more than once for the same frame with reason arFrameReady.
      # It is best to request frames in ascending order, i.e. n, n+1, n+2, etc.
      let src:ptr VSFrameRef = vsapi.getFrameFilter(n.cint, d.node, frameCtx)

      # Create destination frame as a copy of the original one.
      let dst:ptr VSFrameRef = API.copyFrame(src, CORE)

      vsapi.freeFrame(src)       
      return dst
  return nil

# Don't touch the following function signature
proc simpleFree(userData:pointer, core:ptr VSCore, vsapi:ptr VSAPI) {.cdecl,exportc.} =
  ## This function cleans userData and the input node.
  let data = cast[ptr SimpleData](userData)
  vsapi.freeNode(data.node)
  dealloc(data)

# You can customize the following function signature up to your needs
proc Simple*(inClip:ptr VSMap; x=none(int);y=none(int);width=none(int);height=none(int)):ptr VSMap =
  ##[
  This is the documentation for this very simple filter

  - `inClip`: contains a `ptr VSMap` with the input clip
  - `x`: this is an optional parameter which can be empty or an int

  This function returns another `ptr VSMap` which contains an output frame.
  ]##

  
  # 1. Filter the input data to make sure it is as expected
  # - The following checks that `inClip` contains just one node
  let tmpSeq = inClip.toSeq    # Convert the VSMap into a sequence
  if tmpSeq.len == 0:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0] # This is a node
  
  # `outClip` will be just a `ptr VSMap` which points to an empty VSMap
  var outClip = createMap()
  
  # UserData: this will contain the data that will be sent to `simpleInit` function
  # and `simpleGetFrame` function. It contains parameters given by the user as 
  # parameters of the `Simple` function.
  var d:SimpleData    
  d.node   = inClip.propGetNode( "clip", 0 ) # A pointer to the input node
  d.vi     = API.getVideoInfo(d.node)        # A pointer to the Video Info
  # Defaults
  d.width  = 854
  d.height = 480
  d.x      = 10
  d.y      = 20 
  
  # Assign the function parameters if given to the "data" pointer.
  if x.isSome: d.x = x.get
  if y.isSome: d.y = y.get
  if width.isSome: d.width = width.get
  if height.isSome: d.height = height.get
  
  # Move data to the heap (this is needed in order to have visibility )
  var data = cast[ptr SimpleData]( alloc0(sizeof(d)) )
  data[] = d    
  
  API.createFilter( inClip, outClip,       # Don't touch me
                    "FilterName".cstring,  # Useless (I believe), but aim to make it unique
                    simpleInit,            # The initialization function name
                    simpleGetFrame,        # The function performing the frame modification
                    simpleFree,            # Needed only if using user input
                    fmParallel.cint, 
                    0.cint, 
                    data,
                    CORE )
  return outClip

#---------------------
#---   EXECUTION -----
#---------------------
# Reads the file, applies the Simple filter and saves the result in a file
Source("2sec.mkv").Simple.Savey4m("original.y4m")