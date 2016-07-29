# s3-bucket-creator
s3-bucket-creator creates a bucket in a S3-compatible backend if it doesn't exist using [mc](https://github.com/minio/mc). This is designed to be used as a sidekick container.

[![Build Status Widget]][Build Status] [![Code Climate Widget]][Code Climate] [![MicroBadger Version Widget]][MicroBadger URL] [![MicroBadger Image Widget]][MicroBadger URL]

[Build Status]: https://travis-ci.org/wikiwi/s3-bucket-creator
[Build Status Widget]: https://travis-ci.org/wikiwi/s3-bucket-creator.svg?branch=master
[Code Climate]: https://codeclimate.com/github/wikiwi/s3-bucket-creator
[Code Climate Widget]: https://codeclimate.com/github/wikiwi/s3-bucket-creator/badges/gpa.svg
[MicroBadger URL]: http://microbadger.com/#/images/wikiwi/s3-bucket-creator
[MicroBadger Version Widget]: https://images.microbadger.com/badges/version/wikiwi/s3-bucket-creator.svg
[MicroBadger Image Widget]: https://images.microbadger.com/badges/image/wikiwi/s3-bucket-creator.svg


## Environment Variables
| Name           | Default                  | Description                                                |
| -------------- |:------------------------:| ---------------------------------------------------------- |
| S3_ENDPOINT    | https://s3.amazonaws.com | The endpoint address to your S3-compatible backend         |
| S3_ACCESS_KEY  | -                        | The access key to authenticate to the endpoint             |
| S3_SECRET_KEY  | -                        | The secret key to authenticate to the endpoint             |
| S3_VERSION     | S3v4                     | S3 protocol version can be either S3v2 or S3v4             |
| S3_BUCKET_NAME | -                        | The name of the bucket to create                           |
| INITIAL_DELAY  | 0                        | Initial delay in seconds before connecting to the endpoint |
| INFINITE_SLEEP | false                    | Tell script to block infinitely until terminated           |

## Example

    docker run -e S3_BUCKET_NAME=my-bucket \
               -e S3_ENDPOINT=https://s3.amazonaws.com \
               -e S3_ACCESS_KEY=ESGAWFEXAMPLE \
               -e S3_SECRET_KEY=efisj3ADawd+wawKEYEXAMPLE \
               wikiwi/s3-bucket-creator

## Docker Hub
Automated build is available at the [Docker Hub](https://hub.docker.com/r/wikiwi/s3-bucket-creator).

