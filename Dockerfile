FROM nginx:1.19.6-alpine
RUN apk --update add php-fpm
RUN mkdir -p /tmp/nginx && echo "clear_env = no" >> /etc/php7/php-fpm.conf
ADD www /www
ADD nginx.conf /etc/nginx/
COPY entrypoint.sh .
RUN chmod +x entrypoint.sh
ENTRYPOINT [ "./entrypoint.sh" ]
