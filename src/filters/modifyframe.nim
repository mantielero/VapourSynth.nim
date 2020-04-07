# Compile like: 
# nim c -f --threads:on --gc:none -d:release -d:danger modifyframe
# $ time modifyframe
# 100f/2.5s = 40fps
#import nimprof
import ../vapoursynth
import options
import times
import DrawFrame

let time = epochTime()


#import OnCopy
#import Mancer

# Reads the file, applies the Simple filter and saves the result in a file
#Source("../../test/2sec.mkv").MyCropRel(top=some(150.Natural),bottom=some(150.Natural)).Savey4m("original.y4m")
#Source("../../test/2sec.mkv")
#BlankClip(format=vs.GRAYS, length=100000, fpsnum=24000, fpsden=1001, keep=True).DrawFrame.Savey4m("original.y4m")
# 100f/0.372s = 268.8fps
#Source("../../test/2sec.mkv").Convolution(@[1.0,2.0,1.0,2.0,4.0,2.0,1.0,2.0,1.0]).Savey4m("original.y4m")
#API.freeCore(CORE)

#[
BlankClip( format=pfGrayS.int.some, 
           width=640.some,
           height=480.some,
           length=100000.some,#100000.some, 
           fpsnum=24000.some, 
           fpsden=1001.some, keep=1.some).DrawFrame.Null #Savey4m("borrame.y4m")
# 100000frames /9m56.8s = 166.6fps
]# 
#[
BlankClip( format=pfGrayS.int.some, 
           width=640.some,
           height=480.some,
           length=100000.some,
           fpsnum=24000.some, 
           fpsden=1001.some, keep=1.some).Convolution(@[1.0,2.0,1.0,2.0,4.0,2.0,1.0,2.0,1.0]).Null#Savey4m("/dev/null")
# 100000frames / 59.1s = 1692fps
# Null filter: just asks for frames and do nothing with them
# 100000frames / 45.7s = 2188fps
# 100000frames / 37.8s = 2645fps
]#

#Source("../../test/2sec.mkv").DrawFrame.Savey4m("original.y4m")
#Source("../../test/2sec.mkv").DrawFrame.Null #Savey4m("original.y4m")
#Source("../../test/2sec.mkv").OnCopy.Null 
#Source("../../test/2sec.mkv").OnCopy.Savey4m("original.y4m")#Null
# 100f/1.47s = 68fps
# 100frames/1.218s = 82,1fps
#[
BlankClip( format=pfGrayS.int.some, 
           width=640.some,
           height=480.some,
           length=100000.some,#100000.some, 
           fpsnum=24000.some, 
           fpsden=1001.some, keep=1.some).OnCopy.Null 
]#
# 1122fps   
# Los IF, hace que de: 100000/(3*60 + 4) = 543fps
#Source("../../test/2sec.mkv").MancerConv.Savey4m("original.y4m")

#[
BlankClip( format=pfGrayS.int.some, 
           width=640.some,
           height=480.some,
           length=100000.some,#100000.some, 
           fpsnum=24000.some, 
           fpsden=1001.some, keep=1.some).DrawFrame.Null 
# 100000frames / 2m58s = 
]#


#[
proc TestClip*():ptr VSMap =
  let plug = getPluginById("com.vapoursynth.std")
  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()
  args.append("width", 640)
  args.append("height", 480)
  args.append("format", pfGrayS.int)
  args.append("length", 100000)
  args.append("fpsnum", 24000)
  args.append("fpsden", 1001)
  args.append("keep", 1)  
  result = API.invoke(plug, "BlankClip".cstring, args)
  API.freeMap(args)



proc MyConvolution*(vsmap:ptr VSMap, matrix:seq[float]):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.std")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()
  args.append("clip", clip)
  #let m = [1,2,1,2,4,2,1,2,1]
  for i in matrix:
    args.append("matrix", i)

  result = API.invoke(plug, "Convolution".cstring, args)
  API.freeMap(args)
]#
#[
let nframes = BlankClip( format=pfGrayS.int.some, 
                         width=640.some,
                         height=480.some,
                         length=100000.some,
                         fpsnum=24000.some, 
                         fpsden=1001.some, 
                         keep=1.some).Convolution(@[1.0,2.0,1.0,2.0,4.0,2.0,1.0,2.0,1.0]).Null
]#
#[
$ ./modifyframe
Time       : 37.95381712913513
Num. frames: 100000
FPS        : 2634.781098822213
]#
#TestClip().MyConvolution(@[1.0,2.0,1.0,2.0,4.0,2.0,1.0,2.0,1.0]).Null

# $ nim c -f --gc:none -d:release -d:danger modifyframe
# 100000frames/38s = 2631.6fps (feisty2: 2425.51fps)
# https://github.com/darealshinji/vapoursynth-plugins/blob/master/plugins/convo2d/src/convo2d.c
# gc:on : 32.9s
#

let nframes = BlankClip( format=pfGrayS.int.some, 
                         width=640.some,
                         height=480.some,
                         length=100000.some,#100000.some, 
                         fpsnum=24000.some, 
                         fpsden=1001.some, 
                         keep=1.some).DrawFrame.Null 

# 100000/5min24s = 308fps  # seq[seq[int32]] -> array[9,int32]
# 100000/3m49s = 436fps    # Changing if's into max-min
# 100000/3m46s = 442fps
# 100000/2m43.9s = 610fps
#let nframes = Source("../../test/2sec.mkv").DrawFrame.Savey4m("original.y4m")


#echo cpuTime()
let dif = epochTime() - time
echo "Time       : ", dif
echo "Num. frames: ", nframes
echo "FPS        : ", (nframes.float / dif.float)
#[
Time       : 127.1067352294922
Num. frames: 100000
FPS        : 786.7403707557214
]#
#[
Usando Float32:
Time       : 298.3208355903625
Num. frames: 100000
FPS        : 335.2095732840947

Nuevo:
Time       : 63.07683086395264
Num. frames: 100000
FPS        : 1585.36817132879

]#

# Feisty2: convolution 2425.5fps   vs c++ 1822.6fps: 75%
# Mío: 2634fps vs 631fps: 24%