FROM node:13 as front-build

LABEL MAINTAINER="Edward S edward@gmail.com"

WORKDIR /app

COPY ./ ./

RUN yarn install && yarn run prod
RUN rm -rf ./node_modules

# -----

FROM nginx:stable-alpine as production-stage

WORKDIR /app

COPY ./docker/nginx/entrypoint.sh /entrypoint.sh
COPY ./docker/nginx/config/nginx.conf /etc/nginx/nginx.conf
COPY ./docker/nginx/config/fastcgi_params /etc/nginx/fastcgi_params

RUN chmod 755 /entrypoint.sh
RUN chmod +x /entrypoint.sh

COPY --from=front-build /app ./

RUN set -xe \
	rm -rf ./docker \
	&& rm -rf ./deploy \
	&& rm -rf ./vendor \
	&& rm -rf ./node_modules 

EXPOSE 80

ENTRYPOINT ["/entrypoint.sh"]

CMD nginx -g 'daemon off;'