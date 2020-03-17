import ../src/vapoursynth
import options
 
Source("2sec.mkv").Bicubic( width=some(320), height=some(200) ).Pipey4m