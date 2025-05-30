FROM alpine:3.18

RUN apk update && apk add --no-cache \
    php81 \
    php81-fpm \
    php81-mysqli \
    php81-session \
    php81-json \
    php81-opcache \
    php81-dom \
    php81-pdo \
    php81-mbstring \
    php81-ctype \
    php81-phar \
    wget \
    curl \
    mysql-client

RUN sed -i 's|listen = 127.0.0.1:9000|listen = 0.0.0.0:9000|' /etc/php81/php-fpm.d/www.conf

RUN echo 'env[WORDPRESS_DB_NAME] = $WORDPRESS_DB_NAME' >> /etc/php81/php-fpm.d/www.conf && \
    echo 'env[WORDPRESS_DB_USER] = $WORDPRESS_DB_USER' >> /etc/php81/php-fpm.d/www.conf && \
    echo 'env[WORDPRESS_DB_PASSWORD] = $WORDPRESS_DB_PASSWORD' >> /etc/php81/php-fpm.d/www.conf && \
    echo 'env[WORDPRESS_DB_HOST] = $WORDPRESS_DB_HOST' >> /etc/php81/php-fpm.d/www.conf

RUN addgroup -S www-data || true && adduser -S www-data -G www-data || true

RUN mkdir -p /var/www/html && \
    wget https://wordpress.org/latest.tar.gz && \
    tar -xzf latest.tar.gz && \
    mv wordpress/* /var/www/html && \
    rm -rf wordpress latest.tar.gz

COPY ./conf/wp-config.php /var/www/html/wp-config.php

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar -O /usr/local/bin/wp && \
    chmod +x /usr/local/bin/wp

COPY ./conf/create-wp-users.sh /create-wp-users.sh
RUN chmod +x /create-wp-users.sh

RUN chown -R www-data:www-data /var/www/html

EXPOSE 9000

CMD ["/create-wp-users.sh"]
# CMD ["sh", "-c", "/create-wp-users.sh && php-fpm81 -F"]
