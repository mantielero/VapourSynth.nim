import ../src/vapoursynth
 
#Source("2sec.mkv").Turn180.ClipInfo.Savey4m("demo.y4m")
Source("2sec.mkv")[0..30].Pipey4m