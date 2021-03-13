FROM node:15-alpine

LABEL MAINTAINER="Edward S edward@gmail.com"

WORKDIR /app

RUN export PATH="$(yarn global bin):$PATH"

RUN yarn global add laravel-echo-server \
    && yarn cache clean

COPY ./docker/socket/entrypoint.sh /entrypoint.sh
COPY ./laravel-echo-server.json.example ./laravel-echo-server.json

RUN chmod 755 /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 80

ENTRYPOINT ["/entrypoint.sh"]

CMD laravel-echo-server start