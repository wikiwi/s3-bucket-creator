#!/bin/bash

# Copyright (C) 2016 wikiwi.io
#
# This software may be modified and distributed under the terms
# of the MIT license. See the LICENSE file for details.

version=0.1.1-dev

echo s3-bucket-creator "$version"

INITIAL_DELAY=${INITIAL_DELAY:-0}
S3_VERSION=${S3_VERSION:-S3v4}
INFINITE_SLEEP=${INFINITE_SLEEP:-false}

if [ -z "$S3_BUCKET_NAME" ]; then
  echo \$S3_BUCKET_NAME was not defined
  exit 1
fi

if [ -z "$S3_ENDPOINT" ]; then
  echo \$S3_ENDPOINT was not defined
  exit 1
fi

if [ -z "$S3_ACCESS_KEY" ]; then
  echo \$S3_ACCESS_KEY was not defined
  exit 1
fi

if [ -z "$S3_SECRET_KEY" ]; then
  echo \$SECRET_KEY was not defined
  exit 1
fi

sleep "$INITIAL_DELAY"

mc config host add s3host "$S3_ENDPOINT" "$S3_ACCESS_KEY" "$S3_SECRET_KEY" "$S3_VERSION"

if ! mc ls "s3host/$S3_BUCKET_NAME"; then
  echo "Attempting to create bucket \"$S3_BUCKET_NAME\"..."
  if ! mc mb "s3host/$S3_BUCKET_NAME"; then
    exit 1
  fi
else
  echo "Bucket \"$S3_BUCKET_NAME\" already exists"
fi

if [[ "$INFINITE_SLEEP" == "true" ]]; then
  tail -f /dev/null
fi

