import pefile
import sys
import pathlib

dll_path = pathlib.Path(sys.argv[1])
dll = pefile.PE(dll_path)

highest_ordinal = 0

print("EXPORTS")
for export in dll.DIRECTORY_ENTRY_EXPORT.symbols:
    if export.name:
        print(f"\t{export.name.decode()}={dll_path.stem}.{export.name.decode()} @{export.ordinal}")
        if export.ordinal > highest_ordinal:
            highest_ordinal = export.ordinal
else:
    print(f"\tNimMain @{highest_ordinal + 2} NONAME PRIVATE")
