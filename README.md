# Samba

This creates a Docker container running [Samba](https://www.samba.org) on [Alpine Linux](https://github.com/gliderlabs/docker-alpine).

### Example Usage:

    docker run --rm -it \
        -p 137:137 \
        -p 138:138 \
        -p 139:139 \
        -p 445:445 \
        -v ~/docker-containers/samba/data:/data \
        -e WORKGROUP=WORKGROUP \
        -e SAMBA_NAME=dockerSamba \
        -e SHARE_NAME=public \
        stevepacker/samba-alpine

### Example Usage with multiple shares:

    docker run --rm -it \
        -p 137:137 \
        -p 138:138 \
        -p 139:139 \
        -p 445:445 \
        -e DIRECTORIES=Videos,Photos,Documents \
        -v ~/Videos:/Videos \
        -v ~/Photos:/Photos \
        -v ~/Documents:/Documents \
        -e WORKGROUP=WORKGROUP \
        -e SAMBA_NAME=dockerSamba \
        stevepacker/samba-alpine

