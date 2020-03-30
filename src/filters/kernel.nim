#import math
import ../vapoursynth



proc apply_kernel*(src:ptr VSFrameRef, dst:ptr VSFrameRef, kernel:seq[seq[int]], mul:int, den:int) =
  let fi = API.getFrameFormat(src)  # Format information
  let n = (( kernel[0].len - 1 ) / 2).int
  for i in 0..<fi.numPlanes:
      var srcPlane = src[i]  #src.getPlane(i)
      var dstPlane = dst[i]  #dst.getPlane(i)  # Falla con el frame de destino

      let height = srcPlane.height
      let width  = srcPlane.width
      for row in 0..<height:
          for col in 0..<width:
            var value:int = 0
            for i in -n..n:
                for j in -n..n:
                  if row+i < 0 or col+j < 0 or row+i > height-1 or col+j > width-1:
                    value += 0
                  else:
                    value += srcPlane[row+i, col+j].int * kernel[i+n][j+n]

            dstPlane[row, col] = (value.int * mul / den).uint8
