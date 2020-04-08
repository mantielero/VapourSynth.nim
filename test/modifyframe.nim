# Compile like: 
# nim c -f --threads:on -d:release -d:danger modifyframe
import vapoursynth
import options
import times
import DrawFrame

let time = epochTime()

let nframes = Source("2sec.mkv").DrawFrame.Savey4m("original.y4m")

let dif = epochTime() - time
echo "Time       : ", dif
echo "Num. frames: ", nframes
echo "FPS        : ", (nframes.float / dif.float)
