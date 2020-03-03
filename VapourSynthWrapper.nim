import nimterop/types

defineEnum(VSColorFamily)
defineEnum(VSSampleType)
defineEnum(VSPresetFormat)
defineEnum(VSFilterMode)
defineEnum(VSNodeFlags)
defineEnum(VSGetPropErrors)
defineEnum(VSPropAppendMode)
defineEnum(VSActivationReason)
defineEnum(VSMessageType)
defineEnum(VSPropTypes)


const
  headerVapourSynth {.used.} = "./include/VapourSynth.h"
  VAPOURSYNTH_H* = ""
  VAPOURSYNTH_API_MAJOR* = 3
  VAPOURSYNTH_API_MINOR* = 5
  VAPOURSYNTH_API_VERSION* = 196613  #((3 shl 16) | (5))
  VS_EXTERN_C* = ""
  VS_NOEXCEPT* = ""
  VS_CC* = ""
  
  cmGray* = (1000000).VSColorFamily
  cmRGB* = (2000000).VSColorFamily
  cmYUV* = (3000000).VSColorFamily
  cmYCoCg* = (4000000).VSColorFamily
  cmCompat* = (9000000).VSColorFamily
  
  stInteger* = (0).VSSampleType
  stFloat* = (1).VSSampleType
  
  pfNone* = (0).VSPresetFormat
  pfGray8* = (1000010).VSPresetFormat
  pfGray16* = (1000011).VSPresetFormat
  pfGrayH* = (1000012).VSPresetFormat
  pfGrayS* = (1000013).VSPresetFormat
  pfYUV420P8* = (3000010).VSPresetFormat
  pfYUV422P8* = (3000011).VSPresetFormat
  pfYUV444P8* = (3000012).VSPresetFormat
  pfYUV410P8* = (3000013).VSPresetFormat
  pfYUV411P8* = (3000014).VSPresetFormat
  pfYUV440P8* = (3000015).VSPresetFormat
  pfYUV420P9* = (3000016).VSPresetFormat
  pfYUV422P9* = (3000017).VSPresetFormat
  pfYUV444P9* = (3000018).VSPresetFormat
  pfYUV420P10* = (3000019).VSPresetFormat
  pfYUV422P10* = (3000020).VSPresetFormat
  pfYUV444P10* = (3000021).VSPresetFormat
  pfYUV420P16* = (3000022).VSPresetFormat
  pfYUV422P16* = (3000023).VSPresetFormat
  pfYUV444P16* = (3000024).VSPresetFormat
  pfYUV444PH* = (3000025).VSPresetFormat
  pfYUV444PS* = (3000026).VSPresetFormat
  pfYUV420P12* = (3000027).VSPresetFormat
  pfYUV422P12* = (3000028).VSPresetFormat
  pfYUV444P12* = (3000029).VSPresetFormat
  pfYUV420P14* = (3000030).VSPresetFormat
  pfYUV422P14* = (3000031).VSPresetFormat
  pfYUV444P14* = (3000032).VSPresetFormat
  pfRGB24* = (2000010).VSPresetFormat
  pfRGB27* = (2000011).VSPresetFormat
  pfRGB30* = (2000012).VSPresetFormat
  pfRGB48* = (2000013).VSPresetFormat
  pfRGBH* = (2000014).VSPresetFormat
  pfRGBS* = (2000015).VSPresetFormat
  pfCompatBGR32* = (9000010).VSPresetFormat
  pfCompatYUY2* = (9000011).VSPresetFormat
  
  fmParallel* = (100).VSFilterMode
  fmParallelRequests* = (200).VSFilterMode
  fmUnordered* = (300).VSFilterMode
  fmSerial* = (400).VSFilterMode
  
  nfNoCache* = (1).VSNodeFlags
  nfIsCache* = (2).VSNodeFlags
  nfMakeLinear* = (4).VSNodeFlags
  
  peUnset* = (1).VSGetPropErrors
  peType* = (2).VSGetPropErrors
  peIndex* = (4).VSGetPropErrors
  
  paReplace* = (0).VSPropAppendMode
  paAppend* = (1).VSPropAppendMode
  paTouch* = (2).VSPropAppendMode
  
  arInitial* = (0).VSActivationReason
  arFrameReady* = (1).VSActivationReason
  arAllFramesReady* = (2).VSActivationReason
  arError* = (-1).VSActivationReason
  
  mtDebug* = (0).VSMessageType
  mtWarning* = (1).VSMessageType
  mtCritical* = (2).VSMessageType
  mtFatal* = (3).VSMessageType
  
  ptUnset* = ('u').VSPropTypes
  ptInt* = ('i').VSPropTypes
  ptFloat* = ('f').VSPropTypes
  ptData* = ('s').VSPropTypes
  ptNode* = ('c').VSPropTypes
  ptFrame* = ('v').VSPropTypes
  ptFunction* = ('m').VSPropTypes

{.pragma: impVapourSynth, importc, header: headerVapourSynth.}

 
type
  VSFrameRef*  {.importc: "struct VSFrameRef", header: headerVapourSynth, bycopy.} = object 
  
  VSNodeRef*  {.importc: "struct VSNodeRef", header: headerVapourSynth, bycopy.} = object 
  
  VSCore*  {.importc: "struct VSCore", header: headerVapourSynth, bycopy.} = object 
  
  VSPlugin*  {.importc: "struct VSPlugin", header: headerVapourSynth, bycopy.} = object 
  
  VSNode*  {.importc: "struct VSNode", header: headerVapourSynth, bycopy.} = object 
  
  VSFuncRef*  {.importc: "struct VSFuncRef", header: headerVapourSynth, bycopy.} = object 
  
  VSMap*  {.importc: "struct VSMap", header: headerVapourSynth, bycopy.} = object 
  
  VSAPI*  {.importc: "struct VSAPI", header: headerVapourSynth, bycopy.} = object 
    createCore*: proc(threads:cint):ptr VSCore
    freeCore*: proc(core:ptr VSCore)
    getCoreInfo*: proc(core:ptr VSCore):ptr VSCoreInfo
    cloneFrameRef*: proc(f:ptr VSFrameRef):ptr VSFrameRef
    cloneNodeRef*: proc(node:ptr VSNodeRef):ptr VSNodeRef
    cloneFuncRef*: proc(f:ptr VSFuncRef):ptr VSFuncRef
    freeFrame*: proc(f:ptr VSFrameRef)
    freeNode*: proc(node:ptr VSNodeRef)
    freeFunc*: proc(f:ptr VSFuncRef)
    newVideoFrame*: proc(format:ptr VSFormat, width:cint, height:cint, propSrc:ptr VSFrameRef, core:ptr VSCore):ptr VSFrameRef
    copyFrame*: proc(f:ptr VSFrameRef, core:ptr VSCore):ptr VSFrameRef
    copyFrameProps*: proc(src:ptr VSFrameRef, dst:ptr VSFrameRef, core:ptr VSCore)
    registerFunction*: proc(name:cstring, args:cstring, argsFunc:VSPublicFunction, functionData:pointer, plugin:ptr VSPlugin)
    getPluginById*: proc(identifier:cstring, core:ptr VSCore):ptr VSPlugin
    getPluginByNs*: proc(ns:cstring, core:ptr VSCore):ptr VSPlugin
    getPlugins*: proc(core:ptr VSCore):ptr VSMap
    getFunctions*: proc(plugin:ptr VSPlugin):ptr VSMap
    createFilter*: proc(`in`:ptr VSMap, `out`:ptr VSMap, name:cstring, init:VSFilterInit, getFrame:VSFilterGetFrame, free:VSFilterFree, filterMode:cint, flags:cint, instanceData:pointer, core:ptr VSCore)
    setError*: proc(map:ptr VSMap, errorMessage:cstring)
    getError*: proc(map:ptr VSMap):cstring
    setFilterError*: proc(errorMessage:cstring, frameCtx:ptr VSFrameContext)
    invoke*: proc(plugin:ptr VSPlugin, name:cstring, args:ptr VSMap):ptr VSMap
    getFormatPreset*: proc(id:cint, core:ptr VSCore):ptr VSFormat
    registerFormat*: proc(colorFamily:cint, sampleType:cint, bitsPerSample:cint, subSamplingW:cint, subSamplingH:cint, core:ptr VSCore):ptr VSFormat
    getFrame*: proc(n:cint, node:ptr VSNodeRef, errorMsg:cstring, bufSize:cint):ptr VSFrameRef
    getFrameAsync*: proc(n:cint, node:ptr VSNodeRef, callback:VSFrameDoneCallback, userData:pointer)
    getFrameFilter*: proc(n:cint, node:ptr VSNodeRef, frameCtx:ptr VSFrameContext):ptr VSFrameRef
    requestFrameFilter*: proc(n:cint, node:ptr VSNodeRef, frameCtx:ptr VSFrameContext)
    queryCompletedFrame*: proc(node:ptr ptr VSNodeRef, n:ptr cint, frameCtx:ptr VSFrameContext)
    releaseFrameEarly*: proc(node:ptr VSNodeRef, n:cint, frameCtx:ptr VSFrameContext)
    getStride*: proc(f:ptr VSFrameRef, plane:cint):cint
    getReadPtr*: proc(f:ptr VSFrameRef, plane:cint):ptr cuint  #uint8_t
    getWritePtr*: proc(f:ptr VSFrameRef, plane:cint):ptr cuint #uint8_t
    createFunc*: proc(`func`:VSPublicFunction, userData:pointer, free:VSFreeFuncData, core:ptr VSCore, vsapi:ptr VSAPI):ptr VSFuncRef
    callFunc*: proc(`func`:ptr VSFuncRef, `in`:ptr VSMap, `out`:ptr VSMap, core:ptr VSCore, vsapi:ptr VSAPI)
    createMap*: proc(None:void):ptr VSMap
    freeMap*: proc(map:ptr VSMap)
    clearMap*: proc(map:ptr VSMap)
    getVideoInfo*: proc(node:ptr VSNodeRef):ptr VSVideoInfo
    setVideoInfo*: proc(vi:ptr VSVideoInfo, numOutputs:cint, node:ptr VSNode)
    getFrameFormat*: proc(f:ptr VSFrameRef):ptr VSFormat
    getFrameWidth*: proc(f:ptr VSFrameRef, plane:cint):cint
    getFrameHeight*: proc(f:ptr VSFrameRef, plane:cint):cint
    getFramePropsRO*: proc(f:ptr VSFrameRef):ptr VSMap
    getFramePropsRW*: proc(f:ptr VSFrameRef):ptr VSMap
    propNumKeys*: proc(map:ptr VSMap):cint
    propGetKey*: proc(map:ptr VSMap, index:cint):cstring
    propNumElements*: proc(map:ptr VSMap, key:cstring):cint
    propGetType*: proc(map:ptr VSMap, key:cstring):cchar
    propGetInt*: proc(map:ptr VSMap, key:cstring, index:cint, error:ptr cint):int64
    propGetFloat*: proc(map:ptr VSMap, key:cstring, index:cint, error:ptr cint):cdouble
    propGetData*: proc(map:ptr VSMap, key:cstring, index:cint, error:ptr cint):cstring
    propGetDataSize*: proc(map:ptr VSMap, key:cstring, index:cint, error:ptr cint):cint
    propGetNode*: proc(map:ptr VSMap, key:cstring, index:cint, error:ptr cint):ptr VSNodeRef
    propGetFrame*: proc(map:ptr VSMap, key:cstring, index:cint, error:ptr cint):ptr VSFrameRef
    propGetFunc*: proc(map:ptr VSMap, key:cstring, index:cint, error:ptr cint):ptr VSFuncRef
    propDeleteKey*: proc(map:ptr VSMap, key:cstring):cint
    propSetInt*: proc(map:ptr VSMap, key:cstring, i:int64, append:cint):cint
    propSetFloat*: proc(map:ptr VSMap, key:cstring, d:cdouble, append:cint):cint
    propSetData*: proc(map:ptr VSMap, key:cstring, data:cstring, size:cint, append:cint):cint
    propSetNode*: proc(map:ptr VSMap, key:cstring, node:ptr VSNodeRef, append:cint):cint
    propSetFrame*: proc(map:ptr VSMap, key:cstring, f:ptr VSFrameRef, append:cint):cint
    propSetFunc*: proc(map:ptr VSMap, key:cstring, `func`:ptr VSFuncRef, append:cint):cint
    setMaxCacheSize*: proc(`bytes`:int64, `core`:ptr VSCore):int64
    getOutputIndex*: proc(frameCtx:ptr VSFrameContext):cint
    newVideoFrame2*: proc(format:ptr VSFormat, width:cint, height:cint, planeSrc:ptr ptr VSFrameRef, planes:ptr cint, propSrc:ptr VSFrameRef, core:ptr VSCore):ptr VSFrameRef
    setMessageHandler*: proc(handler:VSMessageHandler, userData:pointer)
    setThreadCount*: proc(threads:cint, core:ptr VSCore):cint
    getPluginPath*: proc(plugin:ptr VSPlugin):cstring
    propGetIntArray*: proc(map:ptr VSMap, key:cstring, error:ptr cint):ptr int64
    propGetFloatArray*: proc(map:ptr VSMap, key:cstring, error:ptr cint):ptr cdouble
    propSetIntArray*: proc(map:ptr VSMap, key:cstring, i:ptr int64, size:cint):cint
    propSetFloatArray*: proc(map:ptr VSMap, key:cstring, d:ptr cdouble, size:cint):cint
    logMessage*: proc(msgType:cint, msg:cstring)
  
  VSFrameContext*  {.importc: "struct VSFrameContext", header: headerVapourSynth, bycopy.} = object 
  
  VSFormat*  {.importc: "struct VSFormat", header: headerVapourSynth, bycopy.} = object 
    name*: array[32, cchar]
    id*: cint
    colorFamily*: cint
    sampleType*: cint
    bitsPerSample*: cint
    bytesPerSample*: cint
    subSamplingW*: cint
    subSamplingH*: cint
    numPlanes*: cint
  
  VSCoreInfo*  {.importc: "struct VSCoreInfo", header: headerVapourSynth, bycopy.} = object 
    versionString*: cstring
    core*: cint
    api*: cint
    numThreads*: cint
    maxFramebufferSize*: int64
    usedFramebufferSize*: int64
  
  VSVideoInfo*  {.importc: "struct VSVideoInfo", header: headerVapourSynth, bycopy.} = object 
    format*: ptr VSFormat
    fpsNum*: int64
    fpsDen*: int64
    width*: cint
    height*: cint
    numFrames*: cint
    flags*: cint
  

  VSPublicFunction* {.impVapourSynth.} = proc(`in`: ptr VSMap, `out`: ptr VSMap, userData: pointer, core: ptr VSCore, vsapi: ptr VSAPI) {.cdecl.}
  VSRegisterFunction* {.impVapourSynth.} = proc(name: cstring, args: cstring, argsFunc: VSPublicFunction, functionData: pointer, plugin: ptr VSPlugin) {.cdecl.}
  VSConfigPlugin* {.impVapourSynth.} = proc(identifier: cstring, defaultNamespace: cstring, name: cstring, apiVersion: cint, readonly: cint, plugin: ptr VSPlugin) {.cdecl.}
  VSInitPlugin* {.impVapourSynth.} = proc(configFunc: VSConfigPlugin, registerFunc: VSRegisterFunction, plugin: ptr VSPlugin) {.cdecl.}
  VSFreeFuncData* {.impVapourSynth.} = proc(userData: pointer) {.cdecl.}
  VSFilterInit* {.impVapourSynth.} = proc(`in`: ptr VSMap, `out`: ptr VSMap, instanceData: ptr pointer, node: ptr VSNode, core: ptr VSCore, vsapi: ptr VSAPI) {.cdecl.}
  VSFilterGetFrame* {.impVapourSynth.} = proc(n: cint, activationReason: cint, instanceData: ptr pointer, frameData: ptr pointer, frameCtx: ptr VSFrameContext, core: ptr VSCore, vsapi: ptr VSAPI):ptr VSFrameRef {.cdecl.}
  VSFilterFree* {.impVapourSynth.} = proc(instanceData: pointer, core: ptr VSCore, vsapi: ptr VSAPI) {.cdecl.}
  VSFrameDoneCallback* {.impVapourSynth.} = proc(userData: pointer, f: ptr VSFrameRef, n: cint, None: ptr VSNodeRef, errorMsg: cstring) {.cdecl.}
  VSMessageHandler* {.impVapourSynth.} = proc(msgType: cint, msg: cstring, userData: pointer) {.cdecl.}

proc VSGetVapourSynthAPI*(version: cint):ptr VSAPI {.cdecl,importc, header: headerVapourSynth, dynlib: "/home/jose/src/julia/vapoursynth/vapoursynth.so".}

#proc VSGetVapourSynthAPI*(version: cint):VSAPI {.cdecl,importc:"VSGetVapourSynthAPI", header: headerVapourSynth.}