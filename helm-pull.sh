#!/bin/bash

CHART=${1:-devops-work-microservice}
VERSION="${2:-0.0.1-SNAPSHOT}"  # Positional parameter, If variable not set or null, use default.
VALUES="${3:-values-test.yaml}" # Positional parameter, If variable not set or null, use default.
REPOSITORY_URL="repourl.acr.io/helm" # Your helm repository url

# If you are using ACR as helm repository, as in my case, you need to export this variable
export HELM_EXPERIMENTAL_OCI=1

helm chart pull ${REPOSITORY_URL}/${CHART}:${VERSION} &&
helm chart export ${REPOSITORY_URL}/${CHART}:${VERSION}
cd ${CHART}
helm template ./ --values $VALUES