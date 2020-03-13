##[
VapourSynth.nim
===============

Why?
----

This will enable you to perform video manipulation. 




TODO
----
TODO: something like


TODO: documentation and integrate it with Github pages

]##
import VapourSynthWrapper
let API = getVapourSynthAPI(3)
let CORE = API.createCore(0)

include "vsmap"
include "vsplugins"
include "plugins/all_plugins"

proc getVesionString():cstring = API.getCoreInfo( CORE ).versionString
proc getCore():int = API.getCoreInfo( CORE ).core.int
proc getApi():int = API.getCoreInfo( CORE ).api.int
proc getNumThreads():int = API.getCoreInfo( CORE ).numThreads.int
proc getMaxFramebufferSize():int = API.getCoreInfo( CORE ).maxFramebufferSize.int
proc getUsedFramebufferSize():int = API.getCoreInfo( CORE ).usedFramebufferSize.int

include "vsframe"
include "output"

when isMainModule:
  #let vsmap = Source("../test/2sec.mkv")#.ClipInfo()
  #vsmap.Savey4m("borrame.y4m")
  let vsmap = createMap()
  vsmap.propSetInt("hola", 1, paAppend)
  echo vsmap.propGetData("hola", -1)
  #echo vsmap.propGetData("hola", 1)
  #echo vsmap.get(1)
  #echo vsmap.toSeq



#ffmpeg -i test1.mkv -ss 00:00:12  -frames 1 -vcodec copy -an 1frame.mkv
 #ffmpeg -y -i file.mpg -r 1/1 $filename%03d.bmp | eog img.png

#xxd -b outputfile.y4m 
#ffmpeg -i ../test/test1.mkv  outputfile.y4m

# ffmpeg -i ../test/test1.mkv -f yuv4mpegpipe - | mplayer -idx -