import ../src/vapoursynth


let ini = vsscript_init()
doAssert(ini > 0, "Failed to initialize VapourSynth environment")

var handle:ptr VSScript

# Initialize script environment
#var n = vsscript_createScript(handle)


let scriptFilename:cstring = "script.vpy"
#echo $scriptFilename
let dos = vsscript_evaluateFile( handle.addr,
                                 scriptFilename,
                                 1.cint)
let outputIndex = 0.cint
#let node = vsscript_getOutput2(handle, outputIndex, nil)
let node = vsscript_getOutput(handle, outputIndex)
var vsmap = createMap()
vsmap.append("clip".string, cast[ptr VSNodeRef](node))
#echo $vsmap
let nframes = vsmap.Savey4m("borrame2.y4m")
echo "Frames: ", nframes
#echo repr node
let vsapi = vsscript_getVSApi()
vsapi.freeNode( cast[ptr VSNodeRef](node) )
vsscript_freeScript(handle)
discard vsscript_finalize()
