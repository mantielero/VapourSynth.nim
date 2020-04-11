#import ../src/vapoursynth
import ../src/VSScript_wrapper

let ini = vsscript_init()
doAssert(ini > 0, "Failed to initialize VapourSynth environment")
echo "INI: (0 in case of failure) ", ini
#echo vsscript_getError(se)
var handle:ptr ptr VSScript

# Initialize script environment
var n = vsscript_createScript(handle)




let scriptFilename:cstring = "script.vpy"
let dos = vsscript_evaluateFile( handle,
                                 scriptFilename,
                                 1.cint)
let outputIndex = 0.cint
let node = vsscript_getOutput2(handle[], outputIndex, nil)

echo repr node
vsscript_freeScript(handle[])
discard vsscript_finalize()

#[


    if (vsscript_evaluateFile(&se, nstringToUtf8(scriptFilename).c_str(), preserveCwd ? 0 : efSetWorkingDir)) {
        fprintf(stderr, "Script evaluation failed:\n%s\n", vsscript_getError(se));
        vsscript_freeScript(se);
        vsscript_finalize();
        return 1;
    }

    node = vsscript_getOutput2(se, outputIndex, &alphaNode);
    if (!node) {
       fprintf(stderr, "Failed to retrieve output node. Invalid index specified?\n");
       vsscript_freeScript(se);
       vsscript_finalize();
       return 1;
    }

]#