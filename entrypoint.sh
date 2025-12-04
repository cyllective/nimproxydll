#!/bin/bash

NIMFLAGS="-d=release -d=mingw -d=strip --opt=size --mm=orc --threads=on"

INPUTDIR="/input"
OUTPUTDIR="/output"

rm -rf $INPUTDIR/*.def
rm -rf $OUTPUTDIR/*.dll

DLLS=$(find $INPUTDIR -type f -name "*.dll")

for INFILE in $DLLS; do
	BASENAME=$(basename $INFILE .dll)
	DEFFILE="$(realpath "$INPUTDIR/$BASENAME.def")"
	RANDOM=$(python3 -c 'import string,random; print("".join(random.choice(string.ascii_letters) for i in range(8)))' )
	OUTFILE="$(realpath "$OUTPUTDIR/$RANDOM.dll")"
	OUTFILEPROXY="$(realpath "$OUTPUTDIR/$BASENAME.dll")"

	echo "def=$DEFFILE;ogdll=$OUTFILE;proxydll=$OUTFILEPROXY"

	cp $INFILE $OUTFILE
	python3 gen_def.py $OUTFILE > $DEFFILE
	nim c $NIMFLAGS --app=lib --nomain --cpu=amd64 --passl:$DEFFILE --out=$OUTFILEPROXY dllproxy.nim
done