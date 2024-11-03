<?php
  // Configuración de conexión
  $servername = "localhost";  // Cambia esto si el servidor no está en localhost
  $username = "myuser";   // Cambia por el nombre de usuario de MariaDB
  $password = "mypassword"; // Cambia por la contraseña de tu usuario
  $dbname = "mydatabase"; // Cambia por el nombre de tu base de datos

  // Crear conexión
  $conn = new mysqli($servername, $username, $password, $dbname);

  // Verificar conexión
  if ($conn->connect_error) {
    die("Conexión fallida: " . $conn->connect_error);
  }
  echo "Conexión exitosa con la base de datos";

  // Cerrar conexión
  $conn->close();

  phpinfo();
?>