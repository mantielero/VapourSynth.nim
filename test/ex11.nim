import ../src/vapoursynth
import options
#Source("test/2sec.mkv").Turn180.ClipInfo.Savey4m("demo.y4m")
#Source("2sec.mkv").Turn180.ClipInfo.Pipey4m

# ./ex01 | mplayer -idx -
let clip1 = Source("2sec.mkv")
let clip2 = clip1[0..50]
let clip3 = clip1[50..99]
let clip4 = clip3 + clip2
echo $clip4
let clip5 = 4 * clip1
#echo Splice(clip3, mismatch=0.some).Savey4m("salida.y4m")
#echo clip5.Savey4m("salida.y4m")
let clip6 = clip1[last-10..0]
#echo clip6.Savey4m("salida.y4m")
echo clip4[0..last,4].Savey4m("salida.y4m")

#for item in clip3.item

#for item in clip1.items:
#  for i in clip1.items(item):
#    echo repr i