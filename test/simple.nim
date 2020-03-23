import ../src/vapoursynth
import options

type
  CropData* {.bycopy.} = object
    node*:ptr VSNodeRef
    vi*:ptr VSVideoInfo
    x*:int
    y*:int
    width*:int
    height*:int


proc cropInit1( `in`: ptr VSMap, 
                `out`: ptr VSMap, 
                userData: ptr pointer, 
                node: ptr VSNode,
                core: ptr VSCore, 
                vsapi: ptr VSAPI) {.cdecl,exportc.} =

  let data = cast[ptr CropData](userData[])
  vsapi.setVideoInfo(data.vi, 1.cint, node)  # Set videoinfo in node

proc cropGetFrame1( n:cint,
                    activationReason:cint,
                    instanceData:ptr pointer,
                    frameData:ptr pointer, 
                    frameCtx: ptr VSFrameContext,
                    core:ptr VSCore,
                    vsapi:ptr VSAPI ):ptr VSFrameRef {.cdecl,exportc.} =
    let d = cast[ptr CropData](instanceData[])

    if activationReason.VSActivationReason == arInitial:
        vsapi.requestFrameFilter(n.cint, d.node, frameCtx)

    elif activationReason.VSActivationReason == arAllFramesReady:
        let src:ptr VSFrameRef = vsapi.getFrameFilter(n.cint, d.node, frameCtx)

        # Create destination frame as a copy of the original one.
        let dst:ptr VSFrameRef = API.copyFrame(src, CORE)

        vsapi.freeFrame(src)       
        return dst
    return nil

proc cropFree1(instanceData:pointer, core:ptr VSCore, vsapi:ptr VSAPI) {.cdecl,exportc.} =
    let data = cast[ptr CropData](instanceData)
    vsapi.freeNode(data.node)
    dealloc(data)
    echo "[INFO] 'cropFree1' done"
    
proc Simple*(vsmap:ptr VSMap; x=none(int);y=none(int);width=none(int);height=none(int)):ptr VSMap =
    let tmpSeq = vsmap.toSeq    # Convert the VSMap into a sequence
    if tmpSeq.len == 0:
      raise newException(ValueError, "the vsmap should contain at least one item")
    if tmpSeq[0].nodes.len != 1:
      raise newException(ValueError, "the vsmap should contain one node")
    var clip = tmpSeq[0].nodes[0] # This is a node
    #var outnode:ptr VSNodeRef
    
    
    var tmpout = createMap()
    
    # UserData
    var d:CropData    
    d.node   = vsmap.propGetNode( "clip", 0 )
    d.vi     = API.getVideoInfo(d.node) #.getVideoInfo()
    # Defaults
    d.width  = 854
    d.height = 480
    d.x      = 10
    d.y      = 20 
    # Assign the function parameters if given
    if x.isSome: d.x = x.get
    if y.isSome: d.y = y.get
    if width.isSome: d.width = width.get
    if height.isSome: d.height = height.get
    
    # Move data to the heap
    var data1 = cast[ptr CropData]( alloc0(sizeof(d)) )
    data1[] = d    
   
    API.createFilter( vsmap, tmpout, 
                      "Crop1".cstring,
                      cropInit1, 
                      cropGetFrame1,
                      cropFree1,
                      fmParallel.cint, 
                      0.cint, 
                      data1,
                      CORE )
    return tmpout

#---------------------
#---   EXECUTION -----
#---------------------
# Reads the file, applies the Simple filter and saves the result in a file
Source("2sec.mkv").Simple.Savey4m("original.y4m")