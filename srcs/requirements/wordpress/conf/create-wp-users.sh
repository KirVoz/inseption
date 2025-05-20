#!/bin/sh

cd /var/www/html

until wp core is-installed --allow-root; do
    wp core install --url="${WP_SITE_URL}" \
        --title="${WP_SITE_TITLE}" \
        --admin_user="${WP_ADMIN_USER}" \
        --admin_password="${WP_ADMIN_PASSWORD}" \
        --admin_email="${WP_ADMIN_EMAIL}" \
        --skip-email \
        --allow-root && break
    sleep 5
done

wp user create "${WP_USER2_NAME}" "${WP_USER2_EMAIL}" --role=editor --user_pass="${WP_USER2_PASSWORD}" --allow-root