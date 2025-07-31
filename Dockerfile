FROM alpine:latest

RUN apk update && apk add --no-cache \
    curl \
    ca-certificates \
    nginx \
    php8 \
    php8-fpm \
    php8-xml \
    php8-exif \
    php8-session \
    php8-soap \
    php8-openssl \
    php8-gmp \
    php8-json \
    php8-dom \
    php8-pdo \
    php8-mysqli \
    php8-pdo_pgsql \
    php8-bcmath \
    php8-gd \
    php8-odbc \
    php8-pdo_mysql \
    php8-gettext \
    php8-bz2 \
    php8-iconv \
    php8-curl \
    php8-ctype \
    php8-phar \
    php8-fileinfo \
    php8-mbstring \
    php8-simplexml \
    sqlite-dev \
    autoconf \
    g++ \
    make \
    musl-dev

RUN curl -fsSL https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/docker-php-ext-install.sh -o /usr/local/bin/docker-php-ext-install \
    && chmod +x /usr/local/bin/docker-php-ext-install

RUN docker-php-ext-install pdo_sqlite

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

RUN adduser -D -h /home/container container && chown -R container:container /home/container

USER container
ENV USER=container
ENV HOME=/home/container

WORKDIR /home/container

COPY ./entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

CMD ["/bin/ash", "/entrypoint.sh"]
