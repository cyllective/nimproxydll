# nimproxydll

![Build Status](https://img.shields.io/github/actions/workflow/status/cyllective/nimproxydll/ghcr.yaml)

A Docker container for [byt3bl33d3r/NimDllSideload](https://github.com/byt3bl33d3r/NimDllSideload)

## Usage

**Default payload**  

If you are happy with the default payload, which writes to `C:\proof.txt`, you can use the public image.

```sh
mkdir input # place you DLLs here
mkdir output

docker run --rm -v $(pwd)/input:/input -v $(pwd)/output:/output ghcr.io/cyllective/nimproxydll
```

**Custom payload**  

To have a custom payload trigger, adjust the code in `dllproxy.nim`'s `doMagic` function. Place your DLLs into the `input` directory and run:

```sh
docker build --build-arg userid=$(id -u) -t nimproxydll .
docker run --rm -v $(pwd)/input:/input -v $(pwd)/output:/output nimproxydll
```
