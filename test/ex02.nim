import ../src/vapoursynth
 
#Source("2sec.mkv").Turn180.ClipInfo.Savey4m("demo.y4m")
#Source("2sec.mkv").Transpose.Pipey4m
#import vapoursynth
Source("2sec.mkv")[0..30].Transpose.Pipey4m