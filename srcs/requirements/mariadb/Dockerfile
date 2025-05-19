# FROM alpine:3.18

# RUN apk update && apk add --no-cache \
#     mariadb mariadb-client

# RUN mkdir -p /run/mysqld /var/lib/mysql && \
#     chown -R mysql:mysql /run/mysqld /var/lib/mysql

# COPY ./conf/my.cnf /etc/my.cnf
# COPY ./tools/init.sql /init.sql

# EXPOSE 3306

# USER mysql

# CMD sh -c "\
#   if [ ! -d /var/lib/mysql/mysql ]; then \
#     echo 'Initializing database...'; \
#     mysql_install_db --user=mysql --datadir=/var/lib/mysql; \
#     mysqld --user=mysql --bootstrap < /init.sql; \
#   fi && \
#   exec mysqld --user=mysql"

FROM alpine:3.18

RUN apk update && apk add --no-cache mariadb mariadb-client

RUN mkdir -p /run/mysqld /var/lib/mysql && \
    chown -R mysql:mysql /run/mysqld /var/lib/mysql

COPY ./conf/my.cnf /etc/my.cnf
COPY ./tools/init.sql /init.sql
COPY ./tools/entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

EXPOSE 3306

USER mysql
ENTRYPOINT ["/entrypoint.sh"]
