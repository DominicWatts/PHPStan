FROM php:7.3-cli

MAINTAINER Dominic <dominic@xigen.co.uk>

ENV COMPOSER_HOME /composer
ENV COMPOSER_ALLOW_SUPERUSER 1
ENV PATH /composer/vendor/bin:$PATH
ENV PHP_CONF_DIR=/usr/local/etc/php/conf.d

RUN apt-get update \
 && apt-get install -y \
    zlib1g-dev \
    libzip-dev \
    zip \
    git

RUN docker-php-ext-install \
  zip

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN composer global require phpstan/phpstan:dev-master \
  && mkdir -p /code

WORKDIR /code
VOLUME /code