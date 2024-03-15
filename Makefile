IMGNAME="nimproxydll"

make: image proxydll

image:
	docker build --build-arg userid=${shell id -u} -t ${IMGNAME} .

proxydll:
	docker run --rm -v ${PWD}:/src ${IMGNAME}

cleanup:
	docker image rm ${IMGNAME}
