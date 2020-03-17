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
#[
A filter’s "init" function.

This function is called by createFilter() (indirectly).

This is the only place where setVideoInfo() can be called. There is no reason to do anything else here.

If an error occurs in this function:
free the input nodes, if any

free the instance data

free whatever else got allocated so far (obviously)

call setError() on the out map

return

instanceData
   Pointer to a pointer to the filter’s private instance data.    
]#
proc cropInit1( `in`: ptr VSMap, 
                `out`: ptr VSMap, 
                userData: ptr pointer,   ## void **instanceData
                node: ptr VSNode,
                core: ptr VSCore, 
                vsapi: ptr VSAPI) {.cdecl,exportc.} =
  #var d:CropData #*d = cast[ptr CropData](userData)
  #let data:ptr CropData
  echo ">>>>>>>> INIT"
  let data = cast[ptr CropData](userData[])
  #echo repr data[].node

  #echo repr node

  #let data:CropData = cast[CropData](d)
  echo "---- CropData"
  echo repr data
  echo "Video Width: ", data.vi.width
  echo "Parameter \"width\": ", data.width
  vsapi.setVideoInfo(data.vi, 1.cint, node)

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
  echo "\n[INFO] Initialization done\n"



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



# --------------------------- CREATE ----------------------------
#[

static void VS_CC cropAbsCreate(const VSMap *in, VSMap *out, void *userData, VSCore *core, const VSAPI *vsapi) {
    char msg[150];
    CropData d;
    CropData *data;
    int err;

    d.x = int64ToIntS(vsapi->propGetInt(`in`, "left", 0, &err));
    if (err)
        d.x = int64ToIntS(vsapi->propGetInt(`in`, "x", 0, &err));
    d.y = int64ToIntS(vsapi->propGetInt(`in`, "top", 0, &err));
    if (err)
        d.y = int64ToIntS(vsapi->propGetInt(`in`, "y", 0, &err));

    d.height = int64ToIntS(vsapi->propGetInt(`in`, "height", 0, 0));
    d.width = int64ToIntS(vsapi->propGetInt(`in`, "width", 0, 0));
    d.node = vsapi->propGetNode(`in`, "clip", 0, 0);

    d.vi = vsapi->getVideoInfo(d.node);

    if (cropVerify(d.x, d.y, d.width, d.height, d.vi->width, d.vi->height, d.vi->format, msg, sizeof(msg))) {
        vsapi->freeNode(d.node);
        RETERROR(msg);
    }

    data = malloc(sizeof(d));
    *data = d;

    vsapi->createFilter(`in`, out, "Crop", cropInit, cropGetframe, singleClipFree, fmParallel, 0, data, core);
}
]#

proc cropFree1(instanceData:pointer, core:ptr VSCore, vsapi:ptr VSAPI) {.cdecl,exportc.} =
    #InvertData *d = (InvertData *)instanceData;
    #vsapi->freeNode(d->node);
    #free(d);
    echo repr instanceData
    let data = cast[ptr CropData](instanceData)
    vsapi.freeNode(data.node)
    #GCunref(data)
    dealloc(data)
    


proc cropAbsCreate1( `in`:ptr VSMap, 
                    `out`:ptr VSMap, 
                    userData: pointer, 
                    core:ptr VSCore, 
                    vsapi:ptr VSAPI) {.cdecl,exportc.} =
    echo "==== cropAbsCreate1 ===="
    var d:CropData
    #var data:ptr CropData 
    var err = peUnset.cint
    
    #d.node = vsapi->propGetNode(in, "clip", 0, 0);
    d.x = vsapi.propGetInt(`in`, "left", 0.cint, err).int
    
    if err != peUnset:
        d.x = vsapi.propGetInt(`in`, "x", 0.cint, err).int
    d.y = vsapi.propGetInt(`in`, "top", 0.cint, err).int
    if err != peUnset:
        d.y = vsapi.propGetInt(`in`, "y", 0.cint, err).int

    d.height = vsapi.propGetInt(`in`, "height".cstring, 0.cint, err).int
    d.width = vsapi.propGetInt(`in`, "width".cstring, 0.cint, err).int
    d.node = vsapi.propGetNode(`in`, "clip".cstring, 0.cint, err)

    d.vi = vsapi.getVideoInfo(d.node)

    #echo repr d
    #echo "Pointer to data ---> ", repr unsafeAddr(d)
    let tmp = cropVerify(d.x, d.y, d.width, d.height, d.vi.width, d.vi.height, d.vi.format)
    let ok  = tmp[0]
    let msg = tmp[1]
    #if ok:
    #    vsapi.freeNode(d.node)
    #    raise newException(ValueError, msg )



    # Pasa la información al heap (si no estaría fuera de scope)
    # d es información en la stack
    #data = malloc(sizeof(d)); # Crea espacio en el heap
    #*data = d
    #let data = cast[ptr CropData](unsafeAddr(d))
    #echo repr data
    # https://nim-lang.org/docs/manual.html#types-mixing-gc-ed-memory-with-ptr
    echo "Data in the heap"
    var data1 = cast[ptr CropData]( alloc0(sizeof(d)) )
    data1[] = d
    echo repr data1

    echo "========================"    
    vsapi.createFilter( `in`, `out`, 
                        "Crop1".cstring, 
                        cropInit1, 
                        cropGetframe1, 
                        cropFree1, 
                        fmParallel.cint, 
                        0.cint, 
                        data1,
                        core )



proc cropFree(userData:pointer) {.cdecl,exportc.}=
    discard



# Create a private function
#[
    node:ptr VSNodeRef
    vi:ptr VSVideoInfo
    x:int
    y:int
    width:int
    height:int
]#
#let d:CropData = 
let myfunc:ptr VSFuncRef = API.createFunc(cropAbsCreate1, cast[pointer](nil),cropFree, CORE, API) 

let `in` = Source("2sec.mkv")
var `out`:ptr VSMap




#-------------------------------------------------
API.callFunc(myfunc, `in`, `out`, CORE, API)

`out`.Savey4m("borrame.y4m")

#[
(in: ptr VSMap, out: ptr VSMap, userData: pointer, core: ptr VSCore, vsapi: ptr VSAPI){.cdecl, locks: <unknown>.}, typeof(nil), proc (userData: pointer){.noSideEffect, gcsafe, locks: 0.}, ptr VSCore, ptr VSAPI>


proc (func: VSPublicFunction, userData: pointer, free: VSFreeFuncData, core: ptr VSCore, vsapi: ptr VSAPI): ptr VSFuncRef{.cdecl.}

]#



#width:int;height:int;left:int:opt;top:int:opt;x:int:opt;y:int:opt
#[
proc Crop1*( vsmap:ptr VSMap; 
             width  = none(int); 
             height = none(int); 
             left  = none(int); 
             top = none(int);  
             x  = none(int); 
             y = none(int) ):ptr VSMap =
  let plug = getPluginById("com.holywu.deblock")
  if plug == nil:
    raise newException(ValueError, "plugin \"deblock\" not installed properly in your computer")

  let tmpSeq = vsmap.toSeq    # Convert the VSMap into a sequence
  if tmpSeq.len == 0:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")
  var clip = tmpSeq[0].nodes[0]


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()
  args.append("clip", clip)
  if quant.isSome: args.append("quant", quant.get)
  if aoffset.isSome: args.append("aoffset", aoffset.get)
  if boffset.isSome: args.append("boffset", boffset.get)
  if planes.isSome: args.set("planes", planes.get)

  return API.invoke(plug, "Deblock".cstring, args)   
]#




#Source("2sec.mkv").Crop1(width=some(300),height=some(200)).Savey4m("borrame.y4m")


