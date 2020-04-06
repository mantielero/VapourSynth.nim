import ../vapoursynth
import mymacro
import options

# https://forum.nim-lang.org/t/2328
#https://gist.github.com/ReneSac/7059622360bf59ad4415e3c08998bacf
#proc Gauss() =
  

newFilter("OnCopy"):
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
    #let fi = API.getFrameFormat(src)  # Format information
    let n = (( kernel[0].len - 1 ) / 2).int
    for i in 0..<fi.numPlanes:
      var srcPlane = src[i]  #src.getPlane(i)
      var dstPlane = dst[i]  #dst.getPlane(i)  # Falla con el frame de destino
      var s = src.ggetPlane(i)
      let height = srcPlane.height
      let width  = srcPlane.width      
      for row in 0..<height:
        for col in 0..<width:
          let value = s[row-1, col-1]   + s[row-1, col] * 2 + s[row-1, col+1] + 
                      s[row, col-1] * 2 + s[row, col] * 4   + s[row, col+1] +
                      s[row+1, col-1]   + s[row+1, col] * 2 + s[row+1, col+1]
          dstPlane[row, col] = (value / 16).uint8

      #echo height, " ", width
      #for row in 0..<height:
          #let newrow = row(initptr:ptr uint8, row:int, stride:uint, height:uint)
      #    for col in 0..<width:
