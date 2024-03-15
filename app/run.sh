#!/bin/sh

if ! [ -d "/src/input" ]; then
	echo "Input directory not found"
	exit
fi

if ! [ -d "/src/output" ]; then
	mkdir -p "/src/output"
else
	rm -rf /src/output/*.dll
fi

# For each input DLL, generate a proxy DLL
find /src/input -type f -name "*.dll" -exec /bin/sh /app/createproxydll.sh {} \;