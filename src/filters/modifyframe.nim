# Compile like: 
# nim c -f --threads:on --gc:none -d:release -d:danger modifyframe
# $ time modifyframe
# 100f/2.5s = 40fps
#import nimprof
import ../vapoursynth
import options
import croprel, DrawFrame

# Reads the file, applies the Simple filter and saves the result in a file
#Source("../../test/2sec.mkv").MyCropRel(top=some(150.Natural),bottom=some(150.Natural)).Savey4m("original.y4m")
#Source("../../test/2sec.mkv")
#BlankClip(format=vs.GRAYS, length=100000, fpsnum=24000, fpsden=1001, keep=True).DrawFrame.Savey4m("original.y4m")
# 100f/0.372s = 268.8fps
#Source("../../test/2sec.mkv").Convolution(@[1.0,2.0,1.0,2.0,4.0,2.0,1.0,2.0,1.0]).Savey4m("original.y4m")
#API.freeCore(CORE)
BlankClip( format=pfGrayS.int.some, 
           width=640.some,
           height=480.some,
           length=100.some,#100000.some, 
           fpsnum=24000.some, 
           fpsden=1001.some, keep=1.some).DrawFrame.Savey4m("borrame.y4m")