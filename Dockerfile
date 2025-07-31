FROM debian:bookworm-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
    curl ca-certificates nginx php php-xml php-exif php-fpm php-session php-soap php-openssl php-gmp php-pdo \
    php-json php-dom php-zip php-mysqli php-sqlite3 php-pgsql php-bcmath php-gd php-odbc php-mysql php-gettext \
    php-bz2 php-iconv php-curl php-ctype php-phar php-fileinfo php-mbstring php-tokenizer php-simplexml \
    composer \
 && rm -rf /var/lib/apt/lists/*

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

RUN useradd -m container

USER container
ENV USER=container
ENV HOME=/home/container

WORKDIR /home/container
COPY ./entrypoint.sh /entrypoint.sh

CMD ["/bin/bash", "/entrypoint.sh"]
