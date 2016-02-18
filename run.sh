#!/bin/sh

cd /home/build/

HOME=$(pwd)

#1. Git clone the repo (use REPO_URL env variable for this) to a workspace directory.
rm -Rf project
echo "... git clone $REPO_URL project"
git clone "$REPO_URL" project

#2. Git checkout appropriate branch (use REPO_BRANCH to use a branch other than "master")
cd project
if [ "" != "$REPO_BRANCH" ]; then
    echo "... git checkout $REPO_BRANCH"
    git checkout "$REPO_BRANCH"
fi
git status

#3. Change to the workspace directory (use REPO_PATH as a relative path to the workspace directory to change this)
if [ "" != "$REPO_PATH" ]; then
    echo "... cd $REPO_PATH"
    cd "$REPO_PATH"
fi
echo "... cwd: " $(pwd)

#4. Docker build the repo (use DOCKER_TAG env variable)
echo "... docker build -t $DOCKER_TAG ."
docker build -t "$DOCKER_TAG" .

#5. Docker push
echo "... docker push $DOCKER_TAG"
docker push "$DOCKER_TAG"