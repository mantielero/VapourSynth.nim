import ../vapoursynth
import options
import croprel

# Reads the file, applies the Simple filter and saves the result in a file
Source("../../test/2sec.mkv").CropRel(top=some(150),bottom=some(150)).Savey4m("original2.y4m")