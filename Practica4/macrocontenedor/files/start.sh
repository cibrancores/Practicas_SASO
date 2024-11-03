#!/bin/bash

# Inicializamos los servicios
service apache2 start
service mariadb start

# Esperamos a que MariaDB se inicialice
while ! mariadb-admin status; do
    sleep 2
done

# Ejecutamos script para crear base de datos y usuario
mysql < /root/init.sql

# Si se quiere eliminar para no dejar la contraseña
# pero en este caso al ser para desarrollo se podría
# dejar para poder hacer consultas en la base de datos
# de pruebas.
rm /root/init.sql
rm -r /root/files/

# Salida para mantener el contenedor en ejecución
tail -f /var/log/apache2/*