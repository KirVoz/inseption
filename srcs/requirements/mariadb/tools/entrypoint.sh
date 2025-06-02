#!/bin/sh

SOCKET="/run/mysqld/mysqld.sock"

if [ ! -d "/var/lib/mysql/mysql" ]; then
  echo "Initializing database..."
  mysql_install_db --user=mysql --datadir=/var/lib/mysql > /dev/null

  echo "Starting temp server to apply init.sql..."
  mysqld --user=mysql --skip-networking --socket=$SOCKET &
  pid="$!"

  echo "Waiting for MariaDB to be ready..."
  until mysqladmin --socket=$SOCKET ping --silent; do
    sleep 1
  done

  echo "Generating init.sql with variables..."
  cat <<EOF > /tmp/init.sql
CREATE DATABASE IF NOT EXISTS \`${DB_NAME}\`;
CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASSWORD}';
GRANT ALL PRIVILEGES ON \`${DB_NAME}\`.* TO '${DB_USER}'@'%';
ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_ROOT_PASSWORD}';
FLUSH PRIVILEGES;
EOF

  echo "Applying init.sql..."
  mysql --socket=$SOCKET < /tmp/init.sql

  echo "Shutting down temp server..."
  mysqladmin --socket=$SOCKET shutdown
  wait "$pid"
fi

echo "Starting MariaDB..."
exec mysqld --user=mysql
