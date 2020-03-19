import ../src/vapoursynth

# Structure where the information is kept
type
  CropData* {.bycopy.} = object
    node*:ptr VSNodeRef
    vi*:ptr VSVideoInfo
    x*:int
    y*:int
    width*:int
    height*:int


proc cropInit1( `in`: ptr VSMap, 
                `out`: var ptr VSMap, 
                userData: ptr pointer,   ## void **instanceData
                node: ptr VSNode,
                core: ptr VSCore, 
                vsapi: ptr VSAPI) {.cdecl,exportc.} =
  ##[
  A filter’s "init" function.

  This function is called by createFilter() (indirectly).

  This is the only place where setVideoInfo() can be called. There is no reason to do anything else here.
  ]##
  #[


  If an error occurs in this function:
  
  - free the input nodes, if any

  - free the instance data

  - free whatever else got allocated so far (obviously)

  - call setError() on the out map

  return

  instanceData
     Pointer to a pointer to the filter’s private instance data.    
  ]#  
  #var d:CropData #*d = cast[ptr CropData](userData)
  #let data:ptr CropData
  echo "[INFO] 'cropAbsCreate1'>'createFilter':'cropInit1': starting"
  let data = cast[ptr CropData](userData[])
  #echo repr data[].node

  #echo repr node

  #let data:CropData = cast[CropData](d)
  #echo "---- CropData"
  #let in_node = data.node
  #echo repr data
  #echo "Video Width: ", data.vi.width
  #echo "Parameter \"width\": ", data.width
  vsapi.setVideoInfo(data.vi, 1.cint, node)  # Set videoinfo in node
  #let temp = vsapi.getVideoInfo(node)
  #echo repr temp

  #d.node = vsapi->propGetNode(in, "clip", 0, 0);
  #d.vi = vsapi->getVideoInfo(d.node);
  #var vi:ptr VSVideoInfo   # VSVideoInfo vi = *d->vi;

  #vsapi.setVideoInfo(d.vi, 1.cint, node) # 1 output

  #echo repr userData
  #echo "---- userData ----"
  #echo "===> ", repr userData   # Es el puntero a vi
  #let d:CropData = cast[CropData](data)    
  #echo repr d
  #echo "------------------"
  #let vi:ptr VSVideoInfo = cast[ptr VSVideoInfo](userData)
  #echo repr vi  
  #vi.height = d.height.cint
  #vi.width = d.width.cint

  #vsapi.setVideoInfo(vi, 1.cint, node)
  echo "[INFO] 'cropAbsCreate1'>'createFilter'>'cropInit1': DONE"


proc cropVerify( x,y,width,height,srcwidth,srcheight: int, fi:ptr VSFormat):tuple[ok:bool, msg:string] =
  var msg:string
  if x < 0 or y < 0:
    msg = "Crop: negative corner coordinates not allowed"
  elif width <= 0 or height <= 0:
    msg = "Crop: negative/zero cropping dimensions not allowed"
  elif srcheight > 0 and srcwidth > 0:
    if (srcheight < height + y) or  (srcwidth < width + x):
      msg = "Crop: cropped area extends beyond frame dimensions"
      
  #[
  if fi:
    if (width % (1 << fi->subSamplingW))
      snprintf(msg, len, "Crop: cropped area needs to have mod %d width", 1 << fi->subSamplingW);

    if (height % (1 << fi->subSamplingH))
      snprintf(msg, len, "Crop: cropped area needs to have mod %d height", 1 << fi->subSamplingH);

    if (x % (1 << fi->subSamplingW))
      snprintf(msg, len, "Crop: cropped area needs to have mod %d width offset", 1 << fi->subSamplingW);

    if (y % (1 << fi->subSamplingH))
      snprintf(msg, len, "Crop: cropped area needs to have mod %d height offset", 1 << fi->subSamplingH);
  ]#
  return (true, "")
  


proc cropGetFrame1( n:cint,
                    activationReason:cint,
                    instanceData:ptr pointer,
                    frameData:ptr pointer, 
                    frameCtx: ptr VSFrameContext,
                    core:ptr VSCore,
                    vsapi:ptr VSAPI ):ptr VSFrameRef {.cdecl,exportc.} =
    #var d:CropData = cast[CropData](cast[ptr CropData](instanceData))
    echo "[INFO] Starting GetFrame"
    let d = cast[ptr CropData](instanceData[])  
    #let fd = 

    if activationReason.VSActivationReason == arInitial:
        #echo repr d.node
        vsapi.requestFrameFilter(n.cint, d.node, frameCtx)

    elif activationReason.VSActivationReason == arAllFramesReady:
        #var msg:array[150, char]
        echo "Frame"
        let src:ptr VSFrameRef = vsapi.getFrameFilter(n.cint, d.node, frameCtx)
        let fi:ptr VSFormat    = d.vi.format  #vsapi.getFrameFormat(src)
        let width:int = vsapi.getFrameWidth(src, 0.cint).int   # For plane 0
        let height:int = vsapi.getFrameHeight(src, 0.cint).int # For plane 0
        let y:int = if (fi.id == pfCompatBGR32): (height - d.height - d.y)
                    else: d.y

        #[
        let tmp = cropVerify(d.x, y, d.width, d.height, width, height, fi) 
        let ok  = tmp[0]
        let msg = tmp[1]
        if not ok:
            vsapi.freeFrame(src);
            vsapi.setFilterError(msg, frameCtx);
            return nil
        ]#
        let dst:ptr VSFrameRef = vsapi.newVideoFrame( fi, d.width.cint, d.height.cint, src, core )
        
        for plane in 0..<fi.numPlanes:
            let srcstride:int   = vsapi.getStride(src, plane)
            let dststride:int   = vsapi.getStride(dst, plane)
            let srcdata:pointer = vsapi.getReadPtr(src, plane)
            let dstdata:pointer = vsapi.getWritePtr(dst, plane)
            #srcdata += srcstride * (y >> (plane ? fi->subSamplingH : 0));
            #srcdata += (d->x >> (plane ? fi->subSamplingW : 0)) * fi->bytesPerSample;
            #vs_bitblt(dstdata, dststride, srcdata, srcstride, (d->width >> (plane ? fi->subSamplingW : 0)) * fi->bytesPerSample, vsapi->getFrameHeight(dst, plane));
        

        vsapi.freeFrame(src)

        if (d.y and 1) > 0:  #(d.y and 1):  # No lo entiendo
            let props:ptr VSMap = vsapi.getFramePropsRW(dst)
            var error = peUnset.cint
            var fb:int = vsapi.propGetInt(props, "_FieldBased".cstring, 0.cint, error).int
            if fb == 1 or fb == 2:
                let tmp = if fb == 1: 2
                          else: 1
                discard vsapi.propSetInt(props, "_FieldBased".cstring, tmp.int64, paReplace.cint)
        
        echo "hola"
        return dst
    return nil

proc cropFree1(instanceData:pointer, core:ptr VSCore, vsapi:ptr VSAPI) {.cdecl,exportc.} =
    #InvertData *d = (InvertData *)instanceData;
    #vsapi->freeNode(d->node);
    #free(d);
    echo "[INFO] Starting 'cropFree1'"
    echo repr instanceData
    let data = cast[ptr CropData](instanceData)
    vsapi.freeNode(data.node)
    #GCunref(data)
    dealloc(data)
    echo "[INFO] 'cropFree1' done"
    


proc cropAbsCreate1( `in`:ptr VSMap, 
                     `out`:var ptr VSMap, 
                     userData: pointer, 
                     core:ptr VSCore, 
                     vsapi:ptr VSAPI ) {.cdecl,exportc.} =
    echo "[INFO] Starting 'cropAbsCreate1'"                     
    var d:CropData
    #var data:ptr CropData 
    var err = peUnset.cint
    
    #d.node = vsapi->propGetNode(in, "clip", 0, 0);
    #d.x = vsapi.propGetInt(`in`, "left", 0.cint, err).int
    
    if err != peUnset:
        d.x = vsapi.propGetInt(`in`, "x", 0.cint, err).int
    #d.y = vsapi.propGetInt(`in`, "top", 0.cint, err).int
    if err != peUnset:
        d.y = vsapi.propGetInt(`in`, "y", 0.cint, err).int

    d.height = vsapi.propGetInt(`in`, "height".cstring, 0.cint, err).int
    d.width = vsapi.propGetInt(`in`, "width".cstring, 0.cint, err).int
    d.node = vsapi.propGetNode(`in`, "clip".cstring, 0.cint, err)

    d.vi = vsapi.getVideoInfo(d.node)
    # Some values 
    d.width = 300
    d.height = 200
    d.x = 10
    d.y= 20

    #echo repr d
    #echo "Pointer to data ---> ", repr unsafeAddr(d)
    #let tmp = cropVerify(d.x, d.y, d.width, d.height, d.vi.width, d.vi.height, d.vi.format)
    #let ok  = tmp[0]
    #let msg = tmp[1]
    #if ok:
    #    vsapi.freeNode(d.node)
    #    raise newException(ValueError, msg )

    # Pasa la información al heap (si no estaría fuera de scope)
    # d es información en la stack
    # https://nim-lang.org/docs/manual.html#types-mixing-gc-ed-memory-with-ptr
    #echo "Data in the heap"
    var data1 = cast[ptr CropData]( alloc0(sizeof(d)) )
    data1[] = d
    #echo repr data1

    echo "===== WHICH ONE IS nil ====="
    echo "IN:"    
    echo repr `in`
    echo "OUT:"
    echo repr `out`
    echo "cropInit1:"    
    echo repr cropInit1
    echo "cropGetFrame1:"
    echo repr cropGetFrame1
    echo "cropFree1:"
    echo repr cropFree1
    echo "data1"   
    echo repr data1
    echo "core"   
    echo repr core
    echo "==========================="
    
    let tmp1:VSFilterInit     = cropInit1
    let tmp2:VSFilterGetFrame = cropGetFrame1
    let tmp3:VSFilterFree = cropFree1
    echo "[INFO] 'cropAbsCreate1' > calling 'createFilter' (fails after calling 'cropInit1')"
    vsapi.createFilter( `in`, `out`, 
                        "Crop1".cstring, 
                        cropInit1, 
                        cropGetFrame1, 
                        nil,#cropFree1, 
                        fmParallel.cint, 
                        0.cint, 
                        data1,
                        core )
    echo "[INFO] Filter creation: DONE"
    #return result

proc cropFree(userData: pointer) {.cdecl.} =
  echo repr userData
  let data = cast[ptr CropData](userData)
  #vsapi.freeNode(data.node)
  #GCunref(data)
  dealloc(data)


#=========================================================
# EXECUTION PHASE
#=========================================================
var tmpdata:CropData
let myfunc:ptr VSFuncRef = API.createFunc( cropAbsCreate1, 
                                           cast[pointer](unsafeAddr(tmpdata)), #cast[pointer](nil), #cast[pointer](unsafeAddr(a)), #
                                           nil, #cropFree, 
                                           CORE, 
                                           API) 
      
echo "[INFO] Function created by calling 'createFunc'"
# Apply "myfunc" to `in`
let `in` = Source("2sec.mkv")
echo "[INFO] `in` created"
var `out`:ptr VSMap  # `out` is declared, but contains 

echo "[INFO] Calling 'callFunc'"
`out` =createMap() 
#[
func
Function to be called.

in
Arguments passed to func.

out
Returned values from func.  
]#
API.callFunc(myfunc, `in`, `out`, nil, nil)

echo repr `out`
# Save the result in a file
`out`.Savey4m("deleteme.y4m")

