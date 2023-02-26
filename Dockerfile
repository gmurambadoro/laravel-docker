FROM php:8.2-apache

WORKDIR /var/www/project

# install dependencies
RUN apt-get update \
    && apt-get install -y curl apt-transport-https ca-certificates gnupg \
    && apt-get update \
    && apt-get install -y git zip libicu-dev zlib1g-dev g++

# install php extensions
RUN docker-php-ext-install pdo pdo_mysql bcmath \
    && docker-php-ext-configure intl && docker-php-ext-install intl

# install composer
COPY --from=composer:latest /usr/bin/composer /usr/local/bin/composer

# install laravel
RUN composer global require laravel/installer \
    && ln -s /root/.composer/vendor/bin/laravel /usr/local/bin/laravel

# install nodejs
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - &&\
    apt-get install -y nodejs

# enable apache2 modules
RUN a2enmod rewrite



