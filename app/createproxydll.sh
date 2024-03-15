#!/bin/sh

inputDll="$1"

# Just the name without the .dll
dllBaseName="$(basename "${inputDll%????}")"
# Copy the original DLL with a randomized name
cp "$inputDll" "/src/output/$(tr -dc A-Za-z0-9 </dev/urandom | head -c 8 ; echo "").dll"

# Generate the def file for the proxied functions
python3 /app/gen_def.py "$inputDll" > "/tmp/$dllBaseName.def"
if [ $? = 1 ]; then
	echo "Error generating definitions"
	exit
fi

# Build the proxy DLL
nim c -d=release -d=mingw -d=strip \
	--opt=size --mm=orc --threads=on \
	--app=lib --nomain --cpu=amd64 \
	--passl="/tmp/$dllBaseName.def" \
	--out="$dllBaseName.dll" --outdir="/src/output" \
	dllproxy.nim