VERSION:=v0.01
DOCKER_USER:=asadlive84
DOCKER_PASS:=m^0*O8qYB*@%
VERSION:=latest
DOCKER_REGISTREY:=docker.io
DOCKER_IMAGE_NAME:=api-gateway

build:
	@ docker compose down --remove-orphans -v && docker compose up --build -d


push:
	@ echo "Docker Login start"
	@ cd api-gateway && echo ${DOCKER_PASS} | docker login --username ${DOCKER_USER} --password-stdin ${DOCKER_REGISTREY}
	@ docker tag ${DOCKER_IMAGE_NAME}:$(VERSION) $(DOCKER_USER)/${DOCKER_IMAGE_NAME}:$(VERSION)
	@ docker push $(DOCKER_USER)/${DOCKER_IMAGE_NAME}:$(VERSION)
	@ echo "Image pushed $(DOCKER_USER)/${DOCKER_IMAGE_NAME}:$(VERSION)"
