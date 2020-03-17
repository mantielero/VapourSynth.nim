import ../src/vapoursynth
#[
I have created a wrapper for a programming language called Nim: [URL="https://github.com/mantielero/VapourSynth.nim"]VapourSynth.nim[/URL]. I manage to call VapourSynth functions and plugin's functions as well. Now I would like to be able to use a function directly specified in Nim. Something similar to [URL="https://forum.doom9.org/showthread.php?t=172206"]this[/URL], but in Nim.

From what I am seeing I think I cannot get away without registering a function. So looking at [URL="https://github.com/vapoursynth/vapoursynth/blob/aa075b009fd4bdbf6aad7b4784092e79eb2f680c/src/core/simplefilters.c"]simplefilters.c[/URL], it looks like I have to do the following (from the end to the beggining):

1. Register the function (like [URL="https://github.com/vapoursynth/vapoursynth/blob/aa075b009fd4bdbf6aad7b4784092e79eb2f680c/src/core/simplefilters.c#L2522"]this[/URL]). I understand I have to call the wrapped function from Nim.
2. It refers to the [URL="https://github.com/vapoursynth/vapoursynth/blob/aa075b009fd4bdbf6aad7b4784092e79eb2f680c/src/core/simplefilters.c#L230"]create function[/URL]. The important thing from this function is that it [URL="https://github.com/vapoursynth/vapoursynth/blob/aa075b009fd4bdbf6aad7b4784092e79eb2f680c/src/core/simplefilters.c#L257"]creates the filter[/URL]. It looks like is resposible for creating the "data" and "d" structures (not very clear to me the difference, due to my lack of C knowledge). Populates the structure with information from the VSMap "in". The filter creation calls: cropInit, cropGetframe, singleClipFree
3. Then goes the [URL="https://github.com/vapoursynth/vapoursynth/blob/aa075b009fd4bdbf6aad7b4784092e79eb2f680c/src/core/simplefilters.c#L145"]initialization[/URL]. From the documentation, it is the place where the setVideoInfo is called.
4. [URL="https://github.com/vapoursynth/vapoursynth/blob/aa075b009fd4bdbf6aad7b4784092e79eb2f680c/src/core/simplefilters.c#L183"]getFrame[/URL] is where the modification of the frame takes places.

I am not sure if 

]#
# Define the structure where we will keep the information
#[
typedef struct {
    VSNodeRef *node;
    const VSVideoInfo *vi;
    int x;
    int y;
    int width;
    int height;
} CropData;     
]#

type
  CropData = object
    node:ptr VSNodeRef
    vi:ptr VSVideoInfo
    x:int
    y:int
    width:int
    height:int


#[
static void VS_CC cropInit(
      VSMap *in, 
      VSMap *out, 
      void **instanceData,
      VSNode *node, 
      VSCore *core, 
      const VSAPI *vsapi) 
{
    CropData *d = (CropData *) * instanceData;
    VSVideoInfo vi = *d->vi;
    vi.height = d->height;
    vi.width = d->width;
    vsapi->setVideoInfo(&vi, 1, node);
}
]#




# The following function is responsible for setting the video info. It will have the signature defined in the wrapper: `VSPublicFunction`
# {.exportc.}
proc testInit( `in`: ptr VSMap, 
               `out`: ptr VSMap, 
               userData: ptr pointer,   ## void **instanceData
               node: ptr VSNode,
               core: ptr VSCore, 
               vsapi: ptr VSAPI) {.cdecl,exportc.} =
    discard




#[
static int cropVerify(int x, int y, int width, int height, int srcwidth, int srcheight, const VSFormat *fi, char *msg, size_t len) {
    msg[0] = 0;

    if (y < 0 || x < 0)
        snprintf(msg, len, "Crop: negative corner coordinates not allowed");

    if (width <= 0 || height <= 0)
        snprintf(msg, len, "Crop: negative/zero cropping dimensions not allowed");

    if (srcheight > 0 && srcwidth > 0)
        if (srcheight < height + y || srcwidth < width + x)
            snprintf(msg, len, "Crop: cropped area extends beyond frame dimensions");

    if (fi) {
        if (width % (1 << fi->subSamplingW))
            snprintf(msg, len, "Crop: cropped area needs to have mod %d width", 1 << fi->subSamplingW);

        if (height % (1 << fi->subSamplingH))
            snprintf(msg, len, "Crop: cropped area needs to have mod %d height", 1 << fi->subSamplingH);

        if (x % (1 << fi->subSamplingW))
            snprintf(msg, len, "Crop: cropped area needs to have mod %d width offset", 1 << fi->subSamplingW);

        if (y % (1 << fi->subSamplingH))
            snprintf(msg, len, "Crop: cropped area needs to have mod %d height offset", 1 << fi->subSamplingH);
    }

    return !!msg[0];
}
]#


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
  
#---------------------------- GET FRAME ---------------------
#[
static const VSFrameRef *VS_CC cropGetframe(int n, int activationReason, void **instanceData, void **frameData, VSFrameContext *frameCtx, VSCore *core, const VSAPI *vsapi) {
    CropData *d = (CropData *) * instanceData;

    if (activationReason == arInitial) {
        vsapi->requestFrameFilter(n, d->node, frameCtx);
    } else if (activationReason == arAllFramesReady) {
        char msg[150];
        const VSFrameRef *src = vsapi->getFrameFilter(n, d->node, frameCtx);
        const VSFormat *fi = vsapi->getFrameFormat(src);
        int width = vsapi->getFrameWidth(src, 0);
        int height = vsapi->getFrameHeight(src, 0);
        int y = (fi->id == pfCompatBGR32) ? (height - d->height - d->y) : d->y;

        if (cropVerify(d->x, y, d->width, d->height, width, height, fi, msg, sizeof(msg))) {
            vsapi->freeFrame(src);
            vsapi->setFilterError(msg, frameCtx);
            return NULL;
        }

        VSFrameRef *dst = vsapi->newVideoFrame(fi, d->width, d->height, src, core);

        for (int plane = 0; plane < fi->numPlanes; plane++) {
            int srcstride = vsapi->getStride(src, plane);
            int dststride = vsapi->getStride(dst, plane);
            const uint8_t *srcdata = vsapi->getReadPtr(src, plane);
            uint8_t *dstdata = vsapi->getWritePtr(dst, plane);
            srcdata += srcstride * (y >> (plane ? fi->subSamplingH : 0));
            srcdata += (d->x >> (plane ? fi->subSamplingW : 0)) * fi->bytesPerSample;
            vs_bitblt(dstdata, dststride, srcdata, srcstride, (d->width >> (plane ? fi->subSamplingW : 0)) * fi->bytesPerSample, vsapi->getFrameHeight(dst, plane));
        }

        vsapi->freeFrame(src);

        if (d->y & 1) {
            VSMap *props = vsapi->getFramePropsRW(dst);
            int error;
            int64_t fb = vsapi->propGetInt(props, "_FieldBased", 0, &error);
            if (fb == 1 || fb == 2)
                vsapi->propSetInt(props, "_FieldBased", (fb == 1) ? 2 : 1, paReplace);
        }

        return dst;
    }

    return 0;
}
]#


proc myfunc(`in`:ptr VSMap, `out`: ptr VSMap, userData: pointer, core:ptr VSCore, vsapi:ptr VSAPI) = 
   #`out`= `in`
   #discard # do nothing
   vsapi.createFilter( `in`, `out`, 
                        "Crop1".cstring, 
                        testInit, 
                        testGetframe, 
                        singleClipFree, 
                        fmParallel.cint, 
                        0.cint, 
                        nil, #cast[pointer](unsafeAddr(d)), 
                        core)
   #void createFilter( const char *name, VSFilterInit init, VSFilterGetFrame getFrame, VSFilterFree free, int filterMode, int flags, void *instanceData, VSCore *core)

API.createFunc(myfunc, nil,free, CORE, API) 

proc cropGetFrame1(n:cint,
                  activationReason:cint,
                  instanceData:ptr pointer,
                  frameData:ptr pointer, 
                  frameCtx: ptr VSFrameContext,
                  core:ptr VSCore,
                  vsapi:ptr VSAPI):ptr VSFrameRef {.cdecl,exportc.} =
#[
    API.createFunc(VSPublicFunction func, 
                   void *userData, 
                   VSFreeFuncData free, 
                   VSCore *core, 
                   const VSAPI *vsapi)

    API.callFunc(VSFuncRef *func, const VSMap *in, VSMap *out, VSCore *core, const VSAPI *vsapi)
]#


    var d:CropData = cast[CropData](cast[ptr CropData](instanceData))

    if activationReason == arInitial:
        vsapi.requestFrameFilter(n.cint, d.node, frameCtx)

    elif activationReason == arAllFramesReady:
        #var msg:array[150, char]
        let src:ptr VSFrameRef = vsapi.getFrameFilter(n.cint, d.node, frameCtx)
        let fi:ptr VSFormat    = vsapi.getFrameFormat(src)
        let width:int = vsapi.getFrameWidth(src, 0.cint)   # For plane 0
        let height:int = vsapi.getFrameHeight(src, 0.cint) # For plane 0
        let y:int = if (fi.id == pfCompatBGR32): (height - d.height - d.y)
                    else: d.y

        let tmp = cropVerify(d.x, y, d.width, d.height, width, height, fi) 
        let ok  = tmp[0]
        let msg = tmp[1]
        if not ok:
            vsapi.freeFrame(src);
            vsapi.setFilterError(msg, frameCtx);
            return nil

        let dst:ptr VSFrameRef = vsapi.newVideoFrame(fi, d.width.cint, d.height.cint, src, core)

        for plane in 0..<fi.numPlanes:
            let srcstride:int = vsapi.getStride(src, plane)
            let dststride:int = vsapi.getStride(dst, plane)
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
        

        return dst
    return nil


proc Crop1*( vsmap:ptr VSMap; #in
             width  = none(int); 
             height = none(int); 
             left  = none(int); 
             top = none(int);  
             x  = none(int); 
             y = none(int) ):ptr VSMap =
  #let plug = getPluginById("com.holywu.deblock")
  #if plug == nil:
  #  raise newException(ValueError, "plugin \"deblock\" not installed properly #in your computer")

  let tmpSeq = vsmap.toSeq    # Convert the VSMap into a sequence
  if tmpSeq.len == 0:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]

  #-----
  # No es necesario leer esto de vsmap, porque tenemos los argumentos de la función.
  let d = vsmap.toSeq             # Read a sequence from the pointer
  let node = d[0].nodes[0]        # Read the first node
  let vinfo = getVideoInfo(node)
  #freeNode(node)


  #-----
  # INIT
  let args = createMap()

  #var vi:ptr VSVideoInfo   # VSVideoInfo vi = *d->vi;
  #[
    
      
  args.append("input", input)
  if sigma.isSome: args.set("sigma", sigma.get)
  if sigmaV.isSome: args.set("sigmaV", sigmaV.get)
  ]#
  #proc(vi:ptr VSVideoInfo, numOutputs:cint, node:ptr VSNode) 
  # TODO: crear aquí el nodo de salida
  API.setVideoInfo(vi, 1.cint, outnode) # 1 output

  var d:CropData = cast[CropData](userData)  # Take the information coming from the creation (Maybe a cast) 
  vi = d.vi
  vi.height = d.height.cint
  vi.width = d.width.cint
  vsapi.setVideoInfo(vi, 1, node)



  # Creamos el nodo de salida
  let outnode = new ptr VSNodeRef

# NOTA: VSNodeRef(node->clip,node->index)  # Esto es lo que llama la clonación de la referencia al nodo



  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()
  args.append("clip", clip)
  if quant.isSome: args.append("quant", quant.get)
  if aoffset.isSome: args.append("aoffset", aoffset.get)
  if boffset.isSome: args.append("boffset", boffset.get)
  if planes.isSome: args.set("planes", planes.get)

  return API.invoke(plug, "Deblock".cstring, args)   


#[
VS_EXTERNAL_API(void) VapourSynthPluginInit(VSConfigPlugin configFunc, VSRegisterFunction registerFunc, VSPlugin *plugin) {
    configFunc("com.example.invert", "invert", "VapourSynth Invert Example", VAPOURSYNTH_API_VERSION, 1, plugin);
    registerFunc("Filter", "clip:clip;enabled:int:opt;", invertCreate, 0, plugin);
}
]#







#Source("2sec.mkv").Crop1(width=some(300),height=some(200)).Savey4m("borrame.y4m")


#[
    I have been taking a look (with my very limited C knowledge) about `how to write a plugin  <http://www.vapoursynth.com/doc/api/vapoursynth.h.html#writing-plugins>`_ and also to `simplefilters.c <https://github.com/vapoursynth/vapoursynth/blob/master/src/core/simplefilters.c#L134>`_.

I already have a working wrapper (very limited), but I can call functions and plugin filters. (You can take a look `here <https://github.com/mantielero/VapourSynth.nim>`_).

I would like to avoid creating plugins, or registering functions. I would like to perform all the processing directly in Nim. Right now, in order to use any filter, I wrap it in a Nim function and call `invoke` within. How could I do 


]#

#[
    [Question] Manipulating frames without creating plugin/registering functions
]#


#[
void VSCore::createFilter(const VSMap *in, 
                          VSMap *out, 
                          const std::string &name, 
                          VSFilterInit init, 
                          VSFilterGetFrame getFrame, 
                          VSFilterFree free, 
                          VSFilterMode filterMode, 
                          int flags, 
                          void *instanceData, 
                          int apiMajor) {
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