# Compile like: 
# nim c -d:release -d:danger convolution
import vapoursynth
import options
import times

let time = epochTime()

let nframes = BlankClip( 
      format=pfGrayS.int.some, 
      width=640.some,
      height=480.some,
      length=100000.some,
      fpsnum=24000.some, 
      fpsden=1001.some, 
      keep=1.some).Convolution(@[1.0,2.0,1.0,2.0,4.0,2.0,1.0,2.0,1.0]).Null

let dif = epochTime() - time
echo "Time       : ", dif
echo "Num. frames: ", nframes
echo "FPS        : ", (nframes.float / dif.float)
