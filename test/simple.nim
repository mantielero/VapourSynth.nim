import ../src/vapoursynth
import options

proc Simple*(vsmap:ptr VSMap; planes=none(seq[int])):ptr VSMap =
    let tmpSeq = vsmap.toSeq    # Convert the VSMap into a sequence
    if tmpSeq.len == 0:
      raise newException(ValueError, "the vsmap should contain at least one item")
    if tmpSeq[0].nodes.len != 1:
      raise newException(ValueError, "the vsmap should contain one node")
    var clip = tmpSeq[0].nodes[0] # This is a node
    var outnode:ptr VSNodeRef
    #var newclip = API.cloneNodeRef(clip)
    #API.freeNode(clip)

    #------------------
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
          #let size = width * height  
          for row in 0..<height:
            let newaddress = cast[pointer](cast[int](address) + row*plane.stride)
            for j in 0..10:
               let tmp = cast[int](newaddress) + j
               let address:ptr uint8 = cast[ptr uint8](tmp)
               address[] = 255.uint8
               #echo repr address, " ", address[]
            #strm.writeData(address, plane.width)          
    # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
    #if planes.isSome: args.set("planes", planes.get)
    var outclip = createMap()
    outclip.append("clip", outnode)#clip)
    return outclip

#-------------------------------------------------
# Reads the file, applies the Simple filter and saves the result in a file
Source("2sec.mkv").Simple.Savey4m("deleteme.y4m")

