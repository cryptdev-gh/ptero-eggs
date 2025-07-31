FROM php:8.1-fpm

RUN apt-get update && apt-get install -y nginx unzip zip libzip-dev libpq-dev libsqlite3-dev \
    && docker-php-ext-install pdo pdo_mysql pdo_pgsql pdo_sqlite zip

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

RUN useradd -m container

USER container
ENV USER=container
ENV HOME=/home/container

WORKDIR /home/container

COPY ./entrypoint.sh /entrypoint.sh

USER root
RUN chmod +x /entrypoint.sh

USER container

CMD ["/entrypoint.sh"]
