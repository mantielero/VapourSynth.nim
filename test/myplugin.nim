import ../src/vapoursynth

type
  CropData = object
    node:ptr VSNodeRef
    vi:ptr VSVideoInfo
    x:int
    y:int
    width:int
    height:int


# The following function is responsible for setting the video info. It will have the signature defined in the wrapper: `VSPublicFunction`
# {.exportc.}
proc cropInit1( `in`: ptr VSMap, 
               `out`: ptr VSMap, 
               userData: ptr pointer,   ## void **instanceData
               node: ptr VSNode,
               core: ptr VSCore, 
               vsapi: ptr VSAPI) {.cdecl,exportc.} =
  let d:ptr CropData *d = cast[ptr CropData](userData)
  #vsapi->setVideoInfo(d->vi, 1, node);               
  var vi:ptr VSVideoInfo   # VSVideoInfo vi = *d->vi;
  vsapi.setVideoInfo(d.vi, 1.cint, node) # 1 output

  var d:CropData = cast[CropData](userData)  # Take the information coming from the creation (Maybe a cast) 
  vi = d.vi
  vi.height = d.height.cint
  vi.width = d.width.cint
  vsapi.setVideoInfo(vi, 1, node)


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
  
#---------------------------- GET FRAME ---------------------

proc cropGetFrame1(n:cint,
                  activationReason:cint,
                  instanceData:ptr pointer,
                  frameData:ptr pointer, 
                  frameCtx: ptr VSFrameContext,
                  core:ptr VSCore,
                  vsapi:ptr VSAPI):ptr VSFrameRef {.cdecl,exportc.} =
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



proc cropFree1(instanceData:pointer, core:ptr VSCore, vsapi:ptr VSAPI) {.cdecl,exportc.} =
    #InvertData *d = (InvertData *)instanceData;
    #vsapi->freeNode(d->node);
    #free(d);
    discard


# --------------------------- CREATE ----------------------------
proc cropAbsCreate1( `in`    : ptr VSMap, 
                     `out`   : ptr VSMap, 
                     userData: pointer, 
                     core    : ptr VSCore, 
                     vsapi   : ptr VSAPI ) {.cdecl,exportc.} =
    echo "Creating a filter"
    var d:CropData
    var data:ptr CropData
    var err = peUnset.cint

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

    let tmp = cropVerify(d.x, d.y, d.width, d.height, d.vi.width, d.vi.height, d.vi.format)
    let ok  = tmp[0]
    let msg = tmp[1]
    if ok:
        vsapi.freeNode(d.node)
        raise newException(ValueError, msg )

    #data = malloc(sizeof(d));
    #*data = d
    vsapi.createFilter( `in`, `out`, 
                        "Crop1".cstring, 
                        cropInit1, 
                        cropGetframe1, 
                        cropFree1, 
                        fmParallel.cint, 
                        0.cint, cast[pointer](unsafeAddr(d)), core)


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


