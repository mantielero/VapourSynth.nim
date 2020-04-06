import ../vapoursynth
import options
# nim c --threads:on --gc:none -d:release -d:danger simple


# You can customize the following function signature up to your needs
proc Simple*(inClip:ptr VSMap; x=none(int);y=none(int);width=none(int);height=none(int)):ptr VSMap =
  ##[
  This is the documentation for this very simple filter

  - `inClip`: contains a `ptr VSMap` with the input clip
  - `x`: this is an optional parameter which can be empty or an int

  This function returns another `ptr VSMap` which contains an output frame.
  ]##

  
  # 1. Filter the input data to make sure it is as expected
  # - The following checks that `inClip` contains just one node
  #let tmpSeq = inClip.toSeq    # Convert the VSMap into a sequence
  #if tmpSeq.len == 0:
  #  raise newException(ValueError, "the vsmap should contain at least one item")
  #if tmpSeq[0].nodes.len != 1:
  #  raise newException(ValueError, "the vsmap should contain one node")
  #var clip = tmpSeq[0].nodes[0] # This is a node
  let clip = inClip.propGetNode("clip", 0)  #propGetNode*( vsmap:ptr VSMap, key:string, idx:int)
  let vi = getVideoInfo(clip)
  let width = vi.width
  let height = vi.height
  for frame_number in 0..<vi.numFrames:
    let frame = getFrame(clip, frame_number)
    #echo repr frame
    let fi = getFrameFormat(frame)
    #echo frame_number
    for plane in 0..<fi.numPlanes:
      #echo plane
      let ssW = if plane > 0: fi.subSamplingW else: 0
      let ssH = if plane > 0: fi.subSamplingH else: 0        
      let stride = getStride(frame, plane )
      let planeptr = getWritePtr(frame, plane)  # Plane pointer

      let ini = cast[int](planeptr)
      #echo "Height: ", height, "   Width: ", width
      for row in 0..<(height shr ssH):

        let rowptr = ini + row * stride
        for col in 0..<(width shr ssW):
          
          let p = cast[ptr uint8](rowptr + col)
          #let val = rowptr[col].int
          #echo row , " ", col
          let tmp = p[].int
          var tmp2 = (tmp * 2)
          #tmp2 = if tmp2 > 255: 255 else: tmp2
          #echo tmp, " ", tmp2, " ", uint8(tmp2)
          p[] = 10#tmp2.uint8

    freeFrame(frame)

  
  let oclip = API.cloneNodeRef(clip)
  let outClip = createMap()
  outClip.append("clip", oclip)
  API.freeMap(inClip)#return outClip
  return outClip
# 100frames/0.7s = 
#---------------------
#---   EXECUTION -----
#---------------------
# Reads the file, applies the Simple filter and saves the result in a file
let clip1 = Source("../../test/2sec.mkv")

let clip2 = Simple(clip1)

clip2.Savey4m("original.y4m")