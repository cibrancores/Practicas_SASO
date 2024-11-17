FROM debian:12

ADD files /root/files

RUN mv /root/files/start.sh /root/start.sh                              && \ 
    chmod 755 /root/start.sh                                            && \ 
    apt-get update                                                      && \
    apt-get install -y                                                     \
       nginx                                                               \
       mariadb-server                                                      \
       php-fpm                                                             \
       php8.2-mysql                                                     && \
    cat /root/files/default > /etc/nginx/sites-enabled/default

CMD /root/start.sh
