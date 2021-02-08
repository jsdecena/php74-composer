FROM php:7.4

# Install dependencies
RUN apt-get update && \
    apt-get install -y git \
    zip \
    libjpeg-dev \
    libpng-dev \
    libpq-dev \
    zlib1g-dev \
    libzip-dev \
    libxpm-dev \
    libcurl4-openssl-dev \
    pkg-config \
    libssl-dev \
    libssh2-1 \
    supervisor \
    gcc make libssh2-1-dev

RUN pecl config-set php_ini /etc/php.ini

RUN curl http://pecl.php.net/get/ssh2-1.2.tgz -o ssh2.tgz && \
    pecl install ssh2 ssh2.tgz mongodb && \
    docker-php-ext-enable ssh2 && \
    rm -rf ssh2.tgz

# Install extensions
RUN docker-php-ext-install pdo_mysql pdo_pgsql mbstring exif pcntl zip gd
RUN docker-php-ext-configure gd --with-gd --with-jpeg-dir=/usr/include/ --with-png-dir=/usr/include/

# Clear cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
