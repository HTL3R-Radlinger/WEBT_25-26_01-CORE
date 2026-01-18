# Base image: PHP 8.2 with Apache preconfigured
FROM php:8.2-apache

# Replace the default Apache virtual host configuration
COPY httpd-vhosts.conf /etc/apache2/sites-available/000-default.conf

# Enable Apache mod_rewrite (commonly required for routing and clean URLs)
RUN a2enmod rewrite

# Set the working directory for the application
WORKDIR /var/www/html/

# Copy all project files into the container
COPY . .

# Set correct ownership so Apache (www-data) can read/write files
RUN chown -R www-data:www-data *

# Start Apache in the foreground (required for Docker containers)
ENTRYPOINT ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]