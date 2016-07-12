#!/bin/bash
set -eux

IMAGE=${IMAGE:-wikiwi/s3-bucket-creator:test}
NETWORK=${NETWORK:-wikiwi_isolated_nw}

cleanup() {
  minioCID=${minioCID:-''}
  if [ -n "${minioCID}" ]; then
    echo Stopping Minio Server...
    docker stop ${minioCID}
    docker rm ${minioCID}
  fi

  cid=${cid:-''}
  if [ -n "${cid}" ]; then
    echo Stopping long running container...
    docker stop ${cid}
    docker rm ${cid}
  fi

  docker network rm ${NETWORK} || true
}
trap cleanup EXIT

# Build container.
docker build -t ${IMAGE} .

# Create network.
docker network create ${NETWORK}

# Setup minio as S3 Test Server.
docker pull minio/minio
minioCID=$(docker run -e MINIO_ACCESS_KEY=ACCESSKEY \
           -e MINIO_SECRET_KEY=SECRETKEY \
           --net ${NETWORK} -d \
           --name minio \
           minio/minio /export)

# Create first bucket.
docker run -e S3_BUCKET_NAME=my-bucket \
           -e S3_ENDPOINT=http://minio:9000 \
           -e S3_ACCESS_KEY=ACCESSKEY \
           -e S3_SECRET_KEY=SECRETKEY \
           -e INITIAL_DELAY=2 \
           --net ${NETWORK} \
           --rm \
           ${IMAGE}

# Create second bucket and sleep infinitely.
cid=$(docker run -e S3_BUCKET_NAME=my-second-bucket \
           -e S3_ENDPOINT=http://minio:9000 \
           -e S3_ACCESS_KEY=ACCESSKEY \
           -e S3_SECRET_KEY=SECRETKEY \
           -e INFINITE_SLEEP=true \
           --net ${NETWORK} -d \
           ${IMAGE})

sleep 10

# Use mc tool in container to check correct execution.
docker exec ${cid} mc ls s3host/my-bucket
docker exec ${cid} mc ls s3host/my-second-bucket
docker exec ${cid} mc rm s3host/my-bucket
docker exec ${cid} mc rm s3host/my-second-bucket

