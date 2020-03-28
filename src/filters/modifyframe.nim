import ../vapoursynth
import options, strformat, macros
##[
The objective is defining `modifyframe` macro

http://www.vapoursynth.com/doc/functions/modifyframe.html
]##

import croprel
#import deleteme


# Reads the file, applies the Simple filter and saves the result in a file
Source("../../test/2sec.mkv").MyCropRel(top=some(150.Natural),bottom=some(150.Natural)).Savey4m("original.y4m")
#let clip1 = Source("../../test/2sec.mkv")
#let clip2 = clip1.MyCropRel(top=some(150.Natural),bottom=some(150.Natural))
#clip2.Pipey4m