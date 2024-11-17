FROM debian:12

ADD files /root/files

RUN mv /root/files/start.sh /root/start.sh                              && \
    chmod 755 /root/start.sh                                            && \
    apt-get update                                                      && \
    apt-get install -y                                                     \
       apache2                                                             \
       libapache2-mod-php8.2 php8.2 php8.2-mysql                        && \
    mv /root/files/sites.conf /etc/apache2/sites-available/sites.conf   && \
    a2ensite sites.conf                                                 && \
    a2dissite 000-default                                               && \
    apt-get clean                                                       && \
    rm -rf /var/lib/apt/lists/*

CMD ["/root/start.sh"]

EXPOSE 80

VOLUME /var/www/html