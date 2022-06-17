#!/bin/sh
set -o errexit

docker login -u=${DOCKER_USERNAME} -p=${DOCKER_PASSWORD} quay.io

for image in 'clamav' 'clamav-http' 'clamav-mirror'
do
  docker build --no-cache -t "quay.io/ukhomeofficedigital/acp-$image:$DRONE_COMMIT_SHA" "$image"
  for tag in "$@"
  do
    docker tag "quay.io/ukhomeofficedigital/acp-$image:$DRONE_COMMIT_SHA" "quay.io/ukhomeofficedigital/acp-$image:$tag"
    docker push "quay.io/ukhomeofficedigital/acp-$image:$tag"
  done
done
