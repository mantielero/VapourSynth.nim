import ../src/vapoursynth
import options
 
Source("2sec.mkv").MotionMask( th1= some(@[10, 10, 10]), th2= some(@[10, 10, 10]), tht=some(10), sc_value=some(0)).Pipey4m