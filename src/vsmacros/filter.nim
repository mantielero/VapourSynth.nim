import macros
import options

template passTrough*() =
  outClip.append("clip", data.node)
  API.freeNode( data.node )
  return outClip


macro newFilter*(fname:untyped, body:untyped):untyped = 
  result = nnkStmtList.newTree()

  result.add quote do:
    import vapoursynth

  assert(body.kind == nnkStmtList) 

  let userDataType = newIdentNode(fname.strVal & "Data")  
  #=========================
  # CREATE THE MAIN FUNCTION
  #=========================
  # 1. proc MyNaMe*
  var newFunc = nnkProcDef.newTree()
  newFunc.add(  nnkPostfix.newTree(
      newIdentNode("*"),
      newIdentNode(fname.strVal)
    ),
    newEmptyNode(),
    newEmptyNode()
  )

  # 2. Function parameters
  # - Read the parameters
  var parameters:seq[tuple[name:NimNode, typ:NimNode, opt:bool]] = @[]
  if body[0].kind == nnkCall:
      if eqIdent(body[0][0], "parameters"):
        assert(body[0][1].kind == nnkStmtList)  
        for param in body[0][1]:
            # mandatory parameters
            if param.kind == nnkCommand:
                parameters &= (name:param[0], typ:param[1], opt: false)

            elif param.kind == nnkCall and eqIdent(param[0], "optional"):
                for item in param[1]:
                  parameters &= (name:item[0], typ:item[1], opt: true)

  # - Mandatory params
  var formalParams = nnkFormalParams.newTree()
  formalParams.add nnkPtrTy.newTree( newIdentNode("VSMap") )
  for p in parameters:
    if not p[2]:  # Mandatory params
      if p[1].strVal == "clip":
        formalParams.add nnkIdentDefs.newTree(
          newIdentNode(p[0].strVal),
          nnkPtrTy.newTree(
            newIdentNode("VSMap")
          ),
          newEmptyNode()
          )  
      # TODO: [clip]
      # TODO: any other case
    else:   # Optional params
      formalParams.add nnkIdentDefs.newTree(
        newIdentNode(p[0].strVal),
        newEmptyNode(),
        nnkCall.newTree(
          newIdentNode("none"),
          newIdentNode(p[1].strVal)
        )
      )
  newFunc.add( formalParams, newEmptyNode(), newEmptyNode() )

  # FUNCTION BODY
  var funcBody = nnkStmtList.newTree()
  # - Add one node for "clip" arguments
  for p in parameters:
    if p[1].strVal == "clip":
      let clipName = newIdentNode( p[0].strVal )
      funcBody.add quote do:
        checkContainsJustOneNode(`clipName`)

  let dataSymbol = newIdentNode("data")
  funcBody.add quote do:
    var `dataSymbol`: `userDataType`


  for p in parameters:
    let field = p[0]
    if p[1].strVal == "clip":  
      funcBody.add quote do:
        data.node = `field`.propGetNode("clip", 0)
        data.vi = API.getVideoInfo(data.node)   # This will become the output's video info

    else:
      funcBody.add quote do:
        data.`field` = if `field`.isSome: `field`.get  else: 0

  let divHorizontal = newIdentNode("divHorizontal")
  let divVertical = newIdentNode("divVertical")
  let outClip = newIdentNode("outClip")  
  funcBody.add quote do:
    let `divHorizontal` = 1 shl data.vi.format.subSamplingW
    let `divVertical` = 1 shl data.vi.format.subSamplingH
    var `outClip`: ptr VSMap = createMap()

  # Insert the macro's body part
  
  assert (body[1].kind == nnkCall)
  if eqIdent( body[1][0], "validation"):
    let validationLines = body[1][1]
    #let inClip = newIdentNode(  )
    funcBody.add quote do:
      # Validation lines from the "validation:" macro section
      `validationLines`
      #freeFrame(inClip)
      
#[

  nnkAsgn.newTree(
    nnkBracketExpr.newTree(
      newIdentNode("dataInHeap")
    ),
    newIdentNode("data")
  )

]#
  let freeFuncName = newIdentNode(fname.strVal & "Free")
  let initFuncName = newIdentNode(fname.strVal & "Init")  #genSym()  
  let getFrameFunction = newIdentNode(fname.strVal & "GetFrame")  
  let dataInHeap = newIdentNode("dataInHeap")
  let dataAssigment = nnkAsgn.newTree( nnkBracketExpr.newTree( dataInHeap ),  dataSymbol )

  funcBody.add quote do:
    # Move data into the heap
    var `dataInHeap` = cast[ptr `userDataType`](alloc0(sizeof(data)))
    #dataInHeap[] = data
    `dataAssigment`
    #`dataInHeap`[] = `dataSymbol`
    # Create filter    
    API.createFilter( inClip, `outClip`,       # Don't touch me
                    "Thisisafilter".cstring,   # Useless (I believe), but aim to make it unique
                    `initFuncName`,            # The initialization function name
                    `getFrameFunction`,        # The function performing the frame modification
                    `freeFuncName`,            # Needed only if using user input
                    fmParallel.cint, 
                    0.cint, 
                    cast[pointer](`dataInHeap`),
                    CORE )
    return `outClip`

  newFunc.add funcBody

  #================
  # Create the type
  #================
  # 1. Minimum fields: NODE and VideoInfo  


  var newType2 = nnkRecList.newTree()
  let alwaysAdd = @[("node",   "VSNodeRef",   true), # true for pointer
                    ("vi",     "VSVideoInfo", true),
                    ("width",  "Natural",     false),
                    ("height", "Natural",     false) ]
                  
  for p in alwaysAdd:
    var thefield = nnkPostfix.newTree(
              newIdentNode("*"),
              newIdentNode(p[0])
            )
    var thetype = newIdentNode(p[1])
    thetype = if p[2]: nnkPtrTy.newTree( thetype ) else: thetype
    newType2.add  nnkIdentDefs.newTree(
            thefield,
            thetype,
            newEmptyNode() )
   

  for p in parameters:
    if p[1].strVal != "clip":
      var thefield = nnkPostfix.newTree(
              newIdentNode("*"),
              newIdentNode(p[0].strVal)
            )      
      newType2.add  nnkIdentDefs.newTree(
            thefield,
            newIdentNode(p[1].strVal),
            newEmptyNode() )      


  var newType = quote do:
    type
      `userDataType` {.bycopy.} = object

  # Replace the fields in the defined type
  newType[0][2].del(2)
  newType[0][2].add newType2 #.astGenRepr #treeRepr

  
  #echo repr newType
  #echo newType.astGenRepr

  # ADD the type
  #
  result.add newType   # UserData type definition

  # ADD freeFunc

  result.add quote do:
    proc `freeFuncName`(userData:pointer, core:ptr VSCore, vsapi:ptr VSAPI) {.cdecl,exportc.} =
      var data = cast[ptr `userDataType`](userData)
      vsapi.freeNode(data.node)
      dealloc(data)

  # ADD initFunc
  result.add quote do:
    proc `initFuncName`( inclip: ptr VSMap, outclip: ptr VSMap, userData: ptr pointer, node: ptr VSNode, core: ptr VSCore, vsapi: ptr VSAPI) {.cdecl,exportc.} =  
      let data = cast[ptr `userDataType`](userData[])
      # Source Video Info
      let srcWidth  = data.vi.width
      let srcHeight = data.vi.height
      let dstWidth  = data.width.cint
      let dstHeight = data.height.cint   
      data.vi.width = dstWidth
      data.vi.height = dstHeight      

      # Just copy the Video Info to the output
      vsapi.setVideoInfo(data.vi, 1.cint, node)  # Set videoinfo in node 
      data.vi.width = srcWidth
      data.vi.height = srcHeight        

#[
  var dataInHeap = cast[ptr MyCropRelData](alloc0(sizeof(data)))
  dataInHeap[] = data
]#

  # ADD getFrameFunc
  assert (body[2].kind == nnkCall)
  let processingBody = body[2][1]
  let srcSymbol = newIdentNode("src")  
  let fi = newIdentNode("fi") 
  let srcNumPlanes = newIdentNode("srcNumPlanes")
  let n = newIdentNode("n")  
  if eqIdent( body[2][0], "processing"):
    result.add quote do:
      proc `getFrameFunction`( `n`:cint, activationReason:cint, userData:ptr pointer, frameData:ptr pointer, frameCtx: ptr VSFrameContext, core:ptr VSCore, vsapi:ptr VSAPI ):ptr VSFrameRef {.cdecl,exportc.} =
        ##[
        This function performs the data processing.

        - `n`: frame number
        - `activationReason`:
        - `userData`: contains the data given by the user
        - `frameData`: ??
        - `frameCtx`: ??
        ]##
        let `dataSymbol` = cast[ptr `userDataType`](userData[])
        if activationReason.VSActivationReason == arInitial:     
            # The following requests a frame from a node and returns immediately.
            # The requested frame can then be retrieved using `getFrameFilter`, 
            # when the filter’s activation reason is `arAllFramesReady` or `arFrameReady`.
            vsapi.requestFrameFilter(`n`, data.node, frameCtx)

        elif activationReason.VSActivationReason == arAllFramesReady:
            # It is safe to request a frame more than once. An unimportant consequence
            # of requesting a frame more than once is that the getframe function may be
            # called more than once for the same frame with reason arFrameReady.
            # It is best to request frames in ascending order, i.e. n, n+1, n+2, etc.
            #let borrame = vsapi.getFrameFilter(50, data.node, frameCtx)
            let `srcSymbol`:ptr VSFrameRef = vsapi.getFrameFilter(`n`, data.node, frameCtx)
            let `fi` = vsapi.getFrameFormat(src)  # Format Information
            #let `srcNumPlanes` =  `fi`.numPlanes
            #echo `srcNumPlanes`
            #let srcNumPlanes = fi.numPlanes
            # Message: if you use this in a filter (I will kill you)
            #let y = if (fi.id == pfCompatBGR32): (height - d.height - d.top) : d.top
            
            #------
            `processingBody` 

            #-------
            #echo repr vsapi.getFrameFormat(dst)
            vsapi.freeFrame(src)       
            #echo repr dst
            #if (d.top and 1) {
            #    VSMap *props = vsapi->getFramePropsRW(dst);
            #    int error;
            #    int64_t fb = vsapi->propGetInt(props, "_FieldBased", 0, &error);
            #    if (fb == 1 || fb == 2)
            #        vsapi->propSetInt(props, "_FieldBased", (fb == 1) ? 2 : 1, paReplace);
                  
            return dst
        return nil
    
  # ADD filter custom function        
  result.add newFunc


  echo repr result

#[
dumpAstGen:
  type 
    hello = object
      hola:ptr VSNodeRef


dumptree:
  return outClip
]#
