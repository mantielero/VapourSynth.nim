import ../src/vapoursynth, options
proc myfilter(vsmap:ptr VSMap, w:int, h:int):ptr VSMap = vsmap.Bicubic(width=some(w), height=some(h))

Source("2sec.mkv").myfilter(w=320,h=200).Pipey4m