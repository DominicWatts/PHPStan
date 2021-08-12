# PHPstan docker for Magento 2 code tests 

php cli apline images with the following components 

 - bcmath
 - ctype
 - curl
 - dom
 - gd
 - hash
 - iconv
 - intl
 - mbstring
 - openssl
 - pdo_mysql
 - soap
 - sodium
 - xsl
 - zip
 - libxml

[Docker_Hub](https://hub.docker.com/r/domw/phpstan)

## Compilation

    docker login

    docker build -t domw/phpstan:7.2 ./

    docker push domw/phpstan:7.2
    
    docker build -t domw/phpstan:gitlab-7.2 ./

    docker push domw/phpstan:gitlab-7.2

## Tags

Simple usage

 - phpstan:7.1
 - phpstan:7.2
 - phpstan:7.3
 - phpstan:7.4

For usage in CI codetests

 - phpstan:gitab-7.1
 - phpstan:gitab-7.2
 - phpstan:gitab-7.3
 - phpstan:gitab-7.4


## Test

    docker-compose run --rm stan

    docker-compose run --rm stan --version

## Usage
    
    docker pull domw/phpstan

    docker run --rm -v $PWD:/code domw/phpstan --version
    
    docker run --rm -v $PWD:/code domw/phpstan:gitlab-7.2 phpstan --version
    
    docker run --rm -v $PWD:/code domw/phpstan analyze ./path/to/code

    docker run --rm -v $PWD:/code domw/phpstan analyze --level 1 ./path/to/code

    docker run --rm -v $PWD:/code domw/phpstan analyze --level 1 -c phpstan.neon ./path/to/code

    docker run --rm -v $PWD:/code domw/phpstan analyze --level max ./path/to/code

## Gitlab

```
stages:
  - php-stan

php-stan:
  image: domw/phpstan:gitlab-7.3
  type: php-stan
  tags:
    - docker
  script:
    - composer global config http-basic.repo.magento.com d2eb3c98428210463077e4ca2b806e90 bf5d07ecb44854e94d7f78ef969d9470
    - composer install --prefer-dist -o --no-dev --ignore-platform-reqs -d /builds/vendor/module
    - phpstan --version
    - phpstan analyze --level 0 /builds/vendor/module/path/to/code/
```

## Github

```
name: PHPStan
on: [push]
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@master
    - uses: MilesChou/composer-action@master
      env:
        COMPOSER_AUTH: ${{secrets.COMPOSER_AUTH}}
      with:
        args: install --prefer-dist --no-dev --ignore-platform-reqs
    - name: PHPStan
      run: docker run --rm -v $PWD:/code domw/phpstan phpstan analyze ./
 ```
