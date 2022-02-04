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

https://nim-lang.org/docs/manual.html#types-mixing-gc-ed-memory-with-ptr
]##
# /usr/include/vapoursynth/VapourSynth4.h
{.passL:"-lvapoursynth".}
{.passC:"-I/usr/include/vapoursynth/" .}

when defined(linux):
  const
    libname* = "libvapoursynth.so"
elif defined(windows):
  const
    libname* = "vapoursynth.dll"
else:
  const
    libname* = "libvapoursynth.dylib"

import wrapper/vapoursynth4_wrapper
export vapoursynth4_wrapper

let API* = getVapourSynthAPI(4)
let CORE* = API.createCore(0)
#echo repr(API)
include "wrapper/vsframe4"
include "wrapper/vsmap4"
include "wrapper/output4"

include "wrapper/vsplugins4"
include "plugins4/all_plugins"



proc getVersionString*():string = 
  var coreInfo:ptr VSCoreInfo   
  API.getCoreInfo( CORE, coreInfo )
  return $coreInfo.versionString

proc getCore*():int = 
  var coreInfo:ptr VSCoreInfo   
  API.getCoreInfo( CORE, coreInfo )
  return coreInfo.core.int

proc getApi*():int = 
  var coreInfo:ptr VSCoreInfo 
  API.getCoreInfo( CORE, coreinfo )
  return coreinfo.api.int

proc getNumThreads*():int = 
  var coreInfo:ptr VSCoreInfo   
  API.getCoreInfo( CORE, coreInfo )
  return coreInfo.numThreads.int

proc getMaxFramebufferSize*():int = 
  var coreInfo:ptr VSCoreInfo    
  API.getCoreInfo( CORE, coreInfo )
  return coreInfo.maxFramebufferSize.int


proc getUsedFramebufferSize*():int = 
  var coreInfo:ptr VSCoreInfo     
  API.getCoreInfo( CORE, coreInfo )
  return coreInfo.usedFramebufferSize.int

#include "wrapper/vsframe"
#include "wrapper/output"
#include "vsmacros/filter"  # This is the macro
#include "wrapper/vshelper4"
#include "wrapper/vsscript4_wrapper"


#let vsmap = Source("../test/2sec.mkv")#.ClipInfo()
#vsmap.Savey4m("borrame.y4m")

#echo vsmap.propGetData("hola", 1)
#echo vsmap.get(1)
#echo vsmap.toSeq



#ffmpeg -i test1.mkv -ss 00:00:12  -frames 1 -vcodec copy -an 1frame.mkv
 #ffmpeg -y -i file.mpg -r 1/1 $filename%03d.bmp | eog img.png

#xxd -b outputfile.y4m 
#ffmpeg -i ../test/test1.mkv  outputfile.y4m

# ffmpeg -i ../test/test1.mkv -f yuv4mpegpipe - | mplayer -idx -