# Generated @ 2022-01-07T19:51:28+01:00
# Command line: /home/jose/.nimble/pkgs/nimterop-0.6.13/nimterop/
# $  toast -pnkr /usr/include/vapoursynth/VapourSynth4.h > vapoursynt4_wrapper.nim

# const 'VAPOURSYNTH_API_VERSION' has unsupported value 'VS_MAKE_VERSION(VAPOURSYNTH_API_MAJOR, VAPOURSYNTH_API_MINOR)'
{.push hint[ConvFromXtoItselfNotNeeded]: off.}
import macros

macro defineEnum(typ: untyped): untyped =
  result = newNimNode(nnkStmtList)

  # Enum mapped to distinct cint
  result.add quote do:
    type `typ`* = distinct cint

  for i in ["+", "-", "*", "div", "mod", "shl", "shr", "or", "and", "xor", "<", "<=", "==", ">", ">="]:
    let
      ni = newIdentNode(i)
      typout = if i[0] in "<=>": newIdentNode("bool") else: typ # comparisons return bool
    if i[0] == '>': # cannot borrow `>` and `>=` from templates
      let
        nopp = if i.len == 2: newIdentNode("<=") else: newIdentNode("<")
      result.add quote do:
        proc `ni`*(x: `typ`, y: cint): `typout` = `nopp`(y, x)
        proc `ni`*(x: cint, y: `typ`): `typout` = `nopp`(y, x)
        proc `ni`*(x, y: `typ`): `typout` = `nopp`(y, x)
    else:
      result.add quote do:
        proc `ni`*(x: `typ`, y: cint): `typout` {.borrow.}
        proc `ni`*(x: cint, y: `typ`): `typout` {.borrow.}
        proc `ni`*(x, y: `typ`): `typout` {.borrow.}
    result.add quote do:
      proc `ni`*(x: `typ`, y: int): `typout` = `ni`(x, y.cint)
      proc `ni`*(x: int, y: `typ`): `typout` = `ni`(x.cint, y)

  let
    divop = newIdentNode("/")   # `/`()
    dlrop = newIdentNode("$")   # `$`()
    notop = newIdentNode("not") # `not`()
  result.add quote do:
    proc `divop`*(x, y: `typ`): `typ` = `typ`((x.float / y.float).cint)
    proc `divop`*(x: `typ`, y: cint): `typ` = `divop`(x, `typ`(y))
    proc `divop`*(x: cint, y: `typ`): `typ` = `divop`(`typ`(x), y)
    proc `divop`*(x: `typ`, y: int): `typ` = `divop`(x, y.cint)
    proc `divop`*(x: int, y: `typ`): `typ` = `divop`(x.cint, y)

    proc `dlrop`*(x: `typ`): string {.borrow.}
    proc `notop`*(x: `typ`): `typ` {.borrow.}


{.pragma: impVapourSynth4Hdr, header: "/usr/include/vapoursynth/VapourSynth4.h".}
{.experimental: "codeReordering".}
defineEnum(VSColorFamily)
defineEnum(VSSampleType)
defineEnum(VSPresetFormat)
defineEnum(VSFilterMode)
defineEnum(VSMediaType)
defineEnum(VSAudioChannels)
defineEnum(VSPropertyType)
defineEnum(VSMapPropertyError)
defineEnum(VSMapAppendMode)
defineEnum(VSActivationReason)
defineEnum(VSMessageType)
defineEnum(VSCoreCreationFlags)
defineEnum(VSPluginConfigFlags)
defineEnum(VSDataTypeHint)
defineEnum(VSRequestPattern)
const
  VAPOURSYNTH_API_MAJOR* = 4
  VAPOURSYNTH_API_MINOR* = 0
  VS_AUDIO_FRAME_SAMPLES* = 3072
  cfUndefined* = (0).VSColorFamily
  cfGray* = (1).VSColorFamily
  cfRGB* = (2).VSColorFamily
  cfYUV* = (3).VSColorFamily
  stInteger* = (0).VSSampleType
  stFloat* = (1).VSSampleType
  pfNone* = (0).VSPresetFormat
  pfGray8* = (((cfGray.VSPresetFormat shl typeof(cfGray.VSPresetFormat)(28)) or
      typeof(cfGray.VSPresetFormat)((stInteger.VSPresetFormat shl
      typeof(cfGray.VSPresetFormat)(24))) or
      typeof(cfGray.VSPresetFormat)((8 shl typeof(cfGray.VSPresetFormat)(16))) or
      typeof(cfGray.VSPresetFormat)((0 shl typeof(cfGray.VSPresetFormat)(8))) or
      typeof(cfGray.VSPresetFormat)((0 shl typeof(cfGray.VSPresetFormat)(0))))).VSPresetFormat
  pfGray9* = (((cfGray.VSPresetFormat shl typeof(cfGray.VSPresetFormat)(28)) or
      typeof(cfGray.VSPresetFormat)((stInteger.VSPresetFormat shl
      typeof(cfGray.VSPresetFormat)(24))) or
      typeof(cfGray.VSPresetFormat)((9 shl typeof(cfGray.VSPresetFormat)(16))) or
      typeof(cfGray.VSPresetFormat)((0 shl typeof(cfGray.VSPresetFormat)(8))) or
      typeof(cfGray.VSPresetFormat)((0 shl typeof(cfGray.VSPresetFormat)(0))))).VSPresetFormat
  pfGray10* = (((cfGray.VSPresetFormat shl typeof(cfGray.VSPresetFormat)(28)) or
      typeof(cfGray.VSPresetFormat)((stInteger.VSPresetFormat shl
      typeof(cfGray.VSPresetFormat)(24))) or
      typeof(cfGray.VSPresetFormat)((10 shl typeof(cfGray.VSPresetFormat)(16))) or
      typeof(cfGray.VSPresetFormat)((0 shl typeof(cfGray.VSPresetFormat)(8))) or
      typeof(cfGray.VSPresetFormat)((0 shl typeof(cfGray.VSPresetFormat)(0))))).VSPresetFormat
  pfGray12* = (((cfGray.VSPresetFormat shl typeof(cfGray.VSPresetFormat)(28)) or
      typeof(cfGray.VSPresetFormat)((stInteger.VSPresetFormat shl
      typeof(cfGray.VSPresetFormat)(24))) or
      typeof(cfGray.VSPresetFormat)((12 shl typeof(cfGray.VSPresetFormat)(16))) or
      typeof(cfGray.VSPresetFormat)((0 shl typeof(cfGray.VSPresetFormat)(8))) or
      typeof(cfGray.VSPresetFormat)((0 shl typeof(cfGray.VSPresetFormat)(0))))).VSPresetFormat
  pfGray14* = (((cfGray.VSPresetFormat shl typeof(cfGray.VSPresetFormat)(28)) or
      typeof(cfGray.VSPresetFormat)((stInteger.VSPresetFormat shl
      typeof(cfGray.VSPresetFormat)(24))) or
      typeof(cfGray.VSPresetFormat)((14 shl typeof(cfGray.VSPresetFormat)(16))) or
      typeof(cfGray.VSPresetFormat)((0 shl typeof(cfGray.VSPresetFormat)(8))) or
      typeof(cfGray.VSPresetFormat)((0 shl typeof(cfGray.VSPresetFormat)(0))))).VSPresetFormat
  pfGray16* = (((cfGray.VSPresetFormat shl typeof(cfGray.VSPresetFormat)(28)) or
      typeof(cfGray.VSPresetFormat)((stInteger.VSPresetFormat shl
      typeof(cfGray.VSPresetFormat)(24))) or
      typeof(cfGray.VSPresetFormat)((16 shl typeof(cfGray.VSPresetFormat)(16))) or
      typeof(cfGray.VSPresetFormat)((0 shl typeof(cfGray.VSPresetFormat)(8))) or
      typeof(cfGray.VSPresetFormat)((0 shl typeof(cfGray.VSPresetFormat)(0))))).VSPresetFormat
  pfGray32* = (((cfGray.VSPresetFormat shl typeof(cfGray.VSPresetFormat)(28)) or
      typeof(cfGray.VSPresetFormat)((stInteger.VSPresetFormat shl
      typeof(cfGray.VSPresetFormat)(24))) or
      typeof(cfGray.VSPresetFormat)((32 shl typeof(cfGray.VSPresetFormat)(16))) or
      typeof(cfGray.VSPresetFormat)((0 shl typeof(cfGray.VSPresetFormat)(8))) or
      typeof(cfGray.VSPresetFormat)((0 shl typeof(cfGray.VSPresetFormat)(0))))).VSPresetFormat
  pfGrayH* = (((cfGray.VSPresetFormat shl typeof(cfGray.VSPresetFormat)(28)) or
      typeof(cfGray.VSPresetFormat)((stFloat.VSPresetFormat shl
      typeof(cfGray.VSPresetFormat)(24))) or
      typeof(cfGray.VSPresetFormat)((16 shl typeof(cfGray.VSPresetFormat)(16))) or
      typeof(cfGray.VSPresetFormat)((0 shl typeof(cfGray.VSPresetFormat)(8))) or
      typeof(cfGray.VSPresetFormat)((0 shl typeof(cfGray.VSPresetFormat)(0))))).VSPresetFormat
  pfGrayS* = (((cfGray.VSPresetFormat shl typeof(cfGray.VSPresetFormat)(28)) or
      typeof(cfGray.VSPresetFormat)((stFloat.VSPresetFormat shl
      typeof(cfGray.VSPresetFormat)(24))) or
      typeof(cfGray.VSPresetFormat)((32 shl typeof(cfGray.VSPresetFormat)(16))) or
      typeof(cfGray.VSPresetFormat)((0 shl typeof(cfGray.VSPresetFormat)(8))) or
      typeof(cfGray.VSPresetFormat)((0 shl typeof(cfGray.VSPresetFormat)(0))))).VSPresetFormat
  pfYUV410P8* = (((cfYUV.VSPresetFormat shl typeof(cfYUV.VSPresetFormat)(28)) or
      typeof(cfYUV.VSPresetFormat)((stInteger.VSPresetFormat shl
      typeof(cfYUV.VSPresetFormat)(24))) or
      typeof(cfYUV.VSPresetFormat)((8 shl typeof(cfYUV.VSPresetFormat)(16))) or
      typeof(cfYUV.VSPresetFormat)((2 shl typeof(cfYUV.VSPresetFormat)(8))) or
      typeof(cfYUV.VSPresetFormat)((2 shl typeof(cfYUV.VSPresetFormat)(0))))).VSPresetFormat
  pfYUV411P8* = (((cfYUV.VSPresetFormat shl typeof(cfYUV.VSPresetFormat)(28)) or
      typeof(cfYUV.VSPresetFormat)((stInteger.VSPresetFormat shl
      typeof(cfYUV.VSPresetFormat)(24))) or
      typeof(cfYUV.VSPresetFormat)((8 shl typeof(cfYUV.VSPresetFormat)(16))) or
      typeof(cfYUV.VSPresetFormat)((2 shl typeof(cfYUV.VSPresetFormat)(8))) or
      typeof(cfYUV.VSPresetFormat)((0 shl typeof(cfYUV.VSPresetFormat)(0))))).VSPresetFormat
  pfYUV440P8* = (((cfYUV.VSPresetFormat shl typeof(cfYUV.VSPresetFormat)(28)) or
      typeof(cfYUV.VSPresetFormat)((stInteger.VSPresetFormat shl
      typeof(cfYUV.VSPresetFormat)(24))) or
      typeof(cfYUV.VSPresetFormat)((8 shl typeof(cfYUV.VSPresetFormat)(16))) or
      typeof(cfYUV.VSPresetFormat)((0 shl typeof(cfYUV.VSPresetFormat)(8))) or
      typeof(cfYUV.VSPresetFormat)((1 shl typeof(cfYUV.VSPresetFormat)(0))))).VSPresetFormat
  pfYUV420P8* = (((cfYUV.VSPresetFormat shl typeof(cfYUV.VSPresetFormat)(28)) or
      typeof(cfYUV.VSPresetFormat)((stInteger.VSPresetFormat shl
      typeof(cfYUV.VSPresetFormat)(24))) or
      typeof(cfYUV.VSPresetFormat)((8 shl typeof(cfYUV.VSPresetFormat)(16))) or
      typeof(cfYUV.VSPresetFormat)((1 shl typeof(cfYUV.VSPresetFormat)(8))) or
      typeof(cfYUV.VSPresetFormat)((1 shl typeof(cfYUV.VSPresetFormat)(0))))).VSPresetFormat
  pfYUV422P8* = (((cfYUV.VSPresetFormat shl typeof(cfYUV.VSPresetFormat)(28)) or
      typeof(cfYUV.VSPresetFormat)((stInteger.VSPresetFormat shl
      typeof(cfYUV.VSPresetFormat)(24))) or
      typeof(cfYUV.VSPresetFormat)((8 shl typeof(cfYUV.VSPresetFormat)(16))) or
      typeof(cfYUV.VSPresetFormat)((1 shl typeof(cfYUV.VSPresetFormat)(8))) or
      typeof(cfYUV.VSPresetFormat)((0 shl typeof(cfYUV.VSPresetFormat)(0))))).VSPresetFormat
  pfYUV444P8* = (((cfYUV.VSPresetFormat shl typeof(cfYUV.VSPresetFormat)(28)) or
      typeof(cfYUV.VSPresetFormat)((stInteger.VSPresetFormat shl
      typeof(cfYUV.VSPresetFormat)(24))) or
      typeof(cfYUV.VSPresetFormat)((8 shl typeof(cfYUV.VSPresetFormat)(16))) or
      typeof(cfYUV.VSPresetFormat)((0 shl typeof(cfYUV.VSPresetFormat)(8))) or
      typeof(cfYUV.VSPresetFormat)((0 shl typeof(cfYUV.VSPresetFormat)(0))))).VSPresetFormat
  pfYUV420P9* = (((cfYUV.VSPresetFormat shl typeof(cfYUV.VSPresetFormat)(28)) or
      typeof(cfYUV.VSPresetFormat)((stInteger.VSPresetFormat shl
      typeof(cfYUV.VSPresetFormat)(24))) or
      typeof(cfYUV.VSPresetFormat)((9 shl typeof(cfYUV.VSPresetFormat)(16))) or
      typeof(cfYUV.VSPresetFormat)((1 shl typeof(cfYUV.VSPresetFormat)(8))) or
      typeof(cfYUV.VSPresetFormat)((1 shl typeof(cfYUV.VSPresetFormat)(0))))).VSPresetFormat
  pfYUV422P9* = (((cfYUV.VSPresetFormat shl typeof(cfYUV.VSPresetFormat)(28)) or
      typeof(cfYUV.VSPresetFormat)((stInteger.VSPresetFormat shl
      typeof(cfYUV.VSPresetFormat)(24))) or
      typeof(cfYUV.VSPresetFormat)((9 shl typeof(cfYUV.VSPresetFormat)(16))) or
      typeof(cfYUV.VSPresetFormat)((1 shl typeof(cfYUV.VSPresetFormat)(8))) or
      typeof(cfYUV.VSPresetFormat)((0 shl typeof(cfYUV.VSPresetFormat)(0))))).VSPresetFormat
  pfYUV444P9* = (((cfYUV.VSPresetFormat shl typeof(cfYUV.VSPresetFormat)(28)) or
      typeof(cfYUV.VSPresetFormat)((stInteger.VSPresetFormat shl
      typeof(cfYUV.VSPresetFormat)(24))) or
      typeof(cfYUV.VSPresetFormat)((9 shl typeof(cfYUV.VSPresetFormat)(16))) or
      typeof(cfYUV.VSPresetFormat)((0 shl typeof(cfYUV.VSPresetFormat)(8))) or
      typeof(cfYUV.VSPresetFormat)((0 shl typeof(cfYUV.VSPresetFormat)(0))))).VSPresetFormat
  pfYUV420P10* = (((cfYUV.VSPresetFormat shl typeof(cfYUV.VSPresetFormat)(28)) or
      typeof(cfYUV.VSPresetFormat)((stInteger.VSPresetFormat shl
      typeof(cfYUV.VSPresetFormat)(24))) or
      typeof(cfYUV.VSPresetFormat)((10 shl typeof(cfYUV.VSPresetFormat)(16))) or
      typeof(cfYUV.VSPresetFormat)((1 shl typeof(cfYUV.VSPresetFormat)(8))) or
      typeof(cfYUV.VSPresetFormat)((1 shl typeof(cfYUV.VSPresetFormat)(0))))).VSPresetFormat
  pfYUV422P10* = (((cfYUV.VSPresetFormat shl typeof(cfYUV.VSPresetFormat)(28)) or
      typeof(cfYUV.VSPresetFormat)((stInteger.VSPresetFormat shl
      typeof(cfYUV.VSPresetFormat)(24))) or
      typeof(cfYUV.VSPresetFormat)((10 shl typeof(cfYUV.VSPresetFormat)(16))) or
      typeof(cfYUV.VSPresetFormat)((1 shl typeof(cfYUV.VSPresetFormat)(8))) or
      typeof(cfYUV.VSPresetFormat)((0 shl typeof(cfYUV.VSPresetFormat)(0))))).VSPresetFormat
  pfYUV444P10* = (((cfYUV.VSPresetFormat shl typeof(cfYUV.VSPresetFormat)(28)) or
      typeof(cfYUV.VSPresetFormat)((stInteger.VSPresetFormat shl
      typeof(cfYUV.VSPresetFormat)(24))) or
      typeof(cfYUV.VSPresetFormat)((10 shl typeof(cfYUV.VSPresetFormat)(16))) or
      typeof(cfYUV.VSPresetFormat)((0 shl typeof(cfYUV.VSPresetFormat)(8))) or
      typeof(cfYUV.VSPresetFormat)((0 shl typeof(cfYUV.VSPresetFormat)(0))))).VSPresetFormat
  pfYUV420P12* = (((cfYUV.VSPresetFormat shl typeof(cfYUV.VSPresetFormat)(28)) or
      typeof(cfYUV.VSPresetFormat)((stInteger.VSPresetFormat shl
      typeof(cfYUV.VSPresetFormat)(24))) or
      typeof(cfYUV.VSPresetFormat)((12 shl typeof(cfYUV.VSPresetFormat)(16))) or
      typeof(cfYUV.VSPresetFormat)((1 shl typeof(cfYUV.VSPresetFormat)(8))) or
      typeof(cfYUV.VSPresetFormat)((1 shl typeof(cfYUV.VSPresetFormat)(0))))).VSPresetFormat
  pfYUV422P12* = (((cfYUV.VSPresetFormat shl typeof(cfYUV.VSPresetFormat)(28)) or
      typeof(cfYUV.VSPresetFormat)((stInteger.VSPresetFormat shl
      typeof(cfYUV.VSPresetFormat)(24))) or
      typeof(cfYUV.VSPresetFormat)((12 shl typeof(cfYUV.VSPresetFormat)(16))) or
      typeof(cfYUV.VSPresetFormat)((1 shl typeof(cfYUV.VSPresetFormat)(8))) or
      typeof(cfYUV.VSPresetFormat)((0 shl typeof(cfYUV.VSPresetFormat)(0))))).VSPresetFormat
  pfYUV444P12* = (((cfYUV.VSPresetFormat shl typeof(cfYUV.VSPresetFormat)(28)) or
      typeof(cfYUV.VSPresetFormat)((stInteger.VSPresetFormat shl
      typeof(cfYUV.VSPresetFormat)(24))) or
      typeof(cfYUV.VSPresetFormat)((12 shl typeof(cfYUV.VSPresetFormat)(16))) or
      typeof(cfYUV.VSPresetFormat)((0 shl typeof(cfYUV.VSPresetFormat)(8))) or
      typeof(cfYUV.VSPresetFormat)((0 shl typeof(cfYUV.VSPresetFormat)(0))))).VSPresetFormat
  pfYUV420P14* = (((cfYUV.VSPresetFormat shl typeof(cfYUV.VSPresetFormat)(28)) or
      typeof(cfYUV.VSPresetFormat)((stInteger.VSPresetFormat shl
      typeof(cfYUV.VSPresetFormat)(24))) or
      typeof(cfYUV.VSPresetFormat)((14 shl typeof(cfYUV.VSPresetFormat)(16))) or
      typeof(cfYUV.VSPresetFormat)((1 shl typeof(cfYUV.VSPresetFormat)(8))) or
      typeof(cfYUV.VSPresetFormat)((1 shl typeof(cfYUV.VSPresetFormat)(0))))).VSPresetFormat
  pfYUV422P14* = (((cfYUV.VSPresetFormat shl typeof(cfYUV.VSPresetFormat)(28)) or
      typeof(cfYUV.VSPresetFormat)((stInteger.VSPresetFormat shl
      typeof(cfYUV.VSPresetFormat)(24))) or
      typeof(cfYUV.VSPresetFormat)((14 shl typeof(cfYUV.VSPresetFormat)(16))) or
      typeof(cfYUV.VSPresetFormat)((1 shl typeof(cfYUV.VSPresetFormat)(8))) or
      typeof(cfYUV.VSPresetFormat)((0 shl typeof(cfYUV.VSPresetFormat)(0))))).VSPresetFormat
  pfYUV444P14* = (((cfYUV.VSPresetFormat shl typeof(cfYUV.VSPresetFormat)(28)) or
      typeof(cfYUV.VSPresetFormat)((stInteger.VSPresetFormat shl
      typeof(cfYUV.VSPresetFormat)(24))) or
      typeof(cfYUV.VSPresetFormat)((14 shl typeof(cfYUV.VSPresetFormat)(16))) or
      typeof(cfYUV.VSPresetFormat)((0 shl typeof(cfYUV.VSPresetFormat)(8))) or
      typeof(cfYUV.VSPresetFormat)((0 shl typeof(cfYUV.VSPresetFormat)(0))))).VSPresetFormat
  pfYUV420P16* = (((cfYUV.VSPresetFormat shl typeof(cfYUV.VSPresetFormat)(28)) or
      typeof(cfYUV.VSPresetFormat)((stInteger.VSPresetFormat shl
      typeof(cfYUV.VSPresetFormat)(24))) or
      typeof(cfYUV.VSPresetFormat)((16 shl typeof(cfYUV.VSPresetFormat)(16))) or
      typeof(cfYUV.VSPresetFormat)((1 shl typeof(cfYUV.VSPresetFormat)(8))) or
      typeof(cfYUV.VSPresetFormat)((1 shl typeof(cfYUV.VSPresetFormat)(0))))).VSPresetFormat
  pfYUV422P16* = (((cfYUV.VSPresetFormat shl typeof(cfYUV.VSPresetFormat)(28)) or
      typeof(cfYUV.VSPresetFormat)((stInteger.VSPresetFormat shl
      typeof(cfYUV.VSPresetFormat)(24))) or
      typeof(cfYUV.VSPresetFormat)((16 shl typeof(cfYUV.VSPresetFormat)(16))) or
      typeof(cfYUV.VSPresetFormat)((1 shl typeof(cfYUV.VSPresetFormat)(8))) or
      typeof(cfYUV.VSPresetFormat)((0 shl typeof(cfYUV.VSPresetFormat)(0))))).VSPresetFormat
  pfYUV444P16* = (((cfYUV.VSPresetFormat shl typeof(cfYUV.VSPresetFormat)(28)) or
      typeof(cfYUV.VSPresetFormat)((stInteger.VSPresetFormat shl
      typeof(cfYUV.VSPresetFormat)(24))) or
      typeof(cfYUV.VSPresetFormat)((16 shl typeof(cfYUV.VSPresetFormat)(16))) or
      typeof(cfYUV.VSPresetFormat)((0 shl typeof(cfYUV.VSPresetFormat)(8))) or
      typeof(cfYUV.VSPresetFormat)((0 shl typeof(cfYUV.VSPresetFormat)(0))))).VSPresetFormat
  pfYUV444PH* = (((cfYUV.VSPresetFormat shl typeof(cfYUV.VSPresetFormat)(28)) or
      typeof(cfYUV.VSPresetFormat)((stFloat.VSPresetFormat shl
      typeof(cfYUV.VSPresetFormat)(24))) or
      typeof(cfYUV.VSPresetFormat)((16 shl typeof(cfYUV.VSPresetFormat)(16))) or
      typeof(cfYUV.VSPresetFormat)((0 shl typeof(cfYUV.VSPresetFormat)(8))) or
      typeof(cfYUV.VSPresetFormat)((0 shl typeof(cfYUV.VSPresetFormat)(0))))).VSPresetFormat
  pfYUV444PS* = (((cfYUV.VSPresetFormat shl typeof(cfYUV.VSPresetFormat)(28)) or
      typeof(cfYUV.VSPresetFormat)((stFloat.VSPresetFormat shl
      typeof(cfYUV.VSPresetFormat)(24))) or
      typeof(cfYUV.VSPresetFormat)((32 shl typeof(cfYUV.VSPresetFormat)(16))) or
      typeof(cfYUV.VSPresetFormat)((0 shl typeof(cfYUV.VSPresetFormat)(8))) or
      typeof(cfYUV.VSPresetFormat)((0 shl typeof(cfYUV.VSPresetFormat)(0))))).VSPresetFormat
  pfRGB24* = (((cfRGB.VSPresetFormat shl typeof(cfRGB.VSPresetFormat)(28)) or
      typeof(cfRGB.VSPresetFormat)((stInteger.VSPresetFormat shl
      typeof(cfRGB.VSPresetFormat)(24))) or
      typeof(cfRGB.VSPresetFormat)((8 shl typeof(cfRGB.VSPresetFormat)(16))) or
      typeof(cfRGB.VSPresetFormat)((0 shl typeof(cfRGB.VSPresetFormat)(8))) or
      typeof(cfRGB.VSPresetFormat)((0 shl typeof(cfRGB.VSPresetFormat)(0))))).VSPresetFormat
  pfRGB27* = (((cfRGB.VSPresetFormat shl typeof(cfRGB.VSPresetFormat)(28)) or
      typeof(cfRGB.VSPresetFormat)((stInteger.VSPresetFormat shl
      typeof(cfRGB.VSPresetFormat)(24))) or
      typeof(cfRGB.VSPresetFormat)((9 shl typeof(cfRGB.VSPresetFormat)(16))) or
      typeof(cfRGB.VSPresetFormat)((0 shl typeof(cfRGB.VSPresetFormat)(8))) or
      typeof(cfRGB.VSPresetFormat)((0 shl typeof(cfRGB.VSPresetFormat)(0))))).VSPresetFormat
  pfRGB30* = (((cfRGB.VSPresetFormat shl typeof(cfRGB.VSPresetFormat)(28)) or
      typeof(cfRGB.VSPresetFormat)((stInteger.VSPresetFormat shl
      typeof(cfRGB.VSPresetFormat)(24))) or
      typeof(cfRGB.VSPresetFormat)((10 shl typeof(cfRGB.VSPresetFormat)(16))) or
      typeof(cfRGB.VSPresetFormat)((0 shl typeof(cfRGB.VSPresetFormat)(8))) or
      typeof(cfRGB.VSPresetFormat)((0 shl typeof(cfRGB.VSPresetFormat)(0))))).VSPresetFormat
  pfRGB36* = (((cfRGB.VSPresetFormat shl typeof(cfRGB.VSPresetFormat)(28)) or
      typeof(cfRGB.VSPresetFormat)((stInteger.VSPresetFormat shl
      typeof(cfRGB.VSPresetFormat)(24))) or
      typeof(cfRGB.VSPresetFormat)((12 shl typeof(cfRGB.VSPresetFormat)(16))) or
      typeof(cfRGB.VSPresetFormat)((0 shl typeof(cfRGB.VSPresetFormat)(8))) or
      typeof(cfRGB.VSPresetFormat)((0 shl typeof(cfRGB.VSPresetFormat)(0))))).VSPresetFormat
  pfRGB42* = (((cfRGB.VSPresetFormat shl typeof(cfRGB.VSPresetFormat)(28)) or
      typeof(cfRGB.VSPresetFormat)((stInteger.VSPresetFormat shl
      typeof(cfRGB.VSPresetFormat)(24))) or
      typeof(cfRGB.VSPresetFormat)((14 shl typeof(cfRGB.VSPresetFormat)(16))) or
      typeof(cfRGB.VSPresetFormat)((0 shl typeof(cfRGB.VSPresetFormat)(8))) or
      typeof(cfRGB.VSPresetFormat)((0 shl typeof(cfRGB.VSPresetFormat)(0))))).VSPresetFormat
  pfRGB48* = (((cfRGB.VSPresetFormat shl typeof(cfRGB.VSPresetFormat)(28)) or
      typeof(cfRGB.VSPresetFormat)((stInteger.VSPresetFormat shl
      typeof(cfRGB.VSPresetFormat)(24))) or
      typeof(cfRGB.VSPresetFormat)((16 shl typeof(cfRGB.VSPresetFormat)(16))) or
      typeof(cfRGB.VSPresetFormat)((0 shl typeof(cfRGB.VSPresetFormat)(8))) or
      typeof(cfRGB.VSPresetFormat)((0 shl typeof(cfRGB.VSPresetFormat)(0))))).VSPresetFormat
  pfRGBH* = (((cfRGB.VSPresetFormat shl typeof(cfRGB.VSPresetFormat)(28)) or
      typeof(cfRGB.VSPresetFormat)((stFloat.VSPresetFormat shl
      typeof(cfRGB.VSPresetFormat)(24))) or
      typeof(cfRGB.VSPresetFormat)((16 shl typeof(cfRGB.VSPresetFormat)(16))) or
      typeof(cfRGB.VSPresetFormat)((0 shl typeof(cfRGB.VSPresetFormat)(8))) or
      typeof(cfRGB.VSPresetFormat)((0 shl typeof(cfRGB.VSPresetFormat)(0))))).VSPresetFormat
  pfRGBS* = (((cfRGB.VSPresetFormat shl typeof(cfRGB.VSPresetFormat)(28)) or
      typeof(cfRGB.VSPresetFormat)((stFloat.VSPresetFormat shl
      typeof(cfRGB.VSPresetFormat)(24))) or
      typeof(cfRGB.VSPresetFormat)((32 shl typeof(cfRGB.VSPresetFormat)(16))) or
      typeof(cfRGB.VSPresetFormat)((0 shl typeof(cfRGB.VSPresetFormat)(8))) or
      typeof(cfRGB.VSPresetFormat)((0 shl typeof(cfRGB.VSPresetFormat)(0))))).VSPresetFormat
  fmParallel* = (0).VSFilterMode ## ```
                                 ##   completely parallel execution
                                 ## ```
  fmParallelRequests* = (1).VSFilterMode ## ```
                                         ##   for filters that are serial in nature but can request one or more frames they need in advance
                                         ## ```
  fmUnordered* = (2).VSFilterMode ## ```
                                  ##   for filters that modify their internal state every request like source filters that read a file
                                  ## ```
  fmFrameState* = (3).VSFilterMode ## ```
                                   ##   DO NOT USE UNLESS ABSOLUTELY NECESSARY, for compatibility with external code that can only keep the processing state of a single frame at a time
                                   ## ```
  mtVideo* = (1).VSMediaType
  mtAudio* = (2).VSMediaType
  acFrontLeft* = (0).VSAudioChannels
  acFrontRight* = (1).VSAudioChannels
  acFrontCenter* = (2).VSAudioChannels
  acLowFrequency* = (3).VSAudioChannels
  acBackLeft* = (4).VSAudioChannels
  acBackRight* = (5).VSAudioChannels
  acFrontLeftOFCenter* = (6).VSAudioChannels
  acFrontRightOFCenter* = (7).VSAudioChannels
  acBackCenter* = (8).VSAudioChannels
  acSideLeft* = (9).VSAudioChannels
  acSideRight* = (10).VSAudioChannels
  acTopCenter* = (11).VSAudioChannels
  acTopFrontLeft* = (12).VSAudioChannels
  acTopFrontCenter* = (13).VSAudioChannels
  acTopFrontRight* = (14).VSAudioChannels
  acTopBackLeft* = (15).VSAudioChannels
  acTopBackCenter* = (16).VSAudioChannels
  acTopBackRight* = (17).VSAudioChannels
  acStereoLeft* = (29).VSAudioChannels
  acStereoRight* = (30).VSAudioChannels
  acWideLeft* = (31).VSAudioChannels
  acWideRight* = (32).VSAudioChannels
  acSurroundDirectLeft* = (33).VSAudioChannels
  acSurroundDirectRight* = (34).VSAudioChannels
  acLowFrequency2* = (35).VSAudioChannels
  ptUnset* = (0).VSPropertyType
  ptInt* = (1).VSPropertyType
  ptFloat* = (2).VSPropertyType
  ptData* = (3).VSPropertyType
  ptFunction* = (4).VSPropertyType
  ptVideoNode* = (5).VSPropertyType
  ptAudioNode* = (6).VSPropertyType
  ptVideoFrame* = (7).VSPropertyType
  ptAudioFrame* = (8).VSPropertyType
  peSuccess* = (0).VSMapPropertyError
  peUnset* = (1).VSMapPropertyError ## ```
                                    ##   no key exists
                                    ## ```
  peType* = (2).VSMapPropertyError ## ```
                                   ##   key exists but not of a compatible type
                                   ## ```
  peIndex* = (4).VSMapPropertyError ## ```
                                    ##   index out of bounds
                                    ## ```
  peError* = (3).VSMapPropertyError ## ```
                                    ##   map has error state set
                                    ## ```
  maReplace* = (0).VSMapAppendMode
  maAppend* = (1).VSMapAppendMode
  arInitial* = (0).VSActivationReason
  arAllFramesReady* = (1).VSActivationReason
  arError* = (-1).VSActivationReason
  mtDebug* = (0).VSMessageType
  mtInformation* = (1).VSMessageType
  mtWarning* = (2).VSMessageType
  mtCritical* = (3).VSMessageType
  mtFatal* = (4).VSMessageType ## ```
                               ##   also terminates the process, should generally not be used by normal filters
                               ## ```
  ccfEnableGraphInspection* = (1).VSCoreCreationFlags
  ccfDisableAutoLoading* = (2).VSCoreCreationFlags
  ccfDisableLibraryUnloading* = (4).VSCoreCreationFlags
  pcModifiable* = (1).VSPluginConfigFlags
  dtUnknown* = (-1).VSDataTypeHint
  dtBinary* = (0).VSDataTypeHint
  dtUtf8* = (1).VSDataTypeHint
  rpGeneral* = (0).VSRequestPattern ## ```
                                    ##   General pattern
                                    ## ```
  rpNoFrameReuse* = (1).VSRequestPattern ## ```
                                         ##   When requesting all output frames from the filter no frame will be requested more than once from this input clip, never requests frames beyond the end of the clip
                                         ## ```
  rpStrictSpatial* = (2).VSRequestPattern ## ```
                                          ##   Always (and only) requests frame n from input clip when generating output frame n, never requests frames beyond the end of the clip
                                          ## ```
type
  VSFrame* {.importc, impVapourSynth4Hdr, incompleteStruct.} = object
  VSNode* {.importc, impVapourSynth4Hdr, incompleteStruct.} = object
  VSCore* {.importc, impVapourSynth4Hdr, incompleteStruct.} = object
  VSPlugin* {.importc, impVapourSynth4Hdr, incompleteStruct.} = object
  VSPluginFunction* {.importc, impVapourSynth4Hdr, incompleteStruct.} = object
  VSFunction* {.importc, impVapourSynth4Hdr, incompleteStruct.} = object
  VSMap* {.importc, impVapourSynth4Hdr, incompleteStruct.} = object
  VSLogHandle* {.importc, impVapourSynth4Hdr, incompleteStruct.} = object
  VSFrameContext* {.importc, impVapourSynth4Hdr, incompleteStruct.} = object
  VSPLUGINAPI* {.importc, impVapourSynth4Hdr, bycopy.} = object
    getAPIVersion*: proc (): cint {.cdecl.} ## ```
                                            ##   returns VAPOURSYNTH_API_VERSION of the library
                                            ## ```
    configPlugin*: proc (identifier: cstring; pluginNamespace: cstring;
                         name: cstring; pluginVersion: cint; apiVersion: cint;
                         flags: cint; plugin: ptr VSPlugin): cint {.cdecl.} ## ```
                                                                            ##   use the VS_MAKE_VERSION macro for pluginVersion
                                                                            ## ```
    registerFunction*: proc (name: cstring; args: cstring; returnType: cstring;
                             argsFunc: VSPublicFunction; functionData: pointer;
                             plugin: ptr VSPlugin): cint {.cdecl.} ## ```
                                                                   ##   non-zero return value on success
                                                                   ## ```
  
  VSAPI* {.importc, impVapourSynth4Hdr, bycopy.} = object
    createVideoFilter*: proc (`out`: ptr VSMap; name: cstring;
                              vi: ptr VSVideoInfo; getFrame: VSFilterGetFrame;
                              free: VSFilterFree; filterMode: cint;
                              dependencies: ptr VSFilterDependency;
                              numDeps: cint; instanceData: pointer;
                              core: ptr VSCore) {.cdecl.} ## ```
                                                          ##   output nodes are appended to the clip key in the out map
                                                          ## ```
    createVideoFilter2*: proc (name: cstring; vi: ptr VSVideoInfo;
                               getFrame: VSFilterGetFrame; free: VSFilterFree;
                               filterMode: cint;
                               dependencies: ptr VSFilterDependency;
                               numDeps: cint; instanceData: pointer;
                               core: ptr VSCore): ptr VSNode {.cdecl.} ## ```
                                                                       ##   same as createVideoFilter but returns a pointer to the VSNode directly or NULL on failure
                                                                       ## ```
    createAudioFilter*: proc (`out`: ptr VSMap; name: cstring;
                              ai: ptr VSAudioInfo; getFrame: VSFilterGetFrame;
                              free: VSFilterFree; filterMode: cint;
                              dependencies: ptr VSFilterDependency;
                              numDeps: cint; instanceData: pointer;
                              core: ptr VSCore) {.cdecl.} ## ```
                                                          ##   output nodes are appended to the clip key in the out map
                                                          ## ```
    createAudioFilter2*: proc (name: cstring; ai: ptr VSAudioInfo;
                               getFrame: VSFilterGetFrame; free: VSFilterFree;
                               filterMode: cint;
                               dependencies: ptr VSFilterDependency;
                               numDeps: cint; instanceData: pointer;
                               core: ptr VSCore): ptr VSNode {.cdecl.} ## ```
                                                                       ##   same as createAudioFilter but returns a pointer to the VSNode directly or NULL on failure
                                                                       ## ```
    setLinearFilter*: proc (node: ptr VSNode): cint {.cdecl.} ## ```
                                                              ##   Use right after create*Filter*, sets the correct cache mode for using the cacheFrame API and returns the recommended upper number of additional frames to cache per request
                                                              ## ```
    setCacheMode*: proc (node: ptr VSNode; mode: cint) {.cdecl.} ## ```
                                                                 ##   -1: default (auto), 0: force disable, 1: force enable, changing the cache mode also resets all options to their default
                                                                 ## ```
    setCacheOptions*: proc (node: ptr VSNode; fixedSize: cint; maxSize: cint;
                            maxHistorySize: cint) {.cdecl.} ## ```
                                                            ##   passing -1 means no change
                                                            ## ```
    freeNode*: proc (node: ptr VSNode) {.cdecl.}
    addNodeRef*: proc (node: ptr VSNode): ptr VSNode {.cdecl.}
    getNodeType*: proc (node: ptr VSNode): cint {.cdecl.} ## ```
                                                          ##   returns VSMediaType
                                                          ## ```
    getVideoInfo*: proc (node: ptr VSNode): ptr VSVideoInfo {.cdecl.} ## ```
                                                                      ##   returns VSMediaType
                                                                      ## ```
    getAudioInfo*: proc (node: ptr VSNode): ptr VSAudioInfo {.cdecl.}
    newVideoFrame*: proc (format: ptr VSVideoFormat; width: cint; height: cint;
                          propSrc: ptr VSFrame; core: ptr VSCore): ptr VSFrame {.
        cdecl.}              ## ```
                             ##   Frame related functions
                             ## ```
    newVideoFrame2*: proc (format: ptr VSVideoFormat; width: cint; height: cint;
                           planeSrc: ptr ptr VSFrame; planes: ptr cint;
                           propSrc: ptr VSFrame; core: ptr VSCore): ptr VSFrame {.
        cdecl.} ## ```
                ##   same as newVideoFrame but allows the specified planes to be effectively copied from the source frames
                ## ```
    newAudioFrame*: proc (format: ptr VSAudioFormat; numSamples: cint;
                          propSrc: ptr VSFrame; core: ptr VSCore): ptr VSFrame {.
        cdecl.} ## ```
                ##   same as newVideoFrame but allows the specified planes to be effectively copied from the source frames
                ## ```
    newAudioFrame2*: proc (format: ptr VSAudioFormat; numSamples: cint;
                           channelSrc: ptr ptr VSFrame; channels: ptr cint;
                           propSrc: ptr VSFrame; core: ptr VSCore): ptr VSFrame {.
        cdecl.} ## ```
                ##   same as newAudioFrame but allows the specified channels to be effectively copied from the source frames
                ## ```
    freeFrame*: proc (f: ptr VSFrame) {.cdecl.} ## ```
                                                ##   same as newAudioFrame but allows the specified channels to be effectively copied from the source frames
                                                ## ```
    addFrameRef*: proc (f: ptr VSFrame): ptr VSFrame {.cdecl.}
    copyFrame*: proc (f: ptr VSFrame; core: ptr VSCore): ptr VSFrame {.cdecl.}
    getFramePropertiesRO*: proc (f: ptr VSFrame): ptr VSMap {.cdecl.}
    getFramePropertiesRW*: proc (f: ptr VSFrame): ptr VSMap {.cdecl.}
    getStride*: proc (f: ptr VSFrame; plane: cint): ByteAddress {.cdecl.}
    getReadPtr*: proc (f: ptr VSFrame; plane: cint): ptr uint8 {.cdecl.}
    getWritePtr*: proc (f: ptr VSFrame; plane: cint): ptr uint8 {.cdecl.} ## ```
                                                                          ##   calling this function invalidates previously gotten read pointers to the same frame
                                                                          ## ```
    getVideoFrameFormat*: proc (f: ptr VSFrame): ptr VSVideoFormat {.cdecl.}
    getAudioFrameFormat*: proc (f: ptr VSFrame): ptr VSAudioFormat {.cdecl.}
    getFrameType*: proc (f: ptr VSFrame): cint {.cdecl.} ## ```
                                                         ##   returns VSMediaType
                                                         ## ```
    getFrameWidth*: proc (f: ptr VSFrame; plane: cint): cint {.cdecl.} ## ```
                                                                       ##   returns VSMediaType
                                                                       ## ```
    getFrameHeight*: proc (f: ptr VSFrame; plane: cint): cint {.cdecl.}
    getFrameLength*: proc (f: ptr VSFrame): cint {.cdecl.} ## ```
                                                           ##   returns the number of samples for audio frames 
                                                           ##      General format functions
                                                           ## ```
    getVideoFormatName*: proc (format: ptr VSVideoFormat; buffer: cstring): cint {.
        cdecl.} ## ```
                ##   up to 32 characters including terminating null may be written to the buffer, non-zero return value on success
                ## ```
    getAudioFormatName*: proc (format: ptr VSAudioFormat; buffer: cstring): cint {.
        cdecl.} ## ```
                ##   up to 32 characters including terminating null may be written to the buffer, non-zero return value on success
                ## ```
    queryVideoFormat*: proc (format: ptr VSVideoFormat; colorFamily: cint;
                             sampleType: cint; bitsPerSample: cint;
                             subSamplingW: cint; subSamplingH: cint;
                             core: ptr VSCore): cint {.cdecl.} ## ```
                                                               ##   non-zero return value on success
                                                               ## ```
    queryAudioFormat*: proc (format: ptr VSAudioFormat; sampleType: cint;
                             bitsPerSample: cint; channelLayout: uint64;
                             core: ptr VSCore): cint {.cdecl.} ## ```
                                                               ##   non-zero return value on success
                                                               ## ```
    queryVideoFormatID*: proc (colorFamily: cint; sampleType: cint;
                               bitsPerSample: cint; subSamplingW: cint;
                               subSamplingH: cint; core: ptr VSCore): uint32 {.
        cdecl.}              ## ```
                             ##   returns 0 on failure
                             ## ```
    getVideoFormatByID*: proc (format: ptr VSVideoFormat; id: uint32;
                               core: ptr VSCore): cint {.cdecl.} ## ```
                                                                 ##   non-zero return value on success 
                                                                 ##      Frame request and filter getframe functions
                                                                 ## ```
    getFrame*: proc (n: cint; node: ptr VSNode; errorMsg: cstring; bufSize: cint): ptr VSFrame {.
        cdecl.} ## ```
                ##   only for external applications using the core as a library or for requesting frames in a filter constructor, do not use inside a filter's getframe function
                ## ```
    getFrameAsync*: proc (n: cint; node: ptr VSNode;
                          callback: VSFrameDoneCallback; userData: pointer) {.
        cdecl.} ## ```
                ##   only for external applications using the core as a library or for requesting frames in a filter constructor, do not use inside a filter's getframe function
                ## ```
    getFrameFilter*: proc (n: cint; node: ptr VSNode;
                           frameCtx: ptr VSFrameContext): ptr VSFrame {.cdecl.} ## ```
                                                                                ##   only use inside a filter's getframe function
                                                                                ## ```
    requestFrameFilter*: proc (n: cint; node: ptr VSNode;
                               frameCtx: ptr VSFrameContext) {.cdecl.} ## ```
                                                                       ##   only use inside a filter's getframe function
                                                                       ## ```
    releaseFrameEarly*: proc (node: ptr VSNode; n: cint;
                              frameCtx: ptr VSFrameContext) {.cdecl.} ## ```
                                                                      ##   only use inside a filter's getframe function, unless this function is called a requested frame is kept in memory until the end of processing the current frame
                                                                      ## ```
    cacheFrame*: proc (frame: ptr VSFrame; n: cint; frameCtx: ptr VSFrameContext) {.
        cdecl.} ## ```
                ##   used to store intermediate frames in cache, useful for filters where random access is slow, must call setLinearFilter on the node before using or the result is undefined
                ## ```
    setFilterError*: proc (errorMessage: cstring; frameCtx: ptr VSFrameContext) {.
        cdecl.} ## ```
                ##   used to signal errors in the filter getframe function 
                ##      External functions
                ## ```
    createFunction*: proc (`func`: VSPublicFunction; userData: pointer;
                           free: VSFreeFunctionData; core: ptr VSCore): ptr VSFunction {.
        cdecl.} ## ```
                ##   used to signal errors in the filter getframe function 
                ##      External functions
                ## ```
    freeFunction*: proc (f: ptr VSFunction) {.cdecl.}
    addFunctionRef*: proc (f: ptr VSFunction): ptr VSFunction {.cdecl.}
    callFunction*: proc (`func`: ptr VSFunction; `in`: ptr VSMap;
                         `out`: ptr VSMap) {.cdecl.}
    createMap*: proc (): ptr VSMap {.cdecl.} ## ```
                                             ##   Map and property access functions
                                             ## ```
    freeMap*: proc (map: ptr VSMap) {.cdecl.}
    clearMap*: proc (map: ptr VSMap) {.cdecl.}
    copyMap*: proc (src: ptr VSMap; dst: ptr VSMap) {.cdecl.} ## ```
                                                              ##   copies all values in src to dst, if a key already exists in dst it's replaced
                                                              ## ```
    mapSetError*: proc (map: ptr VSMap; errorMessage: cstring) {.cdecl.} ## ```
                                                                         ##   used to signal errors outside filter getframe function
                                                                         ## ```
    mapGetError*: proc (map: ptr VSMap): cstring {.cdecl.} ## ```
                                                           ##   used to query errors, returns 0 if no error
                                                           ## ```
    mapNumKeys*: proc (map: ptr VSMap): cint {.cdecl.}
    mapGetKey*: proc (map: ptr VSMap; index: cint): cstring {.cdecl.}
    mapDeleteKey*: proc (map: ptr VSMap; key: cstring): cint {.cdecl.}
    mapNumElements*: proc (map: ptr VSMap; key: cstring): cint {.cdecl.} ## ```
                                                                         ##   returns -1 if a key doesn't exist
                                                                         ## ```
    mapGetType*: proc (map: ptr VSMap; key: cstring): cint {.cdecl.} ## ```
                                                                     ##   returns VSPropertyType
                                                                     ## ```
    mapSetEmpty*: proc (map: ptr VSMap; key: cstring; `type`: cint): cint {.
        cdecl.}              ## ```
                             ##   returns VSPropertyType
                             ## ```
    mapGetInt*: proc (map: ptr VSMap; key: cstring; index: cint; error: ptr cint): int64 {.
        cdecl.}
    mapGetIntSaturated*: proc (map: ptr VSMap; key: cstring; index: cint;
                               error: ptr cint): cint {.cdecl.}
    mapGetIntArray*: proc (map: ptr VSMap; key: cstring; error: ptr cint): ptr int64 {.
        cdecl.}
    mapSetInt*: proc (map: ptr VSMap; key: cstring; i: int64; append: cint): cint {.
        cdecl.}
    mapSetIntArray*: proc (map: ptr VSMap; key: cstring; i: ptr int64;
                           size: cint): cint {.cdecl.}
    mapGetFloat*: proc (map: ptr VSMap; key: cstring; index: cint;
                        error: ptr cint): cdouble {.cdecl.}
    mapGetFloatSaturated*: proc (map: ptr VSMap; key: cstring; index: cint;
                                 error: ptr cint): cfloat {.cdecl.}
    mapGetFloatArray*: proc (map: ptr VSMap; key: cstring; error: ptr cint): ptr cdouble {.
        cdecl.}
    mapSetFloat*: proc (map: ptr VSMap; key: cstring; d: cdouble; append: cint): cint {.
        cdecl.}
    mapSetFloatArray*: proc (map: ptr VSMap; key: cstring; d: ptr cdouble;
                             size: cint): cint {.cdecl.}
    mapGetData*: proc (map: ptr VSMap; key: cstring; index: cint;
                       error: ptr cint): cstring {.cdecl.}
    mapGetDataSize*: proc (map: ptr VSMap; key: cstring; index: cint;
                           error: ptr cint): cint {.cdecl.}
    mapGetDataTypeHint*: proc (map: ptr VSMap; key: cstring; index: cint;
                               error: ptr cint): cint {.cdecl.} ## ```
                                                                ##   returns VSDataTypeHint
                                                                ## ```
    mapSetData*: proc (map: ptr VSMap; key: cstring; data: cstring; size: cint;
                       `type`: cint; append: cint): cint {.cdecl.} ## ```
                                                                   ##   returns VSDataTypeHint
                                                                   ## ```
    mapGetNode*: proc (map: ptr VSMap; key: cstring; index: cint;
                       error: ptr cint): ptr VSNode {.cdecl.}
    mapSetNode*: proc (map: ptr VSMap; key: cstring; node: ptr VSNode;
                       append: cint): cint {.cdecl.} ## ```
                                                     ##   returns 0 on success
                                                     ## ```
    mapConsumeNode*: proc (map: ptr VSMap; key: cstring; node: ptr VSNode;
                           append: cint): cint {.cdecl.} ## ```
                                                         ##   always consumes the reference, even on error
                                                         ## ```
    mapGetFrame*: proc (map: ptr VSMap; key: cstring; index: cint;
                        error: ptr cint): ptr VSFrame {.cdecl.}
    mapSetFrame*: proc (map: ptr VSMap; key: cstring; f: ptr VSFrame;
                        append: cint): cint {.cdecl.} ## ```
                                                      ##   returns 0 on success
                                                      ## ```
    mapConsumeFrame*: proc (map: ptr VSMap; key: cstring; f: ptr VSFrame;
                            append: cint): cint {.cdecl.} ## ```
                                                          ##   always consumes the reference, even on error
                                                          ## ```
    mapGetFunction*: proc (map: ptr VSMap; key: cstring; index: cint;
                           error: ptr cint): ptr VSFunction {.cdecl.}
    mapSetFunction*: proc (map: ptr VSMap; key: cstring; `func`: ptr VSFunction;
                           append: cint): cint {.cdecl.} ## ```
                                                         ##   returns 0 on success
                                                         ## ```
    mapConsumeFunction*: proc (map: ptr VSMap; key: cstring;
                               `func`: ptr VSFunction; append: cint): cint {.
        cdecl.}              ## ```
                             ##   always consumes the reference, even on error 
                             ##      Plugin and plugin function related
                             ## ```
    registerFunction*: proc (name: cstring; args: cstring; returnType: cstring;
                             argsFunc: VSPublicFunction; functionData: pointer;
                             plugin: ptr VSPlugin): cint {.cdecl.} ## ```
                                                                   ##   non-zero return value on success
                                                                   ## ```
    getPluginByID*: proc (identifier: cstring; core: ptr VSCore): ptr VSPlugin {.
        cdecl.}              ## ```
                             ##   non-zero return value on success
                             ## ```
    getPluginByNamespace*: proc (ns: cstring; core: ptr VSCore): ptr VSPlugin {.
        cdecl.}
    getNextPlugin*: proc (plugin: ptr VSPlugin; core: ptr VSCore): ptr VSPlugin {.
        cdecl.}              ## ```
                             ##   pass NULL to get the first plugin
                             ## ```
    getPluginName*: proc (plugin: ptr VSPlugin): cstring {.cdecl.} ## ```
                                                                   ##   pass NULL to get the first plugin
                                                                   ## ```
    getPluginID*: proc (plugin: ptr VSPlugin): cstring {.cdecl.}
    getPluginNamespace*: proc (plugin: ptr VSPlugin): cstring {.cdecl.}
    getNextPluginFunction*: proc (`func`: ptr VSPluginFunction;
                                  plugin: ptr VSPlugin): ptr VSPluginFunction {.
        cdecl.}              ## ```
                             ##   pass NULL to get the first plugin function
                             ## ```
    getPluginFunctionByName*: proc (name: cstring; plugin: ptr VSPlugin): ptr VSPluginFunction {.
        cdecl.}              ## ```
                             ##   pass NULL to get the first plugin function
                             ## ```
    getPluginFunctionName*: proc (`func`: ptr VSPluginFunction): cstring {.cdecl.}
    getPluginFunctionArguments*: proc (`func`: ptr VSPluginFunction): cstring {.
        cdecl.}              ## ```
                             ##   returns an argument format string
                             ## ```
    getPluginFunctionReturnType*: proc (`func`: ptr VSPluginFunction): cstring {.
        cdecl.}              ## ```
                             ##   returns an argument format string
                             ## ```
    getPluginPath*: proc (plugin: ptr VSPlugin): cstring {.cdecl.} ## ```
                                                                   ##   the full path to the loaded library file containing the plugin entry point
                                                                   ## ```
    getPluginVersion*: proc (plugin: ptr VSPlugin): cint {.cdecl.} ## ```
                                                                   ##   the full path to the loaded library file containing the plugin entry point
                                                                   ## ```
    invoke*: proc (plugin: ptr VSPlugin; name: cstring; args: ptr VSMap): ptr VSMap {.
        cdecl.}              ## ```
                             ##   user must free the returned VSMap 
                             ##      Core and information
                             ## ```
    createCore*: proc (flags: cint): ptr VSCore {.cdecl.} ## ```
                                                          ##   flags uses the VSCoreCreationFlags enum
                                                          ## ```
    freeCore*: proc (core: ptr VSCore) {.cdecl.} ## ```
                                                 ##   only call this function after all node, frame and function references belonging to the core have been freed
                                                 ## ```
    setMaxCacheSize*: proc (bytes: int64; core: ptr VSCore): int64 {.cdecl.} ## ```
                                                                             ##   the total cache size at which vapoursynth more aggressively tries to reclaim memory, it is not a hard limit
                                                                             ## ```
    setThreadCount*: proc (threads: cint; core: ptr VSCore): cint {.cdecl.} ## ```
                                                                            ##   setting threads to 0 means automatic detection
                                                                            ## ```
    getCoreInfo*: proc (core: ptr VSCore; info: ptr VSCoreInfo) {.cdecl.} ## ```
                                                                          ##   setting threads to 0 means automatic detection
                                                                          ## ```
    getAPIVersion*: proc (): cint {.cdecl.}
    logMessage*: proc (msgType: cint; msg: cstring; core: ptr VSCore) {.cdecl.} ## ```
                                                                                ##   Message handler
                                                                                ## ```
    addLogHandler*: proc (handler: VSLogHandler; free: VSLogHandlerFree;
                          userData: pointer; core: ptr VSCore): ptr VSLogHandle {.
        cdecl.} ## ```
                ##   free and userData can be NULL, returns a handle that can be passed to removeLogHandler
                ## ```
    removeLogHandler*: proc (handle: ptr VSLogHandle; core: ptr VSCore): cint {.
        cdecl.}              ## ```
                             ##   returns non-zero if successfully removed
                             ## ```
  
  VSVideoFormat* {.bycopy, impVapourSynth4Hdr, importc: "struct VSVideoFormat".} = object
    colorFamily*: cint       ## ```
                             ##   see VSColorFamily
                             ## ```
    sampleType*: cint        ## ```
                             ##   see VSSampleType
                             ## ```
    bitsPerSample*: cint     ## ```
                             ##   number of significant bits
                             ## ```
    bytesPerSample*: cint ## ```
                          ##   actual storage is always in a power of 2 and the smallest possible that can fit the number of bits used per sample
                          ## ```
    subSamplingW*: cint ## ```
                        ##   log2 subsampling factor, applied to second and third plane
                        ## ```
    subSamplingH*: cint ## ```
                        ##   log2 subsampling factor, applied to second and third plane
                        ## ```
    numPlanes*: cint         ## ```
                             ##   implicit from colorFamily
                             ## ```
  
  VSAudioFormat* {.bycopy, impVapourSynth4Hdr, importc: "struct VSAudioFormat".} = object
    sampleType*: cint
    bitsPerSample*: cint
    bytesPerSample*: cint    ## ```
                             ##   implicit from bitsPerSample
                             ## ```
    numChannels*: cint       ## ```
                             ##   implicit from channelLayout
                             ## ```
    channelLayout*: uint64   ## ```
                             ##   implicit from channelLayout
                             ## ```
  
  VSCoreInfo* {.bycopy, impVapourSynth4Hdr, importc: "struct VSCoreInfo".} = object
    versionString*: cstring
    core*: cint
    api*: cint
    numThreads*: cint
    maxFramebufferSize*: int64
    usedFramebufferSize*: int64

  VSVideoInfo* {.bycopy, impVapourSynth4Hdr, importc: "struct VSVideoInfo".} = object
    format*: VSVideoFormat
    fpsNum*: int64
    fpsDen*: int64
    width*: cint
    height*: cint
    numFrames*: cint

  VSAudioInfo* {.bycopy, impVapourSynth4Hdr, importc: "struct VSAudioInfo".} = object
    format*: VSAudioFormat
    sampleRate*: cint
    numSamples*: int64
    numFrames*: cint ## ```
                     ##   the total number of audio frames needed to hold numSamples, implicit from numSamples when calling createAudioFilter
                     ## ```
  
  VSGetVapourSynthAPI* {.importc, impVapourSynth4Hdr.} = proc (version: cint): ptr VSAPI {.
      cdecl.}
  VSPublicFunction* {.importc, impVapourSynth4Hdr.} = proc (`in`: ptr VSMap;
      `out`: ptr VSMap; userData: pointer; core: ptr VSCore; vsapi: ptr VSAPI) {.
      cdecl.}
  VSInitPlugin* {.importc, impVapourSynth4Hdr.} = proc (plugin: ptr VSPlugin;
      vspapi: ptr VSPLUGINAPI) {.cdecl.}
  VSFreeFunctionData* {.importc, impVapourSynth4Hdr.} = proc (userData: pointer) {.
      cdecl.}
  VSFilterGetFrame* {.importc, impVapourSynth4Hdr.} = proc (n: cint;
      activationReason: cint; instanceData: pointer; frameData: ptr pointer;
      frameCtx: ptr VSFrameContext; core: ptr VSCore; vsapi: ptr VSAPI): ptr VSFrame {.
      cdecl.}
  VSFilterFree* {.importc, impVapourSynth4Hdr.} = proc (instanceData: pointer;
      core: ptr VSCore; vsapi: ptr VSAPI) {.cdecl.}
  VSFrameDoneCallback* {.importc, impVapourSynth4Hdr.} = proc (
      userData: pointer; f: ptr VSFrame; n: cint; node: ptr VSNode;
      errorMsg: cstring) {.cdecl.}
  VSLogHandler* {.importc, impVapourSynth4Hdr.} = proc (msgType: cint;
      msg: cstring; userData: pointer) {.cdecl.}
  VSLogHandlerFree* {.importc, impVapourSynth4Hdr.} = proc (userData: pointer) {.
      cdecl.}
  VSFilterDependency* {.bycopy, impVapourSynth4Hdr,
                        importc: "struct VSFilterDependency".} = object
    source*: ptr VSNode
    requestPattern*: cint    ## ```
                             ##   VSRequestPattern
                             ## ```
  
proc getVapourSynthAPI*(version: cint): ptr VSAPI {.importc, cdecl,
    impVapourSynth4Hdr.}
{.pop.}
