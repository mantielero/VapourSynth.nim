#import math
import ../vapoursynth
import math

template clamp(val:cint, max_val:cint):untyped =
  min( max(val, 0), max_val).uint

proc apply_kernel*(src:ptr VSFrameRef, dst:ptr VSFrameRef, kernel:array[9, int32], mul:int, den:int) =
  #let n = (( math.sqrt(kernel.len.float).int - 1 ) / 2).int 
  for pn in 0..<src.numPlanes:  # pn= Plane Number
      # These cost 60fps
      let height = src.height( pn )   
      let width  = src.width( pn )
      #let sp:Plane = src[pn]  # Source plane
      #let dp:Plane = dst[pn]  # Destination plane
      #echo pn
      #let srcplane = src[pn]
      let h = (height-1)
      let w = (width-1)
      for row1 in 0..<height:
          let row0 = clamp(row1-1, h)
          let row2 = clamp(row1+1, h)
          let r0 = src[pn, row0]
          let r1 = src[pn, row1]
          let r2 = src[pn, row2]
          let w1 = dst[pn, row1]
          #let r0 = sp[row0]
          #let r1 = sp[row1]
          #let r2 = sp[row2]
          #let w1 = dp[row1]          
          for col1 in 0..<width:
            let col0 = clamp(col1-1, w)
            let col2 = clamp(col1+1, w)
            let value:int32  = r0[col0].int32     + r0[col1].int32 * 2 + r0[col2].int32 +
                               r1[col0].int32 * 2 + r1[col1].int32 * 4 + r1[col2].int32 * 2 +
                               r2[col0].int32     + r2[col1].int32 * 2 + r2[col2].int32
            #let value:uint16  = r0[col0].uint16+ r0[col2].uint16+ r2[col0].uint16 + r2[col2].uint16 +
            #                   (r0[col1].uint16 + r1[col0].uint16 + r1[col2].uint16 + r2[col1].uint16) * 2.uint16 +
            #                   r1[col1].uint16 * 4.uint16 
            w1[col1] = (value  / den).uint8

#[
auto srcp = reinterpret_cast<const float*>(vsapi->getReadPtr(frame, plane));
auto dstp = reinterpret_cast<float*>(vsapi->getWritePtr(dst, plane));
auto h = vsapi->getFrameHeight(frame, plane);
auto w = vsapi->getFrameWidth(frame, plane);

auto gauss = [&](auto y, auto x) {

    auto clamp = [&](auto val, auto bound) {
        return std::min(std::max(val, 0), bound - 1);
    };

    auto above = srcp + clamp(y - 1, h) * w;
    auto current = srcp + y * w;
    auto below = srcp + clamp(y + 1, h) * w;
    
    auto conv = above[clamp(x - 1, w)] + above[x] * 2 + above[clamp(x + 1, w)] +
        current[clamp(x - 1, w)] * 2 + current[x] * 4 + current[clamp(x + 1, w)] * 2 +
        below[clamp(x - 1, w)] + below[x] * 2 + below[clamp(x + 1, w)];
    return conv / 16;
};

for (auto y = 0; y < h; y++)
    for (auto x = 0; x < w; x++)
        (dstp + y * w)[x] = gauss(y, x);

]#