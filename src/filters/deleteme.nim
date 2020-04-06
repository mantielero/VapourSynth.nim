import
  ../vapoursynth

type
  DrawFrameData {.bycopy.} = object
    node*: ptr VSNodeRef
    vi*: ptr VSVideoInfo
    width*: Natural
    height*: Natural

proc DrawFrameFree(userData`gensym21001059: pointer;
                  core`gensym21001060: ptr VSCore; vsapi`gensym21001061: ptr VSAPI) {.
    cdecl, exportc.} =
  var data`gensym21001062 = cast[ptr DrawFrameData](userData`gensym21001059)
  vsapi`gensym21001061.freeNode(data`gensym21001062.node)
  dealloc(data`gensym21001062)

proc DrawFrameInit(inclip`gensym21001063: ptr VSMap;
                  outclip`gensym21001064: ptr VSMap;
                  userData`gensym21001065: ptr pointer;
                  node`gensym21001066: ptr VSNode; core`gensym21001067: ptr VSCore;
                  vsapi`gensym21001068: ptr VSAPI) {.cdecl, exportc.} =
  let data`gensym21001069 = cast[ptr DrawFrameData](userData`gensym21001065[])
  let srcWidth`gensym21001070 = data`gensym21001069.vi.width
  let srcHeight`gensym21001071 = data`gensym21001069.vi.height
  let dstWidth`gensym21001072 = data`gensym21001069.width.cint
  let dstHeight`gensym21001073 = data`gensym21001069.height.cint
  data`gensym21001069.vi.width = dstWidth`gensym21001072
  data`gensym21001069.vi.height = dstHeight`gensym21001073
  vsapi`gensym21001068.setVideoInfo(data`gensym21001069.vi, 1.cint,
                                    node`gensym21001066)
  data`gensym21001069.vi.width = srcWidth`gensym21001070
  data`gensym21001069.vi.height = srcHeight`gensym21001071

proc DrawFrameGetFrame(n: cint; activationReason`gensym21001074: cint;
                      userData`gensym21001075: ptr pointer;
                      frameData`gensym21001076: ptr pointer;
                      frameCtx`gensym21001077: ptr VSFrameContext;
                      core`gensym21001078: ptr VSCore;
                      vsapi`gensym21001079: ptr VSAPI): ptr VSFrameRef {.cdecl,
    exportc.} =
  ## This function performs the data processing.
  ## 
  ## - `n`: frame number
  ## - `activationReason`:
  ## - `userData`: contains the data given by the user
  ## - `frameData`: ??
  ## - `frameCtx`: ??
  ## 
  let data = cast[ptr DrawFrameData](userData`gensym21001075[])
  if activationReason`gensym21001074.VSActivationReason == arInitial:
    vsapi`gensym21001079.requestFrameFilter(n, data.node, frameCtx`gensym21001077)
  elif activationReason`gensym21001074.VSActivationReason == arAllFramesReady:
    let src: ptr VSFrameRef = vsapi`gensym21001079.getFrameFilter(n, data.node,
        frameCtx`gensym21001077)
    let fi = vsapi`gensym21001079.getFrameFormat(src)
    let srcNumPlanes = fi.numPlanes
    let dst = src.newVideoFrame(data.width, data.height)
    let kernel: array[9, int32] = [1.int32, 2.int32, 1.int32, 2.int32, 4.int32, 2.int32,
                              1.int32, 2.int32, 1.int32]
    let den: int32 = 16
    let mul: int32 = 1
    apply_kernel(src, dst, kernel, mul, den)
    vsapi`gensym21001079.freeFrame(src)
    return dst
  return nil

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
