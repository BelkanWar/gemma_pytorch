DOCKER_URI=gemma:${USER}
docker build -f docker/Dockerfile -t ${DOCKER_URI} .