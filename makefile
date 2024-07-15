VERSION:=v0.01
DOCKER_USER:=asadlive84
DOCKER_PASS:=m^0*O8qYB*@%
VERSION:=latest
DOCKER_REGISTREY:=docker.io

build:
	@ docker compose down --remove-orphans -v && docker compose up --build -d


push:
	@ echo "Docker Login"
	@ cd api-gateway && echo ${DOCKER_PASS} | docker login --username ${DOCKER_USER} --password-stdin ${DOCKER_REGISTREY}
	@ docker tag api-gateway:latest $(DOCKER_USER)/api-gateway:latest
	@ docker tag api-gateway:latest $(DOCKER_USER)/api-gateway:$(VERSION)
	@ docker push $(DOCKER_USER)/api-gateway:latest
	@ docker push $(DOCKER_USER)/api-gateway:$(VERSION)
