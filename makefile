VERSION:=v0.01
DOCKER_USER:=asadlive84
DOCKER_PASS:=m^0*O8qYB*@%
VERSION:=latest

build:
	@ docker compose down --remove-orphans -v && docker compose up --build -d


push:
	@ cd api-gateway && docker login -u $(DOCKER_USER) -p $(DOCKER_PASS)
	@ docker tag api-gateway:latest $(DOCKER_USER)/api-gateway:latest
	@ docker tag api-gateway:latest $(DOCKER_USER)/api-gateway:$(VERSION)
	@ docker push $(DOCKER_USER)/api-gateway:latest
	@ docker push $(DOCKER_USER)/api-gateway:$(VERSION)
