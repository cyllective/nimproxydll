#[ 
  Nim DLL Sideloading (a.k.a. DLL proxying) example
  Author: Marcello Salvati (@byt3bl33d3r)

  Modifications to doMagic by cyllective (https://github.com/cyllective)
]#

import os
import strformat
import winim/lean

# If you prefer to not pass the .def file via CLI during compilation uncomment the line below, and replace with actual filename
#{.passl: " mydeffile.def".}

proc NimMain() {.cdecl, importc.}

proc doMagic(lpParameter: LPVOID) : DWORD {.stdcall.} =
  var username = getEnv("USERNAME")
  MessageBox(0, fmt"{username} shot first", "Nim", 0)
  return 0

proc DllMain(hinstDLL: HINSTANCE, fdwReason: DWORD, lpvReserved: LPVOID) : BOOL {.stdcall, exportc, dynlib.} =
  NimMain() # You must manually import and start Nim's garbage collector if you define you're own DllMain
  case fdwReason:
    of DLL_PROCESS_ATTACH:
      var threadHandle = CreateThread(NULL, 0, doMagic, NULL, 0, NULL)
      CloseHandle(threadHandle)
    of DLL_THREAD_ATTACH:
      discard
    of DLL_THREAD_DETACH:
      discard
    of DLL_PROCESS_DETACH:
      discard
    else:
      discard

  return true
