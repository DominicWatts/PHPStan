FROM php:7.2-cli-alpine

MAINTAINER Dominic <dominic@xigen.co.uk>

RUN php --version

ENV COMPOSER_HOME /composer
ENV COMPOSER_ALLOW_SUPERUSER 1
ENV PATH /composer/vendor/bin:$PATH
ENV PHP_CONF_DIR=/usr/local/etc/php/conf.d

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

RUN echo "memory_limit=-1" > $PHP_CONF_DIR/99_memory-limit.ini \
    && apk add --no-cache \ 
        git \
        php7-intl \
    && docker-php-ext-install \
        intl \
    && rm -rf /var/cache/apk/* /var/tmp/* /tmp/*

RUN composer global require phpstan/phpstan:dev-master

VOLUME ["/code"]
WORKDIR /code
