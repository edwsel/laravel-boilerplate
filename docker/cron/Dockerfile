FROM php:8.0-cli-alpine

LABEL MAINTAINER="Edward S edward@gmail.com"

WORKDIR /app

ENV COMPOSER_VERSION=2.0.11
ENV COMPOSER_ALLOW_SUPERUSER 1
ENV COMPOSER_HOME /tmp

ENV PHP_REDIS_VERSION=5.3.3

RUN set -xe \
    apk update && apk add --no-cache --virtual .persistent-deps --virtual .phpize-deps $PHPIZE_DEPS \
	openssh \
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
    && apk del --no-cache \
	freetype-dev \
	libpng-dev \
	libjpeg-turbo-dev \
	imagemagick-dev \
	libzip-dev \
	&& rm -rf /var/cache/apk/*

COPY ./docker/core/config/php.ini /usr/local/etc/php/php.ini
COPY ./docker/cron/command.sh /command.sh
COPY ./ ./

RUN chmod 755 /command.sh
RUN chmod +X /command.sh

RUN set -xe \
	rm -rf ./docker \
	&& rm -rf ./deploy \
	&& rm -rf ./vendor \
	&& rm -rf ./node_modules 

RUN set -xe \
	mkdir -p "$COMPOSER_HOME" \
	&& php -r "copy('https://getcomposer.org/installer', '/tmp/composer-setup.php');" \
	&& php /tmp/composer-setup.php --no-ansi --install-dir=/usr/bin --filename=composer --version=$COMPOSER_VERSION \
	&& composer --ansi --version --no-interaction \
	&& composer --no-interaction global require 'hirak/prestissimo' \
	&& rm -rf /tmp/composer-setup.php /tmp/.htaccess \
	# show php info
	&& php -v && php -m \
	&& composer install --no-dev || true \
	&& composer clear-cache

RUN rm -rf ~/cache

# Setting up crontab
COPY ./docker/cron/crontab /tmp/crontab
RUN cat /tmp/crontab > /etc/crontabs/root

CMD ["crond", "-f", "-l", "0"]