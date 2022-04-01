FROM php:8.1-fpm

WORKDIR /var/www/

ARG WWWUSER=1000
ARG WWWGROUP=1000
ARG WWWUSERNAME=www
ARG TZ=UTC

ENV DEBIAN_FRONTEND=noninteractive

SHELL ["/bin/bash", "-eou", "pipefail", "-c"]

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime \
    && echo $TZ > /etc/timezone

# Install system dependencies
RUN apt-get update &&\
    apt-get upgrade -yqq &&\
    pecl -q channel-update pecl.php.net &&\
    apt-get install -yqq --no-install-recommends --show-progress \
          apt-utils \
          gnupg \
          gosu \
          git \
          curl \
          vim \
          locales \
          libcurl4-openssl-dev \
          ca-certificates \
          libmemcached-dev \
          libz-dev \
          libbrotli-dev \
          libpq-dev \
          libjpeg-dev \
          libpng-dev \
          libfreetype6-dev \
          libssl-dev \
          libwebp-dev \
          libmcrypt-dev \
          libonig-dev \
          libzip-dev zip unzip \
          libargon2-1 \
          libidn2-0 \
          libpcre2-8-0 \
          libpcre3 \
          libxml2 \
          libzstd1 \
          procps \
    && docker-php-ext-install pdo_mysql \
    && docker-php-ext-install mbstring \
    && docker-php-ext-install exif \
    && docker-php-ext-install pcntl \
    && docker-php-ext-install bcmath \
    && docker-php-ext-install gd \
    && docker-php-ext-install zip \
    && docker-php-source delete

RUN pecl install redis && docker-php-ext-enable redis.so

# Get latest Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Install supervisor
RUN apt-get update &&\
    apt-get install -y supervisor &&\
    touch /var/run/supervisor.sock &&\
    chmod 777 /var/run/supervisor.sock &&\
    unlink /var/run/supervisor.sock

RUN apt-get install -yqq --no-install-recommends --show-progress libc-ares-dev &&\
    pecl -q install -o -f -D 'enable-openssl="yes" enable-http2="yes" enable-swoole-curl="yes" enable-mysqlnd="yes" enable-cares="yes" enable-sockets="yes" enable-json="yes"' swoole &&\
    docker-php-ext-enable swoole

# Clear cache
RUN apt-get clean \
    && docker-php-source delete \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    && rm /var/log/lastlog /var/log/faillog

# Create system user to run Composer and Artisan Commands
RUN groupadd --force -g $WWWGROUP $WWWUSERNAME \
    && useradd -ms /bin/bash --no-log-init --no-user-group -g $WWWGROUP -u $WWWUSER $WWWUSERNAME

# Set working directory
WORKDIR /var/www

# Copy existing application directory contents
COPY . /var/www

# Copy existing application directory permissions
COPY --chown=$WWWUSERNAME:$WWWUSERNAME . /var/www

# Change current user to www
USER $WWWUSERNAME

# Start php-fpm server
CMD ["php-fpm"]