#!/bin/bash

TOKEN=$1
OWNER=$2
REPO=$3

cd ~
mkdir -p actions-runner && cd actions-runner

VER=$(curl -s https://api.github.com/repos/actions/runner/releases/latest | jq -r .tag_name)
LATEST_VERSION="${VER:1}"

curl -o "actions-runner-linux-x64-${LATEST_VERSION}.tar.gz" -L https://github.com/actions/runner/releases/download/v${LATEST_VERSION}/actions-runner-linux-x64-${LATEST_VERSION}.tar.gz

tar xzf ./actions-runner-linux-x64-${LATEST_VERSION}.tar.gz

TOKEN=$(curl -L -X POST -H "Accept: application/vnd.github+json" -H "Authorization: Bearer $TOKEN" -H "X-GitHub-Api-Version: 2022-11-28" https://api.github.com/repos/$OWNER/$REPO/actions/runners/registration-token | jq .token)
RUNNER_TOKEN="${TOKEN//\"/}"

./config.sh --url https://github.com/$OWNER/$REPO --token $RUNNER_TOKEN
sudo ./svc.sh install
