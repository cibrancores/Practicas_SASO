FROM debian:12

ADD files /root/files

RUN mv /root/files/start.sh /root/start.sh                              && \
    chmod 755 /root/start.sh                                            && \
    apt-get update                                                      && \
    apt-get install -y                                                     \
       apache2                                                             \
       libapache2-mod-php8.2 php8.2 php8.2-mysql

CMD ["/root/start.sh"]

EXPOSE 80

VOLUME /var/www/html