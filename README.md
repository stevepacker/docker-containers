# Docker Container Builder

This is a container exclusively for building a Docker container.  It will:

1. Git clone the repo (use REPO_URL env variable for this) to a workspace directory.
2. Git checkout appropriate branch (use REPO_BRANCH to use a branch other than "master")
3. Change to the workspace directory (use REPO_PATH as a relative path to the workspace directory to change this)
4. Docker build the repo (use DOCKER_TAG env variable)
5. Docker push

## Usage:

    docker run --rm \
        -v /var/run/docker.sock:/var/run/docker.sock \
        -v $HOME/.dockercfg:/home/build/.dockercfg \
        -e REPO_URL=https://github.com/stevepacker/docker-containers.git \
        -e REPO_BRANCH=master \
        -e REPO_PATH=builder \
        -e DOCKER_TAG=stevepacker/docker-builder:master \
        stevepacker/builder

* Mounting the host's docker.sock is not necessary, but it's ideal for only running a single docker service.
* Mounting the host's .dockercfg provides the authentication to push to a remote Docker registry.
* When cloning a private git repo, you can use a URL with a username/password embedded. `https://`someUser`:`somePass`@github.com/...`
* When REPO_BRANCH is not defined, `master` will be used.
* The DOCKER_NAME is used to tag and push the image, so if you use a private registry, include the FQDN.
