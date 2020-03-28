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
  #echo "[INFO] 'createFilter':'cropInit1': starting"
  let data = cast[ptr CropData](userData[])
  #echo "SETTING VIDEO INFO-----"
  #echo repr data.vi
  #echo repr node
  #echo "-----------------------\n\n\n"

  vsapi.setVideoInfo(data.vi, 1.cint, node)  # Set videoinfo in node
  #let vinfo = getVideoInfo( node)
  #echo repr vinfo
  #echo "[INFO] 'createFilter'>'cropInit1': DONE"

#[
proc (in: ptr VSMap, 
      out: var ptr VSMap, 
      userData: ptr pointer, 
      node: ptr VSNode, 
      core: ptr VSCore, 
      vsapi: ptr VSAPI){.cdecl, locks: <unknown>.}> 

proc (in: ptr VSMap, 
      out: ptr VSMap, 
      instanceData: ptr pointer, 
      node: ptr VSNode, 
      core: ptr VSCore, 
      vsapi: ptr VSAPI){.cdecl.}'

]#
proc cropGetFrame1( n:cint,
                    activationReason:cint,
                    instanceData:ptr pointer,
                    frameData:ptr pointer, 
                    frameCtx: ptr VSFrameContext,
                    core:ptr VSCore,
                    vsapi:ptr VSAPI ):ptr VSFrameRef {.cdecl,exportc.} =
    #var d:CropData = cast[CropData](cast[ptr CropData](instanceData))
    let d = cast[ptr CropData](instanceData[])
    #echo repr d.width
    #let fd = 

    if activationReason.VSActivationReason == arInitial:
        vsapi.requestFrameFilter(n.cint, d.node, frameCtx)

    elif activationReason.VSActivationReason == arAllFramesReady:
        let src:ptr VSFrameRef = vsapi.getFrameFilter(n.cint, d.node, frameCtx)
        let fi:ptr VSFormat    = d.vi.format  #vsapi.getFrameFormat(src)
        echo repr fi
        let width:int = vsapi.getFrameWidth(src, 0.cint).int   # For plane 0
        let height:int = vsapi.getFrameHeight(src, 0.cint).int # For plane 0
        let y:int = if (fi.id.VSPresetFormat == pfCompatBGR32): (height - d.height - d.y)
                    else: d.y

        #let dst:ptr VSFrameRef = vsapi.newVideoFrame( fi, d.width.cint, d.height.cint, src, core )
        let dst:ptr VSFrameRef = API.copyFrame(src, CORE)

        #[
        for row in 0..<plane.height:
          let address = cast[pointer](cast[int](plane.`ptr`) + row*plane.stride)
          strm.writeData(address, plane.width)
        ]#
        #[
        for plane in 0..<fi.numPlanes:
            let srcstride:int   = vsapi.getStride(src, plane)
            let dststride:int   = vsapi.getStride(dst, plane)
            var srcdata:pointer = vsapi.getReadPtr(src, plane)
            let dstdata:pointer = vsapi.getWritePtr(dst, plane)
            let tmpy = if plane > 0: fi.subSamplingH else: 0
            
            var tmp:int = if plane > 0: fi.subSamplingW else: 0
            let tmpx = (d.x shr tmp) * fi.bytesPerSample
            tmp = cast[int](srcdata) + srcstride * (y shr tmpy) + tmpx
            srcdata = cast[pointer](tmp)
        ]#
            #for row in 0..<plane.height:
            #  let srcAddress = cast[pointer](cast[int](plane.`ptr`) + row*plane.stride)


              #strm.writeData(address, plane.width)
            #srcdata += (d->x >> (plane ? fi->subSamplingW : 0)) * fi->bytesPerSample;
            #vs_bitblt(dstdata, dststride, srcdata, srcstride, (d->width >> (plane ? fi->subSamplingW : 0)) * fi->bytesPerSample, vsapi->getFrameHeight(dst, plane));
            #Copies bytes from one plane to another. Basically, it is memcpy in a loop.

#[
  static inline void vs_bitblt(void *dstp, int dst_stride, const void *srcp, int src_stride, size_t row_size, size_t height) {
    if (height) {
        if (src_stride == dst_stride && src_stride == (int)row_size) {
            memcpy(dstp, srcp, row_size * height);
        } else {
            const uint8_t *srcp8 = (const uint8_t *)srcp;
            uint8_t *dstp8 = (uint8_t *)dstp;
            size_t i;
            for (i = 0; i < height; i++) {
                memcpy(dstp8, srcp8, row_size);
                srcp8 += src_stride;
                dstp8 += dst_stride;
            }
        }
    }
}
]#
        #echo "ok1"
        vsapi.freeFrame(src)
        if (d.y and 1) > 0:  #(d.y and 1):  # No lo entiendo
            let props:ptr VSMap = vsapi.getFramePropsRW(dst)
            var err = peUnset.cint
            var perr = cast[ptr cint](unsafeAddr(err))  
            var fb:int = vsapi.propGetInt(props, "_FieldBased".cstring, 0.cint, perr).int
            if fb == 1 or fb == 2:
                let tmp = if fb == 1: 2
                          else: 1
                discard vsapi.propSetInt(props, "_FieldBased".cstring, tmp.cint, paReplace.cint)
        #echo "OK"        
        return dst
    return nil

proc cropFree1(instanceData:pointer, core:ptr VSCore, vsapi:ptr VSAPI) {.cdecl,exportc.} =
    echo "[INFO] Starting 'cropFree1'"
    echo repr instanceData
    let data = cast[ptr CropData](instanceData)
    vsapi.freeNode(data.node)
    #GCunref(data)
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

    #[
    echo "===== WHICH ONE IS nil ====="
    echo "IN:"    
    echo repr vsmap
    echo "OUT:"
    echo repr tmpout
    echo "cropInit1:"    
    echo repr cropInit1
    echo "cropGetFrame1:"
    echo repr cropGetFrame1
    echo "cropFree1:"
    echo repr cropFree1
    echo "data1"   
    echo repr data1
    echo "core"   
    echo repr CORE
    echo "==========================="    
    echo "[INFO] 'createFilter': starting"
    ]#

    #let tmp11:VSFilterInit = cropInit1
    #let tmp12:VSFilterGetFrame = cropGetFrame1
    #let tmp13:VSFilterFree = cropFree1     
    API.createFilter( vsmap, tmpout, 
                      "Crop1".cstring,
                      cropInit1, 
                      cropGetFrame1,
                      cropFree1,
                      fmParallel.cint, 
                      0.cint, 
                      data1,
                      CORE )
    #echo "\n\nOUTPUT MAP:"
    #echo repr tmpout.toSeq                      
    #tmpout.append("clip",outnode)
    #echo "[INFO] 'createFilter': DONE"                    
    #------------------
    #[
    let vinfo = getVideoInfo(clip)
    for i in 0..<vinfo.numFrames:
        #strm.writeLine("FRAME")
        let frame = clip.getFrame(i)                
        let format = frame.getFrameFormat.toFormat

        let dst:ptr VSFrameRef = API.newVideoFrame( frame.getFrameFormat, 
                                                    vinfo.width.cint, 
                                                    vinfo.height.cint, 
                                                    frame, CORE )

        for i in 0..<format.numPlanes:
          let plane = dst.getPlane(i)
          let address = dst.getWritePtr(i)
          let width = plane.width
          let height = plane.height
          for row in 0..<height:
            let newaddress = cast[pointer](cast[int](address) + row*plane.stride)
            for j in 0..10:
               let tmp = cast[int](newaddress) + j
               let address:ptr uint8 = cast[ptr uint8](tmp)
               address[] = 255.uint8
               #echo repr address, " ", address[]
            #strm.writeData(address, plane.width)          
    ]#
    # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
    #if planes.isSome: args.set("planes", planes.get)
    #var outclip = createMap()
    #outclip.append("clip", outnode)#clip)
    #echo "OK----"
    #echo repr tmpout
    return tmpout

#-------------------------------------------------
# Reads the file, applies the Simple filter and saves the result in a file
Source("2sec.mkv").Simple.Savey4m("original.y4m")
#let clip1 = Source("2sec.mkv")
#let clip2 = clip1.Simple
#clip2.Pipey4m

