#import math
import ../vapoursynth
import math

iterator `...`[T](ini:T,`end`:T):tuple[a:uint,b:uint,c:uint] =
  let ini = ini.uint
  let `end` = `end`.uint
  yield (a:ini,b:ini,c:ini+1)
  for i in ini+1..`end`-1:
    yield (a:i-1,b:i,c:i+1)
  yield (a:`end`-1,b:`end`,c:`end`)
#[
type
  Plane = object
    plane:uint
    width:uint
    height:uint
    data:seq[int32]

proc getPlane(src:ptr VSFrameRef, pn:cint):Plane =
  let height = src.height( pn )   
  let width  = src.width( pn )    
  var tmp = newSeq[int32](width*height)
  for row in 0..<height:
      let r = src[pn, row]
      for col in 0..<width:
          tmp[row*width + col] = r[col].int32
  return Plane(plane:pn.uint, width:width.uint, height:height.uint, data:tmp)

template `[]`*(p:Plane,r:uint, c:uint):untyped =
    p.data[r*p.width + c]
]#

proc apply_kernel*(src:ptr VSFrameRef, dst:ptr VSFrameRef, kernel:array[9, int32], mul:int, den:int) =
  #let n = (( math.sqrt(kernel.len.float).int - 1 ) / 2).int 
  for pn in 0..<src.numPlanes:  # pn= Plane Number
      # These cost 60fps (if I take them outside of this loop)
      #let p = src.getPlane(pn)
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
            #let value:int32  = p[row0, col0]     + p[row0, col1] * 2 + p[row0, col2] +
            #                   p[row1, col0] * 2 + p[row1, col1] * 4 + p[row1, col2] * 2 +
            #                   p[row2, col0] + p[row2, col1] * 2 + p[row2, col2]
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