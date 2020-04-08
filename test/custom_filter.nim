# Compile like: 
# nim c -f --threads:on -d:release -d:danger modifyframe

import vapoursynth
import options
import times
import DrawFrame

let time = epochTime()

let nframes = BlankClip( format=pfGrayS.int.some, 
                         width=640.some,
                         height=480.some,
                         length=100000.some,
                         fpsnum=24000.some, 
                         fpsden=1001.some, 
                         keep=1.some).DrawFrame.Null

let dif = epochTime() - time
echo "Time       : ", dif
echo "Num. frames: ", nframes
echo "FPS        : ", (nframes.float / dif.float)


# Int32: 10700fps
# float32: 6074fps