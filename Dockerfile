FROM php:7.2-cli-alpine

MAINTAINER Dominic <dominic@xigen.co.uk>

RUN php --version

ENV COMPOSER_HOME /composer
ENV COMPOSER_ALLOW_SUPERUSER 1
ENV PATH /composer/vendor/bin:$PATH
ENV PHP_CONF_DIR=/usr/local/etc/php/conf.d

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

RUN echo "memory_limit=-1" > $PHP_CONF_DIR/99_memory-limit.ini \
    set -xe \
    && apk add --no-cache \
        git \
        icu \
	    icu-dev \
        php7-intl \
    && docker-php-ext-install -j "$(getconf _NPROCESSORS_ONLN)" \
        intl \
    && rm -rf /var/cache/apk/* /var/tmp/* /tmp/*

RUN composer global require phpstan/phpstan:^0

VOLUME ["/code"]
WORKDIR /code
