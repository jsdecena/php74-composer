FROM php:7.4

# Install dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    libpng-dev \
    libjpeg62-turbo-dev \
    libfreetype6-dev \
    locales \
    zip \
    jpegoptim \
    optipng \
    pngquant \
    gifsicle \
    vim \
    unzip \
    git \
    curl \
    postgresql \ 
    postgresql-contrib \
    libpq-dev \
    libonig-dev \
    gcc make libssh2-1-dev \
    libssh2-1 \
    zlib1g-dev \
    libzip-dev \
    libcurl4-openssl-dev \
    pkg-config \
    libssl-dev

RUN pecl config-set php_ini /etc/php.ini

RUN curl http://pecl.php.net/get/ssh2-1.2.tgz -o ssh2.tgz && \
    pecl install ssh2 ssh2.tgz mongodb && \
    docker-php-ext-enable ssh2 && \
    rm -rf ssh2.tgz

COPY php.ini /usr/local/etc/php/conf.d/local.ini

# Install extensions
RUN docker-php-ext-install pdo pdo_mysql pdo_pgsql gd zip mbstring exif pcntl

# Clear cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
