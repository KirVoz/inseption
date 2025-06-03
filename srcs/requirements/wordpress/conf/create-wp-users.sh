#!/bin/sh

cd /var/www/html

until mysqladmin ping -h"$WORDPRESS_DB_HOST" -u"$WORDPRESS_DB_USER" -p"$WORDPRESS_DB_PASSWORD" --silent; do
    echo "Waiting for MariaDB..."
    sleep 2
done

if ! wp core is-installed --allow-root; then
    wp core install --url="${WP_SITE_URL}" \
        --title="${WP_SITE_TITLE}" \
        --admin_user="${WP_ADMIN_USER}" \
        --admin_password="${WP_ADMIN_PASSWORD}" \
        --admin_email="${WP_ADMIN_EMAIL}" \
        --skip-email \
        --allow-root
fi

if ! wp user get "${WP_USER2_NAME}" --field=user_login --allow-root > /dev/null 2>&1; then
    wp user create "${WP_USER2_NAME}" "${WP_USER2_EMAIL}" --role=editor --user_pass="${WP_USER2_PASSWORD}" --allow-root
fi

php-fpm83 -F