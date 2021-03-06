#!/bin/bash

# Needed variables:
# CIRCLE_TOKEN
# GITHUB_TOKEN
# CIRCLE_SHA1
# CIRCLE_BUILD_NUM
# CIRCLE_PROJECT_USERNAME
# CIRCLE_PROJECT_REPONAME


BACKSTOP_ARTIFACT_PATH="backstop/html_report/index.html"
LIGHTHOUSE_ARTIFACT_PATH="lighthouse/output.html"

ARTIFACTS_INFO=`curl https://circleci.com/api/v1.1/project/github/$CIRCLE_PROJECT_USERNAME/$CIRCLE_PROJECT_REPONAME/$CIRCLE_BUILD_NUM/artifacts?circle-token=$CIRCLE_TOKEN`

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}"  )" >/dev/null && pwd  )"

BACKSTOP_ARTIFACT_URL=`$SCRIPT_DIR/parse_artifacts.py "$ARTIFACTS_INFO" "$BACKSTOP_ARTIFACT_PATH"`
LIGHTHOUSE_ARTIFACT_URL=`$SCRIPT_DIR/parse_artifacts.py "$ARTIFACTS_INFO" "$LIGHTHOUSE_ARTIFACT_PATH"`

COMMENT="Backstop\u0020Artifact\u0020URL:\u0020${BACKSTOP_ARTIFACT_URL}\nLighthouse\u0020Artifact\u0020URL:\u0020${LIGHTHOUSE_ARTIFACT_URL}"

curl -d '{ "body": "'$COMMENT'" }' -X POST https://api.github.com/repos/$CIRCLE_PROJECT_USERNAME/$CIRCLE_PROJECT_REPONAME/commits/$CIRCLE_SHA1/comments?access_token=$GITHUB_TOKEN
