# docker image with phpstan

[Docker_Hub](https://hub.docker.com/r/domw/phpstan)

## Compilation

    docker login

    docker build -t domw/phpstan:latest ./

    docker push domw/phpstan:latest

    docker build -t domw/phpstan:7.2-cli ./

    docker push domw/phpstan:7.2-cli 

## Test

    docker-compose run --rm stan

    docker-compose run --rm stan --version

## Usage
    
    docker pull domw/phpstan

    docker run --rm -v $PWD:/code domw/phpstan --version
    
    docker run --rm -v $PWD:/code domw/phpstan analyze ./path/to/code

    docker run --rm -v $PWD:/code domw/phpstan analyze --level 1 ./path/to/code

    docker run --rm -v $PWD:/code domw/phpstan analyze --level 1 -c phpstan.neon ./path/to/code

    docker run --rm -v $PWD:/code domw/phpstan analyze --level max ./path/to/code

## Gitlab

    stages:
    - php-stan

    php-stan:
    image: domw/phpstan:gitlab-7.3
    type: php-stan
    tags:
        - docker
    script:
        - phpstan --version
        - phpstan analyze --level 0 /builds/vendor/module/path/to/code