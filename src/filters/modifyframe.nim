import ../vapoursynth
import options
import croprel, DrawFrame

# Reads the file, applies the Simple filter and saves the result in a file
#Source("../../test/2sec.mkv").MyCropRel(top=some(150.Natural),bottom=some(150.Natural)).Savey4m("original.y4m")
Source("../../test/2sec.mkv").DrawFrame.Savey4m("original.y4m")