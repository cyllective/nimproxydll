# nimproxydll
A Docker container for [byt3bl33d3r/NimDllSideload](https://github.com/byt3bl33d3r/NimDllSideload).

## Usage
+ Obtain the DLL you are trying to proxy and put it into the `input` folder (one or more)
+ Adjust the payload in `app/dllproxy.nim`'s `doMagic()`
+ Run `make image && make proxydll`
+ Find your ProxyDLL named like the legit one and the legit renamed to a random string in the `output` folder