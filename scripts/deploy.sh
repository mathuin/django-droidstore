echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" $DOCKER_REGISTRY
docker build -t $DOCKER_REGISTRY/$IMAGE ./django
docker push $DOCKER_REGISTRY/$IMAGE
