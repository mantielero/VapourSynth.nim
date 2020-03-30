import ../vapoursynth
import mymacro
import options
import strformat
import kernel

newFilter("DrawFrame"):
  parameters:  
    inClip   clip           # Input video (mandatory)

  validation:
    # We assign the destination's frame size
    data.width  = data.vi.width.Natural
    data.height = data.vi.height.Natural

  processing:
    let dst = src.newVideoFrame(data.width, data.height)
    let kernel = @[@[1, 2, 1],
                   @[2, 4, 2],
                   @[1, 2, 1] ]
    let den = 16 # Denominator
    let mul = 1  # Multiplier
    #echo "Frame: ", n
    apply_kernel(src, dst, kernel, mul, den)
    #[
    for i in 0..<srcNumPlanes:
      var srcPlane = src.getPlane(i)
      var dstPlane = dst.getPlane(i)
      for row in 0..<srcPlane.height:
          for col in 0..<srcPlane.width:
              var value:int = ( srcPlane.get(row-1,col-1) + 
                                srcPlane.get(row-1,col) * 2 + 
                                srcPlane.get(row-1,col+1) +
                                srcPlane.get(row,col-1) * 2 + 
                                srcPlane.get(row,col) * 4 + 
                                srcPlane.get(row,col+1) * 2 +
                                srcPlane.get(row+1,col-1) +
                                srcPlane.get(row+1,col) * 2 +
                                srcPlane.get(row+1,col+1) ).int
              dstPlane.set(row, col , (value / 16).uint8)
    ]#