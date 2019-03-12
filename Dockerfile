FROM golang:1.11-alpine3.8

# =======================
# Initialize variable
# =======================
ENV HELM_VERSION v2.9.1
ENV ISTIO_VERSION 1.0.5

# =======================
# Install basic utilities
# =======================
RUN echo 'http://dl-cdn.alpinelinux.org/alpine/edge/community' >> /etc/apk/repositories
RUN apk --update add gcc libc-dev openssh-client python dep ca-certificates git wget curl tar jq bash docker

# =======================
# Install gcloud sdk
# =======================
ENV HOME /
ENV PATH /go/google-cloud-sdk/bin:$PATH
RUN wget https://dl.google.com/dl/cloudsdk/channels/rapid/google-cloud-sdk.zip && unzip google-cloud-sdk.zip && rm google-cloud-sdk.zip
RUN google-cloud-sdk/install.sh --usage-reporting=true --path-update=true --bash-completion=true --rc-path=/.bashrc --additional-components app kubectl alpha beta
# Disable updater check for the whole installation.
# Users won't be bugged with notifications to update to the latest version of gcloud.
RUN google-cloud-sdk/bin/gcloud config set --installation component_manager/disable_update_check true

# =======================
# Install Helm
# =======================
ENV HELM_FILENAME helm-${HELM_VERSION}-linux-amd64.tar.gz
ENV HELM_URL https://storage.googleapis.com/kubernetes-helm/${HELM_FILENAME}
RUN curl -o /tmp/${HELM_FILENAME} ${HELM_URL} \
  && tar -zxvf /tmp/${HELM_FILENAME} -C /tmp \
  && mv /tmp/linux-amd64/helm /bin/helm

# Install envsubst [better than using 'sed' for yaml substitutions]
ENV BUILD_DEPS="gettext"  \
    RUNTIME_DEPS="libintl"

RUN set -x && \
    apk add --update $RUNTIME_DEPS && \
    apk add --virtual build_deps $BUILD_DEPS &&  \
    cp /usr/bin/envsubst /usr/local/bin/envsubst && \
    apk del build_deps

# =======================
# Install Istioctl
# =======================
ENV ISTIO_FILENAME istio-${ISTIO_VERSION}-linux.tar.gz
ENV ISTIO_URL https://github.com/istio/istio/releases/download/${ISTIO_VERSION}/${ISTIO_FILENAME}
RUN curl -L -o /tmp/${ISTIO_FILENAME} ${ISTIO_URL} \
  && tar -xf /tmp/${ISTIO_FILENAME} -C /tmp \
  && mv /tmp/istio-${ISTIO_VERSION}/bin/istioctl /bin/istioctl

RUN rm -rf /tmp/* && mkdir /root/.ssh/

WORKDIR /

CMD ["bash"]
