FROM alpine:3.18

RUN apk update && apk add --no-cache \
    nginx \
    openssl

RUN mkdir -p /etc/nginx/ssl /run/nginx

RUN openssl req -x509 -nodes -days 365 \
    -subj "/C=AM/ST=42/L=Yerevan/O=42/CN=kvoznese.42.fr" \
    -newkey rsa:2048 \
    -keyout /etc/nginx/ssl/nginx.key \
    -out /etc/nginx/ssl/nginx.crt

COPY ./conf/nginx.conf /etc/nginx/nginx.conf
COPY ./conf/default.conf /etc/nginx/conf.d/default.conf

WORKDIR /var/www/html

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]
