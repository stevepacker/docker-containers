# NodeJS 

This container runs NodeJS on [Alpine Linux](https://hub.docker.com/_/alpine).

It is also bundled with 
[Node_Supervisor](https://github.com/petruisfan/node-supervisor) and 
[Nodemon](nodemon.io).  
Both are installed globally if you'd like to use them.

[S6](https://github.com/just-containers/s6-overlay) is also included as the
init (PID=1) handler and service container.  This is useful as another process 
supervisor and other tools.

A user `node` is created with UID=1000 if you'd like to 
[drop privileges](https://github.com/just-containers/s6-overlay#dropping-privileges)
for any of your services.

## NPM Install

During initialization, if file `/app/package.json` exists, and if 
`/app/node_modules` is either empty or not there, this container will automatically 
run `npm install` within `/app` to install all dependencies.

## Volumes

- `/app` is where your application code should reside.

## Environment Variables

- `APKS` On initialization, if you want specific Alpine APKs installed, set this 
    environment variable.  Multiple packages should be space-delimited.
- `USER` If you want your `npm install` to be ran as a certain user (or UID), set 
    this to your intended user.  Otherwise it'll be run as root.