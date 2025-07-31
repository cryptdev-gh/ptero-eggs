FROM php:8.1-fpm

RUN apt-get update && apt-get install -y \
    nginx \
    libsqlite3-dev \
    libpq-dev \
    libzip-dev \
    unzip \
    zip \
    && docker-php-ext-install pdo pdo_mysql pdo_pgsql pdo_sqlite zip \
    && docker-php-ext-enable pdo_mysql pdo_pgsql pdo_sqlite

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

RUN useradd -m container

USER container
ENV USER=container
ENV HOME=/home/container

WORKDIR /home/container

COPY ./entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

CMD ["php-fpm"]
