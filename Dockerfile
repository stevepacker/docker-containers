FROM stevepacker/nodejs-supervisor

USER root

RUN apk --no-cache add python g++ make \
  && npm install --global \
	node-red \
	node-red-contrib-admin

USER node

CMD ["supervisor", "node-red"]
