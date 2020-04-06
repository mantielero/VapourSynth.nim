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
    let kernel:array[9,int32] = [1.int32, 2.int32, 1.int32,
                                 2.int32, 4.int32, 2.int32,
                                 1.int32, 2.int32, 1.int32]

    let den:int32 = 16 # Denominator
    let mul:int32 = 1  # Multiplier
    #echo "Frame: ", n
    apply_kernel(src, dst, kernel, mul, den)
