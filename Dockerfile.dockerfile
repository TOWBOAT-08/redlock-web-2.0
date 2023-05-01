FROM php:8.1-apache

COPY website/ /var/www/html/
COPY redlock-db.sql /usr/src/redlock-db.sql
RUN docker-php-ext-install mysqli
RUN chown -R www-data:www-data /var/www/html && \
    chown -R www-data:www-data /usr/src/redlock-db.sql
RUN chmod -R u=rwX,g=rwX,o= /var/www/html && \
    chmod -R u=rw,g=rw,o= /usr/src/redlock-db.sql && \
    chmod 777 /var/www/html && \
    chmod 777 /var/www/html/*
RUN apt-get update && \
    apt-get install -y mariadb-client && \
    echo "CREATE DATABASE Redlock;" | mysql -h localhost -u root && \
    mysql -h localhost -u root Redlock < /usr/src/redlock-db.sql
RUN sed -i 's/80/7077/' /etc/apache2/sites-available/000-default.conf && \
    sed -i 's/80/7077/' /etc/apache2/ports.conf

CMD ["apache2-foreground"]