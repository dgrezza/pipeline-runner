pipeline-runner

[![Docker Pulls](https://img.shields.io/docker/pulls/dgrlabs/pipeline-runner.svg?style=flat-square)](https://hub.docker.com/r/dgrlabs/pipeline-runner)

## pipeline-runner
This is `swiss army knife` docker image for pipeline runner that using GKE, helm, go, and istio

## Image Info
Inside pipeline-runner docker image contains:

- `gcloud`
- `kubectl`
- `helm`
- `istioctl`
- `jq`
- `envsubst`
- `go`
- `dep`
- `bash`
- `gcc`

## Usage
This image using [golang-alpine](https://hub.docker.com/_/golang) as base image.

- v1.0 = `alpine 3.8` , `helm 2.9.1`, `istioctl 1.0.5`, `golang 1.11`

### Building

```bash
docker build -t dgrlabs/pipeline-runner .
```
