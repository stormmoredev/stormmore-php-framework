FROM php:8.3-alpine as storm-base
ENV APP_ENV=development
RUN mv "$PHP_INI_DIR/php.ini-development" "$PHP_INI_DIR/php.ini"

#intl
RUN apk add icu-dev
RUN apk add icu-data-full
RUN docker-php-ext-configure intl
RUN docker-php-ext-install intl

#curl
COPY --from=composer:latest /usr/bin/composer /usr/local/bin/composer

FROM storm-base as storm
WORKDIR /usr/storm
COPY stormmore.php /usr/local/lib/php/stormmore.php
COPY src/ /usr/storm/src
COPY server/ /usr/storm/server
CMD php -S 0.0.0.0:80 -t /usr/storm/server