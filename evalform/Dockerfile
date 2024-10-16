ARG PHP_VER=8.1

# Choose an Alpine-Based Base Image
FROM php:${PHP_VER}-fpm-alpine

# Install dependencies
RUN apk add --no-cache nginx curl git icu-dev supervisor
RUN docker-php-ext-install intl pdo pdo_mysql mysqli

# Copy config files
COPY conf/supervisord.conf /etc/supervisord.conf
COPY conf/nginx.conf /etc/nginx/nginx.conf

# Setup composer
RUN curl -sS https://getcomposer.org/installer -o composer-setup.php && \
    php composer-setup.php --install-dir=/usr/local/bin --filename=composer

WORKDIR /var/www/evalform

# Download evalform
RUN git clone https://github.com/slapelachie/evalform /var/www/evalform

COPY conf/codeigniter.env /var/www/evalform/.env

RUN chmod -R 777 /var/www/evalform

# Install codeigniter dependencies
RUN composer install --no-dev --optimize-autoloader --no-interaction

# # Implement Health Checks
HEALTHCHECK --start-period=10s --interval=30s --timeout=10s --retries=3 \
    CMD curl -f http://localhost/ || exit 1

# Configure and Expose the Container
EXPOSE 80

VOLUME /var/www/evalform

# Add an entrypoint script that runs both PHP-FPM and Nginx
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

# A script to later create the database for codeigniter
COPY migrations.sh /usr/local/bin/migrations.sh
RUN chmod +x /usr/local/bin/migrations.sh

# Run the entrypoint script
CMD ["/usr/local/bin/entrypoint.sh"]

LABEL maintainer="Lachlan Slape <l.slape@student.uq.edu.au>"
LABEL version="1.0"