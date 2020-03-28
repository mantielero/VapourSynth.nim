import ../vapoursynth
import mymacro
import options
import strformat

newFilter("MyCropRel"):
  parameters:  
    inClip   clip           # Input video (mandatory)
    optional:
      left   Natural  
      right  Natural  
      top    Natural  
      bottom Natural  

  validation:
    # We assign the destination's frame size
    data.width  = data.vi.width.Natural - data.left - data.right
    data.height = data.vi.height.Natural - data.top - data.bottom

    # Avoid too much cropping
    assert( (data.top + data.bottom) < data.vi.height, "vertical cropping too big" )  
    assert( (data.left + data.right) < data.vi.width, "horizontal cropping too big" )

    # make sure the given values will work with subSampling
    assert( (data.left mod divHorizontal) == 0,  &"subSampling: \"left\"={data.left} not divisible by {divHorizontal}" )
    assert( (data.top mod divVertical) == 0,     &"subSampling: \"top\"={data.top} not divisible by {divVertical}"  )
    assert( (data.width mod divHorizontal) == 0, &"subSampling: new \"width\"={data.width} not divisible by {divHorizontal}" )
    assert( (data.height mod divVertical) == 0,  &"subSampling: new \"height\"={data.height} not divisible by {divVertical}")

    if (data.left == 0 and data.right == 0 and data.top == 0 and data.bottom == 0):
      passTrough()

  processing:
    let dst = src.newVideoFrame(data.width, data.height)
    #echo "Frame: ", n
    for i in 0..<srcNumPlanes:
      var srcPlane = src.getPlane(i)
      var dstPlane = dst.getPlane(i)     
      srcPlane.goto(row=data.top, col=data.left) 

      if data.height > 0:      
        srcPlane.copy(dstPlane, rows=data.height, cols=data.width)