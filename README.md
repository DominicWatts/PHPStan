# docker image with phpstan

[Docker_Hub](https://hub.docker.com/r/domw/phpstan)

## Compilation

    docker login

    docker build -t domw/phpstan:latest ./

    docker push domw/phpstan:latest

    docker build -t domw/phpstan:7.2-cli ./

    docker push domw/phpstan:7.2-cli 

## Test

    docker-compose run --rm stan phpstan

    docker-compose run --rm stan phpstan --version

## Usage
    
    docker pull domw/phpstan

    docker run --rm -v $PWD:/code domw/phpstan phpstan --version
    
    docker run --rm -v $PWD:/code domw/phpstan phpstan analyze ./path/to/code

    docker run --rm -v $PWD:/code domw/phpstan phpstan analyze --level 1 ./path/to/code

    docker run --rm -v $PWD:/code domw/phpstan phpstan analyze --level max ./path/to/code