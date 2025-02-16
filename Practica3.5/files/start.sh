#!/bin/bash

service nginx start
service php8.2-fpm start
service mariadb start

tail -f /var/log/nginx/* /var/log/php8.2-fpm.log 

