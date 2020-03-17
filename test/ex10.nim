#[
import vapoursynth as vs
c = vs.get_core()


def removegrain_mode19(n, f):
    fout = f.copy()
    
    for p in range(fout.format.num_planes):
        plane = fout.get_write_array(p)
    
        plane_height = len(plane)
        plane_width = len(plane[0])
        
        for y in range(1, plane_height - 1):
            for x in range(1, plane_width - 1):
                plane[y][x] = (plane[y-1][x-1] + plane[y-1][x] + plane[y-1][x+1] + plane[y][x-1] + plane[y][x+1] + plane[y+1][x-1] + plane[y+1][x] + plane[y+1][x+1] + 4) >> 3
    
    return fout


src = c.ffms2.Source("asdf.mov")
src = c.std.ModifyFrame(clip=src, clips=src, selector=removegrain_mode19)


src.set_output()
]#
import ../src/vapoursynth

# KERNEL
# Dado un punto (x,y), hace una especie de media
# x >> y: Returns x with the bits shifted to the right by y places. This is the same as //'ing x by 2**y
# plane[y][x] = (plane[y-1][x-1] +
#                plane[y-1][x] + 
#                plane[y-1][x+1] +
#                plane[y][x-1] + 
#                plane[y][x+1] +
#                plane[y+1][x-1] +
#                plane[y+1][x] + 
#                plane[y+1][x+1] + 4) >> 3


proc removegrain_model19(vsmap:ptr VSMap):ptr VSMap =
  #isclip()  # To perform several checks
  let node = vsmap.propGetNode("clip",0) 
  let vinfo = getVideoInfo(node)

  for i in 0..<vinfo.numFrames: # Iterate over the frames
    let frame = node.getFrame(i)
    let new = copyFrame(frame, CORE)

    let format = new.getFrameFormat.toFormat
    for i in 0..<format.numPlanes:
      let plane = frame.getPlane(i)
      let width = plane.width
      let height = plane.height
      let size = width * height
      for row in 0..<plane.height:
        let address = cast[pointer](cast[int](plane.`ptr`) + row*plane.stride)
        #strm.writeData(address, plane.width)      
        #*address = 100

  # Creamos el VSMap
  var newnode = 
  var newmap = createMap()
  newmap.append("clip", newnode)


