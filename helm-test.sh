#!/bin/bash

CHART=$1 # positional param: name of the chart
VERSION=$2 # positional param: version of the chart
HOME_DIRECTORY="/home/user/charts/${CHART}" # your local absolute working dir to find the folder of the chart
HELM_DIR="${HOME_DIRECTORY}/helm"
TEST_DIR="${HOME_DIRECTORY}/test"
REPOSITORY_URL="repourl.acr.io/helm" # Your helm repository url

# ASCII Colors to improve readability of logs
BLUE='\033[0;36m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Colors

echo "${BLUE}Executing script:${NC} Helm push and test for ${YELLOW}${CHART}${NC} library"

# If you are using ACR as helm repository, as in my case, you need to export this variable
export HELM_EXPERIMENTAL_OCI=1

cd $HELM_DIR;

echo "${BLUE}Updating helm dependencies${NC}"

helm dependency update;

echo "${BLUE}Saving chart: ${YELLOW}${CHART}${NC} locally with version ${YELLOW}${VERSION}${NC}"

helm chart save . ${REPOSITORY_URL}/${CHART}:${VERSION};

echo "${BLUE}Pushing chart to ACR"

helm chart push ${REPOSITORY_URL}/${CHART}:${VERSION};

cd $TEST_DIR;

echo "${BLUE}Forcing to redownload self test dependency${NC}"

rm -r charts/;
helm dependency update;

echo "${BLUE}Printing kubernetes manifests into expected-output.yaml${NC}"

helm template ./ > expected-output.yaml