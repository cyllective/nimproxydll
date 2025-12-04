.PHONY: docker-image
docker-image:
	docker build . --tag ghcr.io/cyllective/nimproxydll:${shell git rev-parse --short HEAD}
	docker build . --tag ghcr.io/cyllective/nimproxydll:latest

.PHONY: docker-push
docker-push:
	docker push ghcr.io/cyllective/nimproxydll:${shell git rev-parse --short HEAD}
	docker push ghcr.io/cyllective/nimproxydll:latest