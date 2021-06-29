FROM php:7.4-fpm

# Install system dependencies
RUN apt-get update && apt-get install -y \
    cron \
    git \
    curl \
    vim \
    locales \
    libpng-dev \
    libsodium-dev \
    libonig-dev \
    libxml2-dev \
    libzip-dev \
    libjpeg62-turbo-dev \
    libfreetype6-dev \
    zip \
    unzip \
    && docker-php-ext-install pdo_mysql \
    && docker-php-ext-install mbstring \
    && docker-php-ext-install exif \
    && docker-php-ext-install pcntl \
    && docker-php-ext-install bcmath \
    && docker-php-ext-install gd \
    && docker-php-ext-install zip \
    && docker-php-source delete \
    && apt-get clean &&\

# Clear cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Get latest Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Create system user to run Composer and Artisan Commands
RUN groupadd -g 1000 www
RUN useradd -u 1000 -ms /bin/bash -g www www

# Set working directory
WORKDIR /var/www

# Copy existing application directory contents
COPY . /var/www

# Copy existing application directory permissions
COPY --chown=www:www . /var/www

# Change current user to www
USER www

# Start php-fpm server
CMD ["php-fpm"]

# Copy crontab file to the cron.d directory
COPY crontab /etc/cron.d/crontab

# Give execution rights on the cron job
RUN chmod 0644 /etc/cron.d/crontab

# Apply cron job
RUN crontab /etc/cron.d/crontab

# Create the log file to be able to run tail
RUN touch /var/log/cron.log

# Run the command on container startup
CMD cron && tail -f /var/log/cron.log
