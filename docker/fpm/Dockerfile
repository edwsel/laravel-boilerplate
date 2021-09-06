FROM node:15-alpine as front-build

LABEL MAINTAINER="Edward S edward@gmail.com"

WORKDIR /app

COPY ./ ./

RUN yarn install && yarn run prod
RUN rm -rf ./node_modules

# -----

FROM php:8.0-fpm-alpine

WORKDIR /app

ENV COMPOSER_VERSION=2.1.6
ENV COMPOSER_ALLOW_SUPERUSER 1
ENV COMPOSER_HOME /tmp

ENV PHP_REDIS_VERSION=5.3.3

RUN set -xe \
    apk update && apk add --no-cache --virtual .persistent-deps --virtual .phpize-deps $PHPIZE_DEPS \
    # for imagemagick
    imagemagick-dev \
    imagemagick \
    libtool \
    # for ZIP
    libzip-dev \
    # Other
    && mkdir -p /usr/src/php/ext/imagick \
    && curl -fsSL https://github.com/Imagick/imagick/archive/06116aa24b76edaf6b1693198f79e6c295eda8a9.tar.gz | tar xvz -C "/usr/src/php/ext/imagick" --strip 1 \
    && docker-php-ext-install imagick \
    && pecl install redis-$PHP_REDIS_VERSION \
    && echo "extension=redis.so" > /usr/local/etc/php/conf.d/redis.ini \
    && docker-php-ext-enable redis \
    && docker-php-ext-configure opcache --enable-opcache \
    && docker-php-ext-configure mysqli --with-mysqli \
    && docker-php-ext-configure pcntl --enable-pcntl \
    && docker-php-ext-configure pdo_mysql --with-pdo-mysql \
    && docker-php-ext-install -j$(nproc) \
	mysqli \
	pdo_mysql \
	pcntl \
	zip \
	opcache \
	&& apk del --no-cache \
	freetype-dev \
	libpng-dev \
	libjpeg-turbo-dev \
	imagemagick-dev \
	libzip-dev \
	&& rm -rf /var/cache/apk/*


COPY --from=front-build /app ./

RUN set -xe \
	rm -rf ./docker \
	&& rm -rf ./deploy \
	&& rm -rf ./vendor \
	&& rm -rf ./node_modules 

COPY ./docker/fpm/config/php.ini /usr/local/etc/php/php.ini
COPY ./docker/fpm/config/php-fpm.conf /usr/local/etc/php-fpm.conf

RUN set -xe \
	mkdir -p "$COMPOSER_HOME" \
	# install composer
	&& php -r "copy('https://getcomposer.org/installer', '/tmp/composer-setup.php');" \
	&& php /tmp/composer-setup.php --no-ansi --install-dir=/usr/bin --filename=composer --version=$COMPOSER_VERSION \
	&& composer --ansi --version --no-interaction \
	&& composer --no-interaction global require 'hirak/prestissimo' \
	&& rm -rf /tmp/composer-setup.php /tmp/.htaccess \
	# show php info
	&& php -v && php -m \
	&& composer install --no-dev || true \
	&& composer clear-cache

COPY ./docker/fpm/entrypoint.sh /entrypoint.sh

RUN chmod 755 /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 9000

ENTRYPOINT ["/entrypoint.sh"]

CMD php-fpm -R --nodaemonize -d "display_startup_errors=On" -d "display_errors=On" -d "error_reporting=E_ALL"
