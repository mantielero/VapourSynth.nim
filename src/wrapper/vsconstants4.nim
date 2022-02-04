# Generated @ 2022-01-07T20:04:42+01:00
# Command line:
#   /home/jose/.nimble/pkgs/nimterop-0.6.13/nimterop/toast -pnkr /usr/include/vapoursynth/VSConstants4.h

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


{.pragma: impVSConstants4Hdr, header: "/usr/include/vapoursynth/VSConstants4.h".}
{.experimental: "codeReordering".}
defineEnum(VSColorRange)
defineEnum(VSChromaLocation)
defineEnum(VSFieldBased)
defineEnum(VSMatrixCoefficients)
defineEnum(VSTransferCharacteristics)
defineEnum(VSColorPrimaries)
const
  VSC_RANGE_FULL* = (0).VSColorRange
  VSC_RANGE_LIMITED* = (1).VSColorRange
  VSC_CHROMA_LEFT* = (0).VSChromaLocation
  VSC_CHROMA_CENTER* = (1).VSChromaLocation
  VSC_CHROMA_TOP_LEFT* = (2).VSChromaLocation
  VSC_CHROMA_TOP* = (3).VSChromaLocation
  VSC_CHROMA_BOTTOM_LEFT* = (4).VSChromaLocation
  VSC_CHROMA_BOTTOM* = (5).VSChromaLocation
  VSC_FIELD_PROGRESSIVE* = (0).VSFieldBased
  VSC_FIELD_BOTTOM* = (1).VSFieldBased
  VSC_FIELD_TOP* = (2).VSFieldBased
  VSC_MATRIX_RGB* = (0).VSMatrixCoefficients
  VSC_MATRIX_BT709* = (1).VSMatrixCoefficients
  VSC_MATRIX_UNSPECIFIED* = (2).VSMatrixCoefficients
  VSC_MATRIX_FCC* = (4).VSMatrixCoefficients
  VSC_MATRIX_BT470_BG* = (5).VSMatrixCoefficients
  VSC_MATRIX_ST170_M* = (6).VSMatrixCoefficients ## ```
                                                 ##   Equivalent to 5.
                                                 ## ```
  VSC_MATRIX_ST240_M* = (7).VSMatrixCoefficients ## ```
                                                 ##   Equivalent to 5.
                                                 ## ```
  VSC_MATRIX_YCGCO* = (8).VSMatrixCoefficients
  VSC_MATRIX_BT2020_NCL* = (9).VSMatrixCoefficients
  VSC_MATRIX_BT2020_CL* = (10).VSMatrixCoefficients
  VSC_MATRIX_CHROMATICITY_DERIVED_NCL* = (12).VSMatrixCoefficients
  VSC_MATRIX_CHROMATICITY_DERIVED_CL* = (13).VSMatrixCoefficients
  VSC_MATRIX_ICTCP* = (14).VSMatrixCoefficients
  VSC_TRANSFER_BT709* = (1).VSTransferCharacteristics
  VSC_TRANSFER_UNSPECIFIED* = (2).VSTransferCharacteristics
  VSC_TRANSFER_BT470_M* = (4).VSTransferCharacteristics
  VSC_TRANSFER_BT470_BG* = (5).VSTransferCharacteristics
  VSC_TRANSFER_BT601* = (6).VSTransferCharacteristics ## ```
                                                      ##   Equivalent to 1.
                                                      ## ```
  VSC_TRANSFER_ST240_M* = (7).VSTransferCharacteristics ## ```
                                                        ##   Equivalent to 1.
                                                        ## ```
  VSC_TRANSFER_LINEAR* = (8).VSTransferCharacteristics
  VSC_TRANSFER_LOG_100* = (9).VSTransferCharacteristics
  VSC_TRANSFER_LOG_316* = (10).VSTransferCharacteristics
  VSC_TRANSFER_IEC_61966_2_4* = (11).VSTransferCharacteristics
  VSC_TRANSFER_IEC_61966_2_1* = (13).VSTransferCharacteristics
  VSC_TRANSFER_BT2020_10* = (14).VSTransferCharacteristics ## ```
                                                           ##   Equivalent to 1.
                                                           ## ```
  VSC_TRANSFER_BT2020_12* = (15).VSTransferCharacteristics ## ```
                                                           ##   Equivalent to 1.
                                                           ## ```
  VSC_TRANSFER_ST2084* = (16).VSTransferCharacteristics ## ```
                                                        ##   Equivalent to 1.
                                                        ## ```
  VSC_TRANSFER_ARIB_B67* = (18).VSTransferCharacteristics
  VSC_PRIMARIES_BT709* = (1).VSColorPrimaries
  VSC_PRIMARIES_UNSPECIFIED* = (2).VSColorPrimaries
  VSC_PRIMARIES_BT470_M* = (4).VSColorPrimaries
  VSC_PRIMARIES_BT470_BG* = (5).VSColorPrimaries
  VSC_PRIMARIES_ST170_M* = (6).VSColorPrimaries
  VSC_PRIMARIES_ST240_M* = (7).VSColorPrimaries ## ```
                                                ##   Equivalent to 6.
                                                ## ```
  VSC_PRIMARIES_FILM* = (8).VSColorPrimaries ## ```
                                             ##   Equivalent to 6.
                                             ## ```
  VSC_PRIMARIES_BT2020* = (9).VSColorPrimaries
  VSC_PRIMARIES_ST428* = (10).VSColorPrimaries
  VSC_PRIMARIES_ST431_2* = (11).VSColorPrimaries
  VSC_PRIMARIES_ST432_1* = (12).VSColorPrimaries
  VSC_PRIMARIES_EBU3213_E* = (22).VSColorPrimaries
{.pop.}
