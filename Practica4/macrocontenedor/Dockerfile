FROM debian:12

ARG DB_NAME=mydatabase
ARG DB_USER=myuser
ARG DB_PASS=mypassword

ADD files /root/files

RUN mv /root/files/start.sh /root/start.sh                              && \
    chmod 755 /root/start.sh                                            && \
    apt-get update                                                      && \
    apt-get install -y                                                     \
       apache2                                                             \
       mariadb-server                                                      \
       libapache2-mod-php8.2 php8.2 php8.2-mysql                        && \
    echo "CREATE DATABASE ${DB_NAME};" > /root/init.sql && \
    echo "CREATE USER '${DB_USER}'@'localhost' IDENTIFIED BY '${DB_PASS}';" >> /root/init.sql && \
    echo "GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'localhost';" >> /root/init.sql && \
    echo "FLUSH PRIVILEGES;" >> /root/init.sql

CMD /root/start.sh

EXPOSE 80 3306

WORKDIR /var/www/html