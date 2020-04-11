##
##  Copyright (c) 2013-2018 Fredrik Mellbin
##
##  This file is part of VapourSynth.
##
##  VapourSynth is free software; you can redistribute it and/or
##  modify it under the terms of the GNU Lesser General Public
##  License as published by the Free Software Foundation; either
##  version 2.1 of the License, or (at your option) any later version.
##
##  VapourSynth is distributed in the hope that it will be useful,
##  but WITHOUT ANY WARRANTY; without even the implied warranty of
##  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
##  Lesser General Public License for more details.
##
##  You should have received a copy of the GNU Lesser General Public
##  License along with VapourSynth; if not, write to the Free Software
##  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
##
{. passL:"-rdynamic -Wl,-wrap,dlopen".}

{.emit: """
#include <dlfcn.h>
#include <stdio.h>

void *__real_dlopen(const char *filename, int flags);

void *__wrap_dlopen(const char *filename, int flags)
{
  //printf("shadow dlopen with RTLD_GLOBAL: %s\n", filename);
  //fflush(stdout);
  return __real_dlopen(filename, RTLD_NOW | RTLD_GLOBAL);
}
""".}

#from VapourSynth_wrapper import VSNodeRef, VSMap, VSCore, VSAPI
#import VapourSynth_wrapper

{.deadCodeElim: on.}
when defined(windows):
  const
    libname_vscript* = "VSScript.dll"
elif defined(macosx):
  const
    libname_vscript* = "libvapoursynth-script.dylib"
else:
  const
    libname_vscript* = "libvapoursynth-script.so"

const
  VSSCRIPT_API_MAJOR* = 3
  VSSCRIPT_API_MINOR* = 2
  VSSCRIPT_API_VERSION* = ((VSSCRIPT_API_MAJOR shl 16) or (VSSCRIPT_API_MINOR))

##  As of api 3.2 all functions are threadsafe

type
  VSEvalFlags* {.size: sizeof(cint).} = enum
    efSetWorkingDir = 1
  VSScript* {.bycopy.} = object

##  Get the api version

proc vsscript_getApiVersion*(): cint {.cdecl, importc: "vsscript_getApiVersion",
                                    dynlib: libname_vscript.}
##  api 3.1
##  Initialize the available scripting runtimes, returns zero on failure

proc vsscript_init*(): cint {.cdecl, importc: "vsscript_init", dynlib: libname_vscript.}
##  Free all scripting runtimes

proc vsscript_finalize*(): cint {.cdecl, importc: "vsscript_finalize", dynlib: libname_vscript.}
##
##  Pass a pointer to a null handle to create a new one
##  The values returned by the query functions are only valid during the lifetime of the VSScript
##  scriptFilename is if the error message should reference a certain file, NULL allowed in vsscript_evaluateScript()
##  core is to pass in an already created instance so that mixed environments can be used,
##  NULL creates a new core that can be fetched with vsscript_getCore() later OR implicitly uses the one associated with an already existing handle when passed
##  If efSetWorkingDir is passed to flags the current working directory will be changed to the path of the script
##  note that if scriptFilename is NULL in vsscript_evaluateScript() then __file__ won't be set and the working directory won't be changed
##  Set efSetWorkingDir to get the default and recommended behavior
##

proc vsscript_evaluateScript*(handle: ptr ptr VSScript; script: cstring;
                             scriptFilename: cstring; flags: cint): cint {.cdecl,
    importc: "vsscript_evaluateScript", dynlib: libname_vscript.}
##  Convenience version of the above function that loads the script from a file

proc vsscript_evaluateFile*(handle: ptr ptr VSScript; scriptFilename: cstring;
                           flags: cint): cint {.cdecl,
    importc: "vsscript_evaluateFile", dynlib: libname_vscript.}
##  Create an empty environment for use in later invocations, mostly useful to set script variables before execution

proc vsscript_createScript*(handle: ptr ptr VSScript): cint {.cdecl,
    importc: "vsscript_createScript", dynlib: libname_vscript.}
proc vsscript_freeScript*(handle: ptr VSScript) {.cdecl,
    importc: "vsscript_freeScript", dynlib: libname_vscript.}
proc vsscript_getError*(handle: ptr VSScript): cstring {.cdecl,
    importc: "vsscript_getError", dynlib: libname_vscript.}
##  The node returned must be freed using freeNode() before calling vsscript_freeScript()

proc vsscript_getOutput*(handle: ptr VSScript; index: cint): ptr VSNodeRef {.cdecl,
    importc: "vsscript_getOutput", dynlib: libname_vscript.}
##  Both nodes returned must be freed using freeNode() before calling vsscript_freeScript(), the alpha node pointer will only be set if an alpha clip has been set in the script

proc vsscript_getOutput2*(handle: ptr VSScript; index: cint; alpha: ptr ptr VSNodeRef): ptr VSNodeRef {.
    cdecl, importc: "vsscript_getOutput2", dynlib: libname_vscript.}
##  api 3.1
##  Unset an output index

proc vsscript_clearOutput*(handle: ptr VSScript; index: cint): cint {.cdecl,
    importc: "vsscript_clearOutput", dynlib: libname_vscript.}
##  The core is valid as long as the environment exists

proc vsscript_getCore*(handle: ptr VSScript): ptr VSCore {.cdecl,
    importc: "vsscript_getCore", dynlib: libname_vscript.}
##  Convenience function for retrieving a vsapi pointer

proc vsscript_getVSApi*(): ptr VSAPI {.cdecl, importc: "vsscript_getVSApi",
                                   dynlib: libname_vscript.}
##  deprecated as of api 3.2 since it's impossible to tell the api version supported

proc vsscript_getVSApi2*(version: cint): ptr VSAPI {.cdecl,
    importc: "vsscript_getVSApi2", dynlib: libname_vscript.}
##  api 3.2, generally you should pass VAPOURSYNTH_API_VERSION
##  Variables names that are not set or not of a convertible type will return an error

proc vsscript_getVariable*(handle: ptr VSScript; name: cstring; dst: ptr VSMap): cint {.
    cdecl, importc: "vsscript_getVariable", dynlib: libname_vscript.}
proc vsscript_setVariable*(handle: ptr VSScript; vars: ptr VSMap): cint {.cdecl,
    importc: "vsscript_setVariable", dynlib: libname_vscript.}
proc vsscript_clearVariable*(handle: ptr VSScript; name: cstring): cint {.cdecl,
    importc: "vsscript_clearVariable", dynlib: libname_vscript.}
##  Tries to clear everything set in an environment, normally it is better to simply free an environment completely and create a new one

proc vsscript_clearEnvironment*(handle: ptr VSScript) {.cdecl,
    importc: "vsscript_clearEnvironment", dynlib: libname_vscript.}