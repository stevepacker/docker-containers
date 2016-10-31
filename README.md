# HEYU X10 Controller via HTTP
 
### *Insecure*
For use by intranets only.

## @TODO documentation

Example *RUN* command:

    docker run -d --name=heyu \
        --restart=always \
        -p 8080:80 \
        -v some/dir:/etc/heyu \
        --device /dev/ttyUSB0 \
        stevepacker/heyu