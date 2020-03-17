import ../src/vapoursynth, options
let clip1 = Source("2sec.mkv")

let clip2 = clip1.MotionMask( th1= some(@[10, 10, 10]), th2= some(@[10, 10, 10]), tht=some(10), sc_value=some(0))

Pipey4m(clip2)