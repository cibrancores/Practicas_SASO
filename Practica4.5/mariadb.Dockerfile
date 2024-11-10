FROM debian:11

ARG DBUSER=user
ARG DBPASS=userpass
ARG DBADMINUSER=admin
ARG DBADMINPASS=adminpass
ARG DBNAME=newdatabase

RUN apt-get update && \
    apt-get -y install mariadb-server

RUN mariadbd-safe & \
    while ! mariadb-admin ping ; do sleep 1 ; done ; \
    mariadb-admin create $DBNAME && \
    echo "GRANT ALL PRIVILEGES ON *.* TO '$DBADMINUSER'@'%' IDENTIFIED BY '$DBADMINPASS' with GRANT OPTION;" | mariadb && \
    echo "GRANT ALL PRIVILEGES ON $DBNAME.* TO '$DBUSER'@'%' IDENTIFIED BY '$DBPASS' ;" | mariadb && \
    echo "FLUSH PRIVILEGES;" | mariadb && \
    mariadb-admin shutdown
    
RUN sed -i "s/^bind-address[[:space:]][[:space:]]*=[[:space:]][[:space:]]*.*$i/bind-address   = 0.0.0.0/g" /etc/mysql/mariadb.conf.d/50-server.cnf 

#To preserve Databases
RUN mv /var/lib/mysql /var/lib/mysql2 && \
    mkdir /var/lib/mysql && \
    chown mysql.mysql /var/lib/mysql && \
    chmod 755 /var/lib/mysql && \
    echo '#!/bin/bash' > /root/entrypoint.sh && \
    echo "" >> /root/entrypoint.sh && \
    echo "" >> /root/entrypoint.sh && \
    echo "if ! [ \"\$(ls /var/lib/mysql)\" ]" >> /root/entrypoint.sh && \
    echo "then" >> /root/entrypoint.sh && \
    echo "  cp -a /var/lib/mysql2/* /var/lib/mysql/\n\n" >> /root/entrypoint.sh && \
    echo "  chown mysql.mysql /var/lib/mysql\n\n" >> /root/entrypoint.sh && \
    echo "  chmod 755 /var/lib/mysql\n\n" >> /root/entrypoint.sh && \
    echo "fi" >> /root/entrypoint.sh && \
    echo "" >> /root/entrypoint.sh && \
    echo "" >> /root/entrypoint.sh && \
    echo "mariadbd-safe \$@" >> /root/entrypoint.sh && \
    chmod 755 /root/entrypoint.sh

ENTRYPOINT [ "/root/entrypoint.sh" ]

EXPOSE 3306

VOLUME /var/lib/mysql/
