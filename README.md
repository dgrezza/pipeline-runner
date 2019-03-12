pipeline-runner

[![Docker Pulls](https://img.shields.io/docker/pulls/dgrlabs/pipeline-runner.svg?style=flat-square)](https://hub.docker.com/r/dgrlabs/pipeline-runner)

## pipeline-runner
This is `swiss army knife` docker image for pipeline runner that using GKE, helm, go, and istio

## Image Info
This Docker image contains:

- `gcloud`
- `kubectl`
- `envsubst`
- `helm`
- `jq`
- `istioctl`
- `go`
- `dep`
- `bash`
- `gcc`

## Usage
This image using [golang-alpine](https://hub.docker.com/_/golang) as base image

### Building

```bash
docker build -t dgrlabs/pipeline-runner .
```
