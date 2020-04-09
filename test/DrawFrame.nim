import vapoursynth
import options

iterator `...`[T](ini:T,`end`:T):tuple[a:uint,b:uint,c:uint] =
  let ini = ini.uint
  let `end` = `end`.uint
  yield (a:ini,b:ini,c:ini+1)
  for i in ini+1..`end`-1:
    yield (a:i-1,b:i,c:i+1)
  yield (a:`end`-1,b:`end`,c:`end`)

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
    for pn in 0..<src.numPlanes:  # pn= Plane Number
        let height = src.height( pn )   
        let width  = src.width( pn )
        let h = (height-1)
        let w = (width-1)

        for (row0, row1, row2) in 0...h:
            let r0 = src[pn, row0]
            let r1 = src[pn, row1]
            let r2 = src[pn, row2]
            let w1 = dst[pn, row1]        
            for (col0, col1, col2) in 0...w:          
              let value:int32  = r0[col0].int32     + r0[col1].int32 * 2 + r0[col2].int32 +
                                 r1[col0].int32 * 2 + r1[col1].int32 * 4 + r1[col2].int32 * 2 +
                                 r2[col0].int32     + r2[col1].int32 * 2 + r2[col2].int32
              #let value:float32  = r0[col0].float32     + r0[col1].float32 * 2 + r0[col2].float32 +
              #                   r1[col0].float32 * 2 + r1[col1].float32 * 4 + r1[col2].float32 * 2 +
              #                   r2[col0].float32     + r2[col1].float32 * 2 + r2[col2].float32
              w1[col1] = (value  / den).uint8