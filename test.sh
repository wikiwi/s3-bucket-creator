#!/bin/bash
set -eux

PORT=${PORT:-9000}
TAG=${TAG:-test}

cleanup() {
  minioCID=${minioCID:-''}
  if [ -n "$minioCID" ]; then
    echo Stopping Minio Server...
    docker stop $minioCID
  fi

  cid=${cid:-''}
  if [ -n "$cid" ]; then
    echo Stopping long runnign container...
    docker stop $cid
  fi
}
trap cleanup EXIT

# Build container.
docker build -t s3-bucket-creator:${TAG} .

# Setup minio as S3 Test Server.
docker pull minio/minio
minioCID=$(docker run -e MINIO_ACCESS_KEY=ACCESSKEY \
           -e MINIO_SECRET_KEY=SECRETKEY \
           -p 127.0.0.1:${PORT}:${PORT} -d \
           minio/minio /export)

# Create first bucket.
docker run -e S3_BUCKET_NAME=my-bucket \
           -e S3_ENDPOINT=http://127.0.0.1:${PORT} \
           -e S3_ACCESS_KEY=ACCESSKEY \
           -e S3_SECRET_KEY=SECRETKEY \
           -e INITIAL_DELAY=2 \
           --net host \
           s3-bucket-creator:${TAG}

# Create second bucket and sleep infinitely.
cid=$(docker run -e S3_BUCKET_NAME=my-second-bucket \
           -e S3_ENDPOINT=http://127.0.0.1:${PORT} \
           -e S3_ACCESS_KEY=ACCESSKEY \
           -e S3_SECRET_KEY=SECRETKEY \
           -e INFINITE_SLEEP=true \
           --net host -d \
           s3-bucket-creator:${TAG})

sleep 10

# Use mc tool in container to check correct execution.
docker exec ${cid} mc ls s3host/my-bucket
docker exec ${cid} mc ls s3host/my-second-bucket
docker exec ${cid} mc rm s3host/my-bucket
docker exec ${cid} mc rm s3host/my-second-bucket


