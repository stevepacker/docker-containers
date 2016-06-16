# NodeJS 

This container runs NodeJS on [Alpine Linux](https://hub.docker.com/_/alpine).

It is also bundled with 
[Node_Supervisor](https://github.com/petruisfan/node-supervisor) and 
[Nodemon](nodemon.io).  
Both are installed globally if you'd like to use them.

A user `node` is created with UID=1000 to run as an unprivileged user.

## NPM Install

During initialization, if file `/app/package.json` exists, and if 
`/app/node_modules` is either empty or not there, this container will automatically 
run `npm install` within `/app` to install all dependencies.

Additionally, if /app/package.json exists, the "start" script will be ran (which
defaults to running "node server.js").

## Volumes

- `/app` is where your application code should reside.

## Environment Variables

SUPERVISOR=
SUPERVISORFLAGS=

Provides a means to wrap your application in a supervisor.  Example:

- `SUPERVISOR=nodemon`
- `SUPERVISOR=nodemon SUPERVISORFLAGS="--watch /app/lib --delay 5"`
- `SUPERVISOR=supervisor SUPERVISORFLAGS=--non-interactive --timestamp --no-restart-on success --exec"`
