# Compile like: 
# nim c -f --threads:on --gc:none -d:release -d:danger modifyframe
# $ time modifyframe
# 100f/2.5s = 40fps
#import nimprof
import ../vapoursynth
import options
#import DrawFrame
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


proc BlankClip2*( width=none(int); 
                 height=none(int); 
                 format=none(int); 
                 length=none(int); 
                 fpsnum=none(int); 
                 fpsden=none(int); 
                 color=none(seq[float]); 
                 keep=none(int)):ptr VSMap =
  let plug = getPluginById("com.vapoursynth.std")
  if plug == nil:
    raise newException(ValueError, "plugin \"std\" not installed properly in your computer")

  #let tmpSeq = vsmap.toSeq    # Convert the VSMap into a sequence
  #if tmpSeq.len == 0:
  #  raise newException(ValueError, "the vsmap should contain at least one item")
  #if tmpSeq[0].nodes.len != 1:
  #  raise newException(ValueError, "the vsmap should contain one node")
  #var clip = some(tmpSeq[0].nodes[0])


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = createMap()
  #if clip.isSome: args.append("clip", clip.get)
  if width.isSome: args.append("width", width.get)
  if height.isSome: args.append("height", height.get)
  if format.isSome: args.append("format", format.get)
  if length.isSome: args.append("length", length.get)
  if fpsnum.isSome: args.append("fpsnum", fpsnum.get)
  if fpsden.isSome: args.append("fpsden", fpsden.get)
  if color.isSome: args.set("color", color.get)
  if keep.isSome: args.append("keep", keep.get)

  result = API.invoke(plug, "BlankClip".cstring, args)
  API.freeMap(args)

BlankClip2( format=pfGrayS.int.some, 
           width=640.some,
           height=480.some,
           length=1000.some,
           fpsnum=24000.some, 
           fpsden=1001.some, keep=1.some).Convolution(@[1.0,2.0,1.0,2.0,4.0,2.0,1.0,2.0,1.0]).Null

# $ nim c -f --gc:none -d:release -d:danger modifyframe
# 100000frames/38s = 2631.6fps (feisty2: 2425.51fps)
# https://github.com/darealshinji/vapoursynth-plugins/blob/master/plugins/convo2d/src/convo2d.c
# gc:on : 32.9s
#
#[
BlankClip( format=pfGrayS.int.some, 
           width=640.some,
           height=480.some,
           length=100000.some,#100000.some, 
           fpsnum=24000.some, 
           fpsden=1001.some, keep=1.some).DrawFrame.Null 

# 100000/5min24s = 308fps  # seq[seq[int32]] -> array[9,int32]
# 100000/3m49s = 436fps    # Changing if's into max-min
# 100000/3m46s = 442fps
]#
#Source("../../test/2sec.mkv").DrawFrame.Savey4m("original.y4m")