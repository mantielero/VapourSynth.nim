 {.deadCodeElim: on.}
when defined(linux):
  const
    libname* = "libvapoursynth.so"
elif defined(windows):
  const
    libname* = "vapoursynth.dll"
else:
  const
    libname* = "libvapoursynth.dylib"
const
  VAPOURSYNTH_API_MAJOR* = 3
  VAPOURSYNTH_API_MINOR* = 6
  VAPOURSYNTH_API_VERSION* = (
    (VAPOURSYNTH_API_MAJOR shl 16) or (VAPOURSYNTH_API_MINOR))

type                          ##  all planar formats
  VSColorFamily* {.size: sizeof(cint).} = enum
    cmGray = 1000000, cmRGB = 2000000, cmYUV = 3000000, cmYCoCg = 4000000, ##  special for compatibility
    cmCompat = 9000000
  VSSampleType* {.size: sizeof(cint).} = enum
    stInteger = 0, stFloat = 1



##  The +10 is so people won't be using the constants interchangably "by accident"

type
  VSPresetFormat* {.size: sizeof(cint).} = enum
    pfNone = 0, pfGray8 = cmGray.int + 10, pfGray16, pfGrayH, pfGrayS, 
    pfRGB24 = cmRGB.ord + 10, pfRGB27,
    pfRGB30, pfRGB48, pfRGBH, pfRGBS, ##  special for compatibility, if you implement these in any filter I'll personally kill you
                                  ##  I'll also change their ids around to break your stuff regularly    
    pfYUV420P8 = cmYUV.int + 10,
    pfYUV422P8, pfYUV444P8, pfYUV410P8, pfYUV411P8, pfYUV440P8, pfYUV420P9,
    pfYUV422P9, pfYUV444P9, pfYUV420P10, pfYUV422P10, pfYUV444P10, pfYUV420P16,
    pfYUV422P16, pfYUV444P16, pfYUV444PH, pfYUV444PS, pfYUV420P12, pfYUV422P12,
    pfYUV444P12, pfYUV420P14, pfYUV422P14, pfYUV444P14, 
    pfCompatBGR32 = cmCompat.int + 10, pfCompatYUY2
  VSFilterMode* {.size: sizeof(cint).} = enum
    fmParallel = 100,           ##  completely parallel execution
    fmParallelRequests = 200,   ##  for filters that are serial in nature but can request one or more frames they need in advance
    fmUnordered = 300,          ##  for filters that modify their internal state every request
    fmSerial = 400
  VSFormat* {.bycopy.} = object
    name*: array[32, char]
    id*: cint
    colorFamily*: cint         ##  see VSColorFamily
    sampleType*: cint          ##  see VSSampleType
    bitsPerSample*: cint       ##  number of significant bits
    bytesPerSample*: cint      ##  actual storage is always in a power of 2 and the smallest possible that can fit the number of bits used per sample
    subSamplingW*: cint        ##  log2 subsampling factor, applied to second and third plane
    subSamplingH*: cint
    numPlanes*: cint           ##  implicit from colorFamily

  VSNodeFlags* {.size: sizeof(cint).} = enum
    nfNoCache = 1, nfIsCache = 2, nfMakeLinear = 4
  VSPropTypes* {.size: sizeof(cint).} = enum
    ptNode = 'c',
    ptFloat = 'f',    
    ptInt = 'i',    
    ptFunction = 'm',    
    ptData = 's',     
    ptUnset = 'u', 
    ptFrame = 'v'
  # I have introduced the peSuccess = 0 (not in the original API)
  VSGetPropErrors* {.size: sizeof(cint).} = enum
    peSuccess = 0, peUnset = 1, peType = 2, peIndex = 4
  VSPropAppendMode* {.size: sizeof(cint).} = enum
    paReplace = 0, paAppend = 1, paTouch = 2
  VSCoreInfo* {.bycopy.} = object
    versionString*: cstring
    core*: cint
    api*: cint
    numThreads*: cint
    maxFramebufferSize*: cint
    usedFramebufferSize*: cint

  VSVideoInfo* {.bycopy.} = object
    format*: ptr VSFormat
    fpsNum*: cint
    fpsDen*: cint
    width*: cint
    height*: cint
    numFrames*: cint           ##  api 3.2 - no longer allowed to be 0
    flags*: cint

  VSActivationReason* {.size: sizeof(cint).} = enum
    arError = -1, arInitial = 0, arFrameReady = 1, arAllFramesReady = 2
  VSMessageType* {.size: sizeof(cint).} = enum
    mtDebug = 0, mtWarning = 1, mtCritical = 2, mtFatal = 3









type
  VSMap*  {.bycopy.} = object
  VSCore*  {.bycopy.} = object   
  VSFrameRef*  {.bycopy.} = object
  VSNodeRef*  {.bycopy.} = object
  VSFuncRef*  {.bycopy.} = object     
  VSPlugin*  {.bycopy.} = object   
  VSFrameContext*  {.bycopy.} = object
  VSNode*  {.bycopy.} = object 

type
  VSPublicFunction* = proc (`in`: ptr VSMap; `out`: ptr VSMap; userData: pointer;
                         core: ptr VSCore; vsapi: ptr VSAPI) {.cdecl.}  
  VSAPI* {.bycopy.} = object
    createCore*: proc (threads: cint): ptr VSCore {.cdecl.}
    freeCore*: proc (core: ptr VSCore) {.cdecl.}
    getCoreInfo*: proc (core: ptr VSCore): ptr VSCoreInfo {.cdecl.} ##  deprecated as of api 3.6, use getCoreInfo2 instead
    cloneFrameRef*: proc (f: ptr VSFrameRef): ptr VSFrameRef {.cdecl.}
    cloneNodeRef*: proc (node: ptr VSNodeRef): ptr VSNodeRef {.cdecl.}
    cloneFuncRef*: proc (f: ptr VSFuncRef): ptr VSFuncRef {.cdecl.}
    freeFrame*: proc (f: ptr VSFrameRef) {.cdecl.}
    freeNode*: proc (node: ptr VSNodeRef) {.cdecl.}
    freeFunc*: proc (f: ptr VSFuncRef) {.cdecl.}
    newVideoFrame*: proc (format: ptr VSFormat; width: cint; height: cint;
                        propSrc: ptr VSFrameRef; core: ptr VSCore): ptr VSFrameRef {.
        cdecl.}
    copyFrame*: proc (f: ptr VSFrameRef; core: ptr VSCore): ptr VSFrameRef {.cdecl.}
    copyFrameProps*: proc (src: ptr VSFrameRef; dst: ptr VSFrameRef; core: ptr VSCore) {.
        cdecl.}
    registerFunction*: proc (name: cstring; args: cstring; argsFunc: VSPublicFunction;
                           functionData: pointer; plugin: ptr VSPlugin) {.cdecl.}
    getPluginById*: proc (identifier: cstring; core: ptr VSCore): ptr VSPlugin {.cdecl.}
    getPluginByNs*: proc (ns: cstring; core: ptr VSCore): ptr VSPlugin {.cdecl.}
    getPlugins*: proc (core: ptr VSCore): ptr VSMap {.cdecl.}
    getFunctions*: proc (plugin: ptr VSPlugin): ptr VSMap {.cdecl.}
    createFilter*: proc (`in`: ptr VSMap; `out`: ptr VSMap; name: cstring;
                       init: VSFilterInit; getFrame: VSFilterGetFrame;
                       free: VSFilterFree; filterMode: cint; flags: cint;
                       instanceData: pointer; core: ptr VSCore) {.cdecl.}
    setError*: proc (map: ptr VSMap; errorMessage: cstring) {.cdecl.} ##  use to signal errors outside filter getframe functions
    getError*: proc (map: ptr VSMap): cstring {.cdecl.} ##  use to query errors, returns 0 if no error
    setFilterError*: proc (errorMessage: cstring; frameCtx: ptr VSFrameContext) {.cdecl.} ##  use to signal errors in the filter getframe function
    invoke*: proc (plugin: ptr VSPlugin; name: cstring; args: ptr VSMap): ptr VSMap {.cdecl.}
    getFormatPreset*: proc (id: cint; core: ptr VSCore): ptr VSFormat {.cdecl.}
    registerFormat*: proc (colorFamily: cint; sampleType: cint; bitsPerSample: cint;
                         subSamplingW: cint; subSamplingH: cint; core: ptr VSCore): ptr VSFormat {.
        cdecl.}
    getFrame*: proc (n: cint; node: ptr VSNodeRef; errorMsg: cstring; bufSize: cint): ptr VSFrameRef {.
        cdecl.}               ##  do never use inside a filter's getframe function, for external applications using the core as a library or for requesting frames in a filter constructor
    getFrameAsync*: proc (n: cint; node: ptr VSNodeRef; callback: VSFrameDoneCallback;
                        userData: pointer) {.cdecl.} ##  do never use inside a filter's getframe function, for external applications using the core as a library or for requesting frames in a filter constructor
    getFrameFilter*: proc (n: cint; node: ptr VSNodeRef; frameCtx: ptr VSFrameContext): ptr VSFrameRef {.
        cdecl.}               ##  only use inside a filter's getframe function
    requestFrameFilter*: proc (n: cint; node: ptr VSNodeRef;
                             frameCtx: ptr VSFrameContext) {.cdecl.} ##  only use inside a filter's getframe function
    queryCompletedFrame*: proc (node: ptr ptr VSNodeRef; n: ptr cint;
                              frameCtx: ptr VSFrameContext) {.cdecl.} ##  only use inside a filter's getframe function
    releaseFrameEarly*: proc (node: ptr VSNodeRef; n: cint;
                            frameCtx: ptr VSFrameContext) {.cdecl.} ##  only use inside a filter's getframe function
    getStride*: proc (f: ptr VSFrameRef; plane: cint): cint {.cdecl.}
    getReadPtr*: proc (f: ptr VSFrameRef; plane: cint): ptr uint8 {.cdecl.}
    getWritePtr*: proc (f: ptr VSFrameRef; plane: cint): ptr uint8 {.cdecl.}
    createFunc*: proc (`func`: VSPublicFunction; userData: pointer;
                     free: VSFreeFuncData; core: ptr VSCore; vsapi: ptr VSAPI): ptr VSFuncRef {.
        cdecl.}
    callFunc*: proc (`func`: ptr VSFuncRef; `in`: ptr VSMap; `out`: ptr VSMap;
                   core: ptr VSCore; vsapi: ptr VSAPI) {.cdecl.} ##  core and vsapi arguments are completely ignored, they only remain to preserve ABI
                                                          ##  property access functions
    createMap*: proc (): ptr VSMap {.cdecl.}
    freeMap*: proc (map: ptr VSMap) {.cdecl.}
    clearMap*: proc (map: ptr VSMap) {.cdecl.}
    getVideoInfo*: proc (node: ptr VSNodeRef): ptr VSVideoInfo {.cdecl.}
    setVideoInfo*: proc (vi: ptr VSVideoInfo; numOutputs: cint; node: ptr VSNode) {.cdecl.}
    getFrameFormat*: proc (f: ptr VSFrameRef): ptr VSFormat {.cdecl.}
    getFrameWidth*: proc (f: ptr VSFrameRef; plane: cint): cint {.cdecl.}
    getFrameHeight*: proc (f: ptr VSFrameRef; plane: cint): cint {.cdecl.}
    getFramePropsRO*: proc (f: ptr VSFrameRef): ptr VSMap {.cdecl.}
    getFramePropsRW*: proc (f: ptr VSFrameRef): ptr VSMap {.cdecl.}
    propNumKeys*: proc (map: ptr VSMap): cint {.cdecl.}
    propGetKey*: proc (map: ptr VSMap; index: cint): cstring {.cdecl.}
    propNumElements*: proc (map: ptr VSMap; key: cstring): cint {.cdecl.}
    propGetType*: proc (map: ptr VSMap; key: cstring): char {.cdecl.}
    propGetInt*: proc (map: ptr VSMap; key: cstring; index: cint; error: ptr cint): cint {.cdecl.}
    propGetFloat*: proc (map: ptr VSMap; key: cstring; index: cint; error: ptr cint): cdouble {.
        cdecl.}
    propGetData*: proc (map: ptr VSMap; key: cstring; index: cint; error: ptr cint): cstring {.
        cdecl.}
    propGetDataSize*: proc (map: ptr VSMap; key: cstring; index: cint; error: ptr cint): cint {.
        cdecl.}
    propGetNode*: proc (map: ptr VSMap; key: cstring; index: cint; error: ptr cint): ptr VSNodeRef {.
        cdecl.}
    propGetFrame*: proc (map: ptr VSMap; key: cstring; index: cint; error: ptr cint): ptr VSFrameRef {.
        cdecl.}
    propGetFunc*: proc (map: ptr VSMap; key: cstring; index: cint; error: ptr cint): ptr VSFuncRef {.
        cdecl.}
    propDeleteKey*: proc (map: ptr VSMap; key: cstring): cint {.cdecl.}
    propSetInt*: proc (map: ptr VSMap; key: cstring; i: cint; append: cint): cint {.cdecl.}
    propSetFloat*: proc (map: ptr VSMap; key: cstring; d: cdouble; append: cint): cint {.
        cdecl.}
    propSetData*: proc (map: ptr VSMap; key: cstring; data: cstring; size: cint;
                      append: cint): cint {.cdecl.}
    propSetNode*: proc (map: ptr VSMap; key: cstring; node: ptr VSNodeRef; append: cint): cint {.
        cdecl.}
    propSetFrame*: proc (map: ptr VSMap; key: cstring; f: ptr VSFrameRef; append: cint): cint {.
        cdecl.}
    propSetFunc*: proc (map: ptr VSMap; key: cstring; `func`: ptr VSFuncRef; append: cint): cint {.
        cdecl.}
    setMaxCacheSize*: proc (bytes: cint; core: ptr VSCore): cint {.cdecl.}
    getOutputIndex*: proc (frameCtx: ptr VSFrameContext): cint {.cdecl.}
    newVideoFrame2*: proc (format: ptr VSFormat; width: cint; height: cint;
                         planeSrc: ptr ptr VSFrameRef; planes: ptr cint;
                         propSrc: ptr VSFrameRef; core: ptr VSCore): ptr VSFrameRef {.
        cdecl.}
    setMessageHandler*: proc (handler: VSMessageHandler; userData: pointer) {.cdecl.} ##  deprecated as of api 3.6, use addMessageHandler and removeMessageHandler instead
    setThreadCount*: proc (threads: cint; core: ptr VSCore): cint {.cdecl.}
    getPluginPath*: proc (plugin: ptr VSPlugin): cstring {.cdecl.} ##  api 3.1
    propGetIntArray*: proc (map: ptr VSMap; key: cstring; error: ptr cint): ptr cint {.
        cdecl.}
    propGetFloatArray*: proc (map: ptr VSMap; key: cstring; error: ptr cint): ptr cdouble {.
        cdecl.}
    propSetIntArray*: proc (map: ptr VSMap; key: cstring; i: ptr cint; size: cint): cint {.
        cdecl.}
    propSetFloatArray*: proc (map: ptr VSMap; key: cstring; d: ptr cdouble; size: cint): cint {.
        cdecl.}               ##  api 3.4
    logMessage*: proc (msgType: cint; msg: cstring) {.cdecl.} ##  api 3.6
    addMessageHandler*: proc (handler: VSMessageHandler; free: VSMessageHandlerFree;
                            userData: pointer): cint {.cdecl.}
    removeMessageHandler*: proc (id: cint): cint {.cdecl.}
    getCoreInfo2*: proc (core: ptr VSCore; info: ptr VSCoreInfo) {.cdecl.}


  ##  plugin function and filter typedefs

  VSRegisterFunction* = proc (name: cstring; args: cstring; argsFunc: VSPublicFunction;
                           functionData: pointer; plugin: ptr VSPlugin) {.cdecl.}
  VSConfigPlugin* = proc (identifier: cstring; defaultNamespace: cstring;
                       name: cstring; apiVersion: cint; readonly: cint;
                       plugin: ptr VSPlugin) {.cdecl.}
  VSInitPlugin* = proc (configFunc: VSConfigPlugin; registerFunc: VSRegisterFunction;
                     plugin: ptr VSPlugin) {.cdecl.}
  VSFreeFuncData* = proc (userData: pointer) {.cdecl.}
  VSFilterInit* = proc (`in`: ptr VSMap; `out`: ptr VSMap; instanceData: ptr pointer;
                     node: ptr VSNode; core: ptr VSCore; vsapi: ptr VSAPI) {.cdecl.}
  VSFilterGetFrame* = proc (n: cint; activationReason: cint; instanceData: ptr pointer;
                         frameData: ptr pointer; frameCtx: ptr VSFrameContext;
                         core: ptr VSCore; vsapi: ptr VSAPI): ptr VSFrameRef {.cdecl.}
  VSFilterFree* = proc (instanceData: pointer; core: ptr VSCore; vsapi: ptr VSAPI) {.cdecl.}

  ##  other
  VSFrameDoneCallback* = proc (userData: pointer; f: ptr VSFrameRef; n: cint;
                            a4: ptr VSNodeRef; errorMsg: cstring) {.cdecl.}
  VSMessageHandler* = proc (msgType: cint; msg: cstring; userData: pointer) {.cdecl.}
  VSMessageHandlerFree* = proc (userData: pointer) {.cdecl.}

##  core entry point

type
  VSGetVapourSynthAPI* = proc (version: cint): ptr VSAPI {.cdecl.}

#cast[ptr VSAPI](getVapourSynthAPI(int, version))  {.importc,dynlib: libName.}
proc getVapourSynthAPI*(version:cint):ptr VSAPI    {.importc,dynlib: libName.}

