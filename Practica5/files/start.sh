#!/bin/bash

# Inicializamos los servicios
service apache2 start

# Salida para mantener el contenedor en ejecución
tail -f /var/log/apache2/*