import ../vapoursynth
import mymacro
import options
import strformat

newFilter("DrawFrame"):
  parameters:  
    inClip   clip           # Input video (mandatory)

  validation:
    # We assign the destination's frame size
    data.width  = data.vi.width.Natural
    data.height = data.vi.height.Natural

  processing:
    let dst = src.newVideoFrame(data.width, data.height)
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


#[
    let dst = src.newVideoFrame(data.width, data.height)
    for i in 0..<srcNumPlanes:
      var srcPlane = src.getPlane(i)
      var dstPlane = dst.getPlane(i)
      for row in 1..<srcPlane.height-1:
          let ptr1 = cast[int](srcPlane.ptrIniRead) + srcPlane.stride * (row-1) 
          let ptr2 = ptr1 + srcPlane.stride
          let ptr3 = ptr2 + srcPlane.stride
          var tmp1 = cast[ptr UncheckedArray[uint8]]( ptr1 )
          var tmp2 = cast[ptr UncheckedArray[uint8]]( ptr2 )
          var tmp3 = cast[ptr UncheckedArray[uint8]]( ptr3 )
          for col in 1..<srcPlane.width-1:
              var value:int = tmp1[col-1].int     + tmp1[col].int * 2 + tmp1[col+1].int
              value    += tmp2[col-1].int * 2 + tmp2[col].int * 4 + tmp2[col+1].int * 2
              value    += tmp3[col-1].int     + tmp3[col].int * 2 + tmp3[col+1].int
              value = (value.int / 16).int  #(value.float / 16.0).uint8
              #let value = srcPlane.get(row+1, col) * 2
              dstPlane.set(row, col , value.uint8)
]#

        
      #for row in 1..<50:
      #    for col in 1..<50:  
              #echo row, " ", col            
              #[

              ]#