# Jenkins (official) with Docker

This is a re-packaging of the official Jenkins docker container with the single addition of the Docker binary, built to run on Mac OSX with Boo2Docker.

<img src="http://jenkins-ci.org/sites/default/files/jenkins_logo.png"/>

## Usage

```
docker run -p 8080:8080 -v /var/run/docker.sock:/var/run/docker.sock stevepacker/jenkins
```

Note that attaching /var/run/docker.sock as a volume parameter will permit Jenkins to run `docker` commands on the host machine.

Please see the original official [Jenkins Docker README](https://registry.hub.docker.com/_/jenkins/) for more details on using this container.
