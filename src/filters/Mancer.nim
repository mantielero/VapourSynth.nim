import ../vapoursynth
import mymacro
import options
import strformat
import arraymancer

newFilter("MancerConv"):
  parameters:  
    inClip   clip           # Input video (mandatory)

  validation:
    # We assign the destination's frame size
    data.width  = data.vi.width.Natural
    data.height = data.vi.height.Natural

  processing:
    let dst = src.newVideoFrame(data.width, data.height)
    let kernel = [ 1, 2, 1,
                   2, 4, 2,
                   1, 2, 1 ].toTensor.reshape(3,3)
    let den = 16 # Denominator
    let mul = 1  # Multiplier
    for i in 0..<fi.numPlanes:
      var srcPlane = src.ggetPlane(i) # This performs a memCopy
      var dstPlane = dst[i]
      let sd = srcPlane.data.toTensor.reshape(srcPlane.width.int, srcPlane.height.int)
      for row in 1..<srcPlane.height-1:
          for col in 1..<srcPlane.width-1:
            let value = (sd[row-1..row+1,col-1..col+1] *. kernel).sum
            dstPlane[row, col] = (value * mul / den).uint8
