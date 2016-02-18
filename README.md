# Git in Docker

This container is specifically to clone and update a git repo.  It is based on the
minimalist [Alpine Linux](https://hub.docker.com/_/alpine), and installs:

- git
- openssh (to clone via SSH)
- openssl (to clone via HTTPS)

The intention is to be able to use this to create a data container, and other 
containers can subsequently mount `/app` via --volumes-from.

## Examples

- `docker run --name=app stevepacker/git clone git@github.com:you/it.git` 
    will clone the repo into `/app`
- `docker run --volumes-from=app stevepacker/git pull` 
    will change into `/app` and pull the latest code for whatever branch is 
    currently checked out
- `docker run --volumes-from=app stevepacker/git pull 1.1.0` 
    will change into `/app`, fetch the latest from origin, checkout tag `1.1.0`,
    and pull the latest code
     
## Non-privileged User: app

This repo clones the files under a non-privileged user "app" with UID=1000

## Volumes

- `/app` is where the repo is cloned to.
- `/home/app/.ssh/` may be an interesting directory for you if you'd like to inject
    an OpenSSH private key to help you clone a private repo over SSH.

## Environment Variables

- `GIT_SSH_COMMAND="ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no"` 
    is pre-configured to allow a clone over SSH to succeed without host key checking.  
    For the security-minded, override this ENV variable and inject the proper file 
    into `/home/app/.ssh/known_hosts`
- `GIT_BRANCH="master"` is pre-configured.  If you'd rather checkout a different tag 
    or branch, change this accordingly.