#vpath %.dll .

NIMFLAGS = -d=release -d=mingw -d=strip --opt=size --mm=orc --threads=on
#NIMFLAGS = -d=debug -d=mingw --embedsrc=on --hints=on

DLLS = $(notdir $(wildcard input/*.dll))
RANDOM = $(shell python3 -c 'import string,random; print("".join(random.choice(string.ascii_letters) for i in range(8)))' )
export RANDOM

.PHONY: clean
.PHONY: build

default: build

clean:
	rm -f output/*.dll
	rm -rf input/*.def

build: $(DLLS)

rebuild: clean build

%.dll: dllproxy.nim
	cp input/$*.dll output/$$RANDOM.dll
	python3 gen_def.py output/$$RANDOM.dll > input/$*.def
	nim c $(NIMFLAGS) --app=lib --nomain --cpu=amd64 --passl:input/$*.def --out=output/$*.dll dllproxy.nim