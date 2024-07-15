VERSION:=v0.01
DOCKER_USER:=asadlive84
DOCKER_PASS:=m^0*O8qYB*@%
DOCKER_REGISTREY:=docker.io
DOCKER_IMAGE_NAME:=api-gateway
PROJECT_DIR:=api-gateway

build:
	@ docker compose down --remove-orphans -v && docker compose up --build -d

 
docker-login:
	@ echo "Docker Login"
	@ echo ${DOCKER_PASS} | docker login --username ${DOCKER_USER} --password-stdin ${DOCKER_REGISTREY}

push:
	@ docker build -t ${DOCKER_IMAGE_NAME}:$(VERSION) -f  ${PROJECT_DIR}/Dockerfile .
	@ docker tag ${DOCKER_IMAGE_NAME}:$(VERSION) $(DOCKER_USER)/${DOCKER_IMAGE_NAME}:$(VERSION)
	@ docker push $(DOCKER_USER)/${DOCKER_IMAGE_NAME}:$(VERSION)
	@ echo "Image pushed $(DOCKER_USER)/${DOCKER_IMAGE_NAME}:$(VERSION)"
