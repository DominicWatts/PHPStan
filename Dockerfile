FROM php:7.2-cli

MAINTAINER Dominic <dominic@xigen.co.uk>

RUN apt-get update \
 && apt-get install -y \
    zlib1g-dev \
    libzip-dev \
    zip \
    git

RUN docker-php-ext-install \
  zip

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN composer global require --dev phpstan/phpstan:^0.11.6 \
  && composer global require --dev bitexpert/phpstan-magento:dev-master \
  && mkdir -p /code

ENV PATH="/root/.composer/vendor/bin:${PATH}"

WORKDIR /code
VOLUME /code