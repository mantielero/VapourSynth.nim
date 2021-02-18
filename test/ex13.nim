import vapoursynth, options

let color = some(@[255.0, 128.0, 128.0])
let base_clip = BlankClip(format=pfYUV420P8.int.some, length=1000.some, color=color)

proc animator(n:int, clip:ptr VSMap):ptr VSMap = 
   if n > 255:
      return clip
   else:
      let color = some(@[n.float, 128.0, 128.0])
      return BlankClip(format=pfYUV420P8.int.some, length=1000.some, color=color)

proc gen_animator(clip:ptr VSMap):ptr VSMap =
  return proc (n:int):ptr VSMap =
      animator(n, clip)
  
let tmp = gen_animator(base_clip)

let animated_clip = FrameEval(base_clip, animator(n, base_clip) )

animated_clip.Outputy4m("animated.y4m")