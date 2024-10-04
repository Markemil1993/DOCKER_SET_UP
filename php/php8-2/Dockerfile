FROM php:8.2-fpm

# Install system dependencies and PHP extensions
RUN apt-get update && apt-get install -y \
        libfreetype6-dev \
        libjpeg-dev \
        libpng-dev \
        unzip \
        git \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd \
    && docker-php-ext-install pdo_mysql pdo mysqli

# Install and enable Redis extension
RUN pecl install redis \
    && docker-php-ext-enable redis

# Install Composer
RUN curl -sS https://getcomposer.org/installer -o /tmp/composer-setup.php \
    && php /tmp/composer-setup.php --install-dir=/usr/local/bin --filename=composer \
    && rm /tmp/composer-setup.php

# Set working directory
WORKDIR /usr/share/nginx/html/viptutors-laravel