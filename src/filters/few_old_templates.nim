import macros
import ../vapoursynth
import options

proc checkContainsJustOneNode*(inClip:ptr VSMap) =
  let tmpSeq = inClip.toSeq    # Convert the VSMap into a sequence
  if tmpSeq.len == 0:
    raise newException(ValueError, "the vsmap should contain at least one item")
  if tmpSeq[0].nodes.len != 1:
    raise newException(ValueError, "the vsmap should contain one node")

template passtrough*() =
  outClip.append("clip", data.node)
  API.freeNode( data.node )
  return outClip

#[
template createFreeFunc*(fname:untyped) =
  # Creates 
  proc `fname Free`(userData:pointer, core:ptr VSCore, vsapi:ptr VSAPI) {.cdecl,exportc.} =
    let data = cast[ptr `fname Data`](userData)
    vsapi.freeNode(data.node)
    dealloc(data)
]#

# TODO This should contain just the assignment of width and height
#[
template createInitFunc*(fname:untyped) =
  # Don't touch the following function signature
  # This function sets the VideoInfo data for the output node
  # No need to modify it unless you change size or format of the output frame.  
  proc `fname Init`( `in`: ptr VSMap, 
              `out`: ptr VSMap, 
              userData: ptr pointer, 
              node: ptr VSNode,
              core: ptr VSCore, 
              vsapi: ptr VSAPI) {.cdecl,exportc.} =
    let data = cast[ptr `fname Data`](userData[])
    var vi = API.getVideoInfo( data.node ) # NOTE: I think "vi" is not necessary in userData
    vi.width  = data.width.cint  
    vi.height = data.height.cint
    #data.vi.width = vi.width
    #data.vi.height = vi.height
    #echo repr vi
    echo "Source node: ", repr data.node
    echo "Dest node: ", repr node
    vsapi.setVideoInfo(vi, 1.cint, node)  # Set videoinfo in node
]#
#[
template createGetFrameFunc*(fname:untyped, body:untyped) {.dirty.}=
  # Don't touch the following function signature
  proc `fname GetFrame`( n:cint,
                         activationReason:cint,
                         userData:ptr pointer,
                         frameData:ptr pointer, 
                         frameCtx: ptr VSFrameContext,
                         core:ptr VSCore,
                         vsapi:ptr VSAPI ):ptr VSFrameRef {.cdecl,exportc.} =
    ##[
    This function performs the data processing.

    - `n`: frame number
    - `activationReason`:
    - `userData`: contains the data given by the user
    - `frameData`: ??
    - `frameCtx`: ??
    ]##
    let data = cast[ptr `fname Data`](userData[])
    echo repr data
    if activationReason.VSActivationReason == arInitial:     
        # The following requests a frame from a node and returns immediately.
        # The requested frame can then be retrieved using `getFrameFilter`, 
        # when the filter’s activation reason is `arAllFramesReady` or `arFrameReady`.
        vsapi.requestFrameFilter(n.cint, data.node, frameCtx)
        echo "Source video info: ", getVideoInfo(data.node)

    elif activationReason.VSActivationReason == arAllFramesReady:
        echo ">>>>>>>>>>>>>>> arAllFramesReady"     
        # It is safe to request a frame more than once. An unimportant consequence
        # of requesting a frame more than once is that the getframe function may be
        # called more than once for the same frame with reason arFrameReady.
        # It is best to request frames in ascending order, i.e. n, n+1, n+2, etc.
        let src:ptr VSFrameRef = vsapi.getFrameFilter(n.cint, data.node, frameCtx)
        let fi = vsapi.getFrameFormat(src)  # Format Information
        #echo repr fi
        # Message: if you use this in a filter (I will kill you)
        #let y = if (fi.id == pfCompatBGR32): (height - d.height - d.top) : d.top
        
        #------
        body

        #-------
        #echo repr vsapi.getFrameFormat(dst)
        vsapi.freeFrame(src)       

        #if (d.top and 1) {
        #    VSMap *props = vsapi->getFramePropsRW(dst);
        #    int error;
        #    int64_t fb = vsapi->propGetInt(props, "_FieldBased", 0, &error);
        #    if (fb == 1 || fb == 2)
        #        vsapi->propSetInt(props, "_FieldBased", (fb == 1) ? 2 : 1, paReplace);
              
        return dst
    return nil
]#

template createfilter*(name:untyped) =
  # TODO: `inClip` should be a parameter
  # TODO: to change filter name
  API.createFilter( inClip, outClip,       # Don't touch me
                    "Thisisafilter".cstring,  # Useless (I believe), but aim to make it unique
                    `name Init`,            # The initialization function name
                    `name GetFrame`,        # The function performing the frame modification
                    `name Free`,            # Needed only if using user input
                    fmParallel.cint, 
                    0.cint, 
                    dataInHeap,
                    CORE )  



macro newFilter*(fname:untyped, body:untyped):untyped = 
  assert(body.kind == nnkStmtList) 

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

  var funcBody = nnkStmtList.newTree()
  # - Add one node for "clip" arguments
  for p in parameters:
    if p[1].strVal == "clip":
      let clipName = newIdentNode( p[0].strVal )
      funcBody.add quote do:
        checkContainsJustOneNode(`clipName`)

  let dataSymbol = newIdentNode("data")
  funcBody.add quote do:
    var `dataSymbol`: MyCropRelData
  #funcBody.add nnkVarSection.newTree(
  #  nnkIdentDefs.newTree(
  #    newIdentNode("data"),
  #    newIdentNode( fname.strVal & "Data"),
  #    newEmptyNode()
  #  )
  #)

  for p in parameters:
    if p[1].strVal == "clip":
      funcBody.add nnkAsgn.newTree(
        nnkDotExpr.newTree(
          newIdentNode("data"),
          newIdentNode("node")
        ),
        nnkCall.newTree(
          nnkDotExpr.newTree(
            newIdentNode(p[0].strVal),
            newIdentNode("propGetNode")
          ),
          newLit("clip"),
          newLit(0)
        )
      )

      funcBody.add nnkAsgn.newTree(
        nnkDotExpr.newTree(
          newIdentNode("data"),
          newIdentNode("vi")
        ),
        nnkCall.newTree(
          nnkDotExpr.newTree(
            newIdentNode("API"),
            newIdentNode("getVideoInfo")
          ),
          nnkDotExpr.newTree(
            newIdentNode("data"),
            newIdentNode("node")
          )
        )
      )
    else:
      funcBody.add   nnkAsgn.newTree(
        nnkDotExpr.newTree(
          newIdentNode("data"),
          newIdentNode(p[0].strVal)
        ),
        nnkIfExpr.newTree(
          nnkElifExpr.newTree(
            nnkDotExpr.newTree(
              newIdentNode(p[0].strVal),
              newIdentNode("isSome")
            ),
            nnkStmtList.newTree(
              nnkDotExpr.newTree(
                newIdentNode(p[0].strVal),
                newIdentNode("get")
              )
            )
          ),
          nnkElseExpr.newTree(
            nnkStmtList.newTree(
              newLit(0)
            )
          )
        )
      )



  let divHorizontal = newIdentNode("divHorizontal")
  let divVertical = newIdentNode("divVertical")
  let outClip = newIdentNode("outClip")  
  funcBody.add quote do:
    echo "----------------"
    data.node = inClip.propGetNode("clip", 0)
    data.vi = API.getVideoInfo(data.node)
    data.left = if left.isSome:
      left.get else:
      0
    data.right = if right.isSome:
      right.get else:
      0
    data.top = if top.isSome:
      top.get else:
      0
    data.bottom = if bottom.isSome:
      bottom.get else:
      0
    let `divHorizontal` = 1 shl data.vi.format.subSamplingW
    let `divVertical` = 1 shl data.vi.format.subSamplingH
    var `outClip`: ptr VSMap = createMap()
    echo "----------------"

  
  # Move data into the heap
  #[
  funcBody.add nnkVarSection.newTree(
      nnkIdentDefs.newTree(
        newIdentNode("dataInHeap"),
        newEmptyNode(),
        nnkCast.newTree(
          nnkPtrTy.newTree(
            newIdentNode( fname.strVal & "Data")
          ),
          nnkCall.newTree(
            newIdentNode("alloc0"),
            nnkCall.newTree(
              newIdentNode("sizeof"),
              newIdentNode("data")
            ) ) ) ) )
  ]#


  #funcBody.add  nnkAsgn.newTree(
  #    nnkBracketExpr.newTree(
  #      newIdentNode("dataInHeap")
  #    ),
  #    newIdentNode("data")
  #  )

  # Insert the macro's body part
  
  assert (body[1].kind == nnkCall)
  if eqIdent( body[1][0], "validation"):
    let validationLines = body[1][1]
    funcBody.add quote do:
      # Validation lines from the "validation:" macro section
      `validationLines`
      

  let freeFuncName = newIdentNode(fname.strVal & "Free")
  let initFuncName = newIdentNode(fname.strVal & "Init")  #genSym()  
  let getFrameFunction = newIdentNode(fname.strVal & "GetFrame")  
  let dataInHeap = newIdentNode("dataInHeap")
  funcBody.add quote do:
    var `dataInHeap` = cast[ptr MyCropRelData](alloc0(sizeof(data)))
    dataInHeap[] = data
    
    API.createFilter( inClip, outClip,       # Don't touch me
                    "Thisisafilter".cstring,  # Useless (I believe), but aim to make it unique
                    `initFuncName`,            # The initialization function name
                    `getFrameFunction`,        # The function performing the frame modification
                    `freeFuncName`,            # Needed only if using user input
                    fmParallel.cint, 
                    0.cint, 
                    dataInHeap,
                    CORE )
    return outClip

  #funcBody.add  nnkCall.newTree(
  #    newIdentNode("createfilter"),
  #    newIdentNode(fname.strVal)
  #  )
  
  #funcBody.add nnkReturnStmt.newTree(
  #  newIdentNode("outClip")
  #)

  newFunc.add funcBody
  
  #================
  # Create the type
  #================
  # 1. Minimum fields: NODE and VideoInfo
  var newType = nnkRecList.newTree(
          nnkIdentDefs.newTree(
            nnkPostfix.newTree(
              newIdentNode("*"),
              newIdentNode("node")
            ),
            nnkPtrTy.newTree(
              newIdentNode("VSNodeRef")
            ),
            newEmptyNode()
          ),
          nnkIdentDefs.newTree(
            nnkPostfix.newTree(
              newIdentNode("*"),
              newIdentNode("vi")
            ),
            nnkPtrTy.newTree(
              newIdentNode("VSVideoInfo")
            ),
            newEmptyNode()
          ),
          nnkIdentDefs.newTree(
            nnkPostfix.newTree(
              newIdentNode("*"),
              newIdentNode("width")
            ),
            newIdentNode("Natural"),
            newEmptyNode()
          ),
          nnkIdentDefs.newTree(
            nnkPostfix.newTree(
              newIdentNode("*"),
              newIdentNode("height")
            ),
            newIdentNode("Natural"),
            newEmptyNode()
          )          
        )
  # 2. Add the function parameters
  for p in parameters:
    if p[1].strVal != "clip":
      newType.add nnkIdentDefs.newTree(
            nnkPostfix.newTree(
              newIdentNode("*"),
              newIdentNode(p[0].strVal)
            ),
            newIdentNode(p[1].strVal),
            newEmptyNode()
          )
  newType = nnkObjectTy.newTree(
        newEmptyNode(),
        newEmptyNode(),
        newType
      )
  newType = nnkTypeSection.newTree(
    nnkTypeDef.newTree(
      nnkPragmaExpr.newTree(
        newIdentNode( fname.strVal & "Data"),
        nnkPragma.newTree(
          newIdentNode("bycopy"),
          newIdentNode("inject")
        )
      ),
      newEmptyNode(),
      newType
    )
  )

  result = nnkStmtList.newTree()
  result.add newType   # UserData type definition
  #result.add nnkCall.newTree(
  #    newIdentNode("createFreeFunc"),
  #    newIdentNode(fname.strVal)
  #  )

 
  let userDataType = newIdentNode(fname.strVal & "Data")

  result.add quote do:
    proc `freeFuncName`(userData:pointer, core:ptr VSCore, vsapi:ptr VSAPI) {.cdecl,exportc.} =
      let data = cast[ptr `userDataType`](userData)
      vsapi.freeNode(data.node)
      dealloc(data)
  #result.add nnkCall.newTree(
  #    newIdentNode("createInitFunc"),
  #    newIdentNode(fname.strVal)
  #  ) 
  result.add quote do:
    proc `initFuncName`( inclip: ptr VSMap, outclip: ptr VSMap, userData: ptr pointer, node: ptr VSNode, core: ptr VSCore, vsapi: ptr VSAPI) {.cdecl,exportc.} =
      let data = cast[ptr `userDataType`](userData[])
      var vi = API.getVideoInfo( data.node ) # NOTE: I think "vi" is not necessary in userData
      vi.width  = data.width.cint  
      vi.height = data.height.cint
      #data.vi.width = vi.width
      #data.vi.height = vi.height
      #echo repr vi
      echo "Source node: ", repr data.node
      echo "Dest node: ", repr node
      vsapi.setVideoInfo(vi, 1.cint, node)  # Set videoinfo in node 

  
  assert (body[2].kind == nnkCall)
  let processingBody = body[2][1]
  let srcSymbol = newIdentNode("src")  
  let fi = newIdentNode("fi")    
  if eqIdent( body[2][0], "processing"):
    result.add quote do:
      proc `getFrameFunction`( n:cint, activationReason:cint, userData:ptr pointer, frameData:ptr pointer, frameCtx: ptr VSFrameContext, core:ptr VSCore, vsapi:ptr VSAPI ):ptr VSFrameRef {.cdecl,exportc.} =
        ##[
        This function performs the data processing.

        - `n`: frame number
        - `activationReason`:
        - `userData`: contains the data given by the user
        - `frameData`: ??
        - `frameCtx`: ??
        ]##
        let `dataSymbol` = cast[ptr `userDataType`](userData[])
        echo repr data
        if activationReason.VSActivationReason == arInitial:     
            # The following requests a frame from a node and returns immediately.
            # The requested frame can then be retrieved using `getFrameFilter`, 
            # when the filter’s activation reason is `arAllFramesReady` or `arFrameReady`.
            vsapi.requestFrameFilter(n.cint, data.node, frameCtx)
            echo "Source video info: ", getVideoInfo(data.node)

        elif activationReason.VSActivationReason == arAllFramesReady:
            echo ">>>>>>>>>>>>>>> arAllFramesReady"     
            # It is safe to request a frame more than once. An unimportant consequence
            # of requesting a frame more than once is that the getframe function may be
            # called more than once for the same frame with reason arFrameReady.
            # It is best to request frames in ascending order, i.e. n, n+1, n+2, etc.
            let `srcSymbol`:ptr VSFrameRef = vsapi.getFrameFilter(n.cint, data.node, frameCtx)
            let `fi` = vsapi.getFrameFormat(src)  # Format Information
            #echo repr fi
            # Message: if you use this in a filter (I will kill you)
            #let y = if (fi.id == pfCompatBGR32): (height - d.height - d.top) : d.top
            
            #------
            `processingBody` 

            #-------
            #echo repr vsapi.getFrameFormat(dst)
            vsapi.freeFrame(src)       

            #if (d.top and 1) {
            #    VSMap *props = vsapi->getFramePropsRW(dst);
            #    int error;
            #    int64_t fb = vsapi->propGetInt(props, "_FieldBased", 0, &error);
            #    if (fb == 1 || fb == 2)
            #        vsapi->propSetInt(props, "_FieldBased", (fb == 1) ? 2 : 1, paReplace);
                  
            return dst
        return nil
    
    #[
    result.add   nnkCall.newTree(
      newIdentNode("createGetFrameFunc"),
      newIdentNode(fname.strVal),
      nnkStmtList.newTree(
        body[2][1] 
      )
    )
]#

  #result.add nnkCall.newTree(
  #    newIdentNode("createInitFunc"),
  #    newIdentNode(fname.strVal)
  #  )          
  result.add newFunc


  echo repr result


#[

dumpAstGen:
  createFreeFunc(mycrop):
    hola

dumptree:
  return outClip
]#

#discard MyCropRel()
