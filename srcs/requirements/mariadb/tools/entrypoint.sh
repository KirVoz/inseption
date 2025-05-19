#!/bin/sh

if [ ! -d "/var/lib/mysql/mysql" ]; then
  echo "Initializing database..."
  mysql_install_db --user=mysql --datadir=/var/lib/mysql > /dev/null

  echo "Starting temp server to apply init.sql..."
  mysqld --user=mysql --skip-networking &
  pid="$!"

  echo "Waiting for MariaDB to be ready..."
  until mysqladmin ping --silent; do
    sleep 1
  done

  echo "Applying init.sql..."
  mysql < /init.sql

  echo "Shutting down temp server..."
  mysqladmin shutdown
  wait "$pid"
fi

echo "Starting MariaDB..."
exec mysqld --user=mysql
