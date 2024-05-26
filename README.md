# nimproxydll
A Docker container for [byt3bl33d3r/NimDllSideload](https://github.com/byt3bl33d3r/NimDllSideload).

## Usage
+ Obtain the DLL(s) you are trying to proxy and put them into the `input` folder
+ Adjust the payload in `dllproxy.nim`'s `doMagic()`
+ `docker build --build-arg userid=$(id -u) -t nimproxydll .`
+ `docker run --rm -v $(pwd):/app nimproxydll`
+ Find your proxied DLL(s) with legit names in the `output` folder alongside the original DLL(s) with random names