# VapourSynth.nim



## Dev notes

!!! note

   Also as long as you exactly match the struct layout to that of C, you don't need importc and header pragmas for the type, and thus don't depend on the headers at all.

!!! note
   
   Proc types are {.closure.} by default i.e. fat pointer. You want {.cdecl.} instead.