# s3-bucket-creator
s3-bucket-creator creates a bucket in a S3-compatible backend if it doesn't exist using [mc](https://github.com/minio/mc). This is designed to be used as a sidekick container.

## Environment Variables
| Name           | Default                  | Description                                                |
| -------------- |:------------------------:| ---------------------------------------------------------- |
| S3_ENDPOINT    | https://s3.amazonaws.com | The endpoint address to your S3-compatible backend         |
| S3_ACCESS_KEY  | -                        | The access key to authenticate to the endpoint             |
| S3_SECRET_KEY  | -                        | The secret key to authenticate to the endpoint             |
| S3_VERSION     | S3v4                     | S3 protocol version can be either S3v2 or S3v4             |
| BUCKET_NAME    | -                        | The name of the bucket to create                           |
| INITIAL_DELAY  | 0                        | Initial delay in seconds before connecting to the endpoint |
| INFINITE_SLEEP | false                    | Tell script to block infinitely until terminated           |

## Example

    docker run -e BUCKET_NAME=my-bucket \
               -e S3_ENDPOINT=https://s3.amazonaws.com \
               -e S3_ACCESS_KEY=ESGAWFEXAMPLE \
               -e S3_SECRET_KEY=efisj3ADawd+wawKEYEXAMPLE \
               wikiwi/s3-bucket-creator

## Docker Hub
Automated build is available at the [Docker Hub](https://hub.docker.com/r/wikiwi/s3-bucket-creator).

