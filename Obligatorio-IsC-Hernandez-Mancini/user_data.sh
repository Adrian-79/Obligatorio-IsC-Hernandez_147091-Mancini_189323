#!/bin/bash
################################################################################
# Script user_data para instancias EC2
# Instalación de Apache, PHP 8.2, Git, configuración EFS, clonación y conexión RDS
################################################################################

# Redirigir logs para debug
exec > /var/log/user_data.log 2>&1
set -x

# Verificar si el agente SSM está instalado
if ! systemctl is-active --quiet amazon-ssm-agent; then
  echo "SSM Agent no está activo, instalando..."
  
# Para Amazon Linux 2, instalar el agente
  yum install -y amazon-ssm-agent
  
# Habilitar y arrancar el servicio
  systemctl enable amazon-ssm-agent
  systemctl start amazon-ssm-agent
  
  echo "SSM Agent instalado y arrancado."
else
  echo "SSM Agent ya está instalado y activo."
fi

# Variables inyectadas desde Terraform
efs_id="${efs_id}"
efs_dns="${efs_dns}"    
db_endpoint="${db_endpoint}"
db_user="${db_user}"
db_pass="${db_pass}"
db_name="${db_name}"
github_repo="${github_repo}"
region="${region}"


# Actualización de paquetes e instalación de dependencias (INCLUYENDO GIT)
yum update -y
amazon-linux-extras enable php8.2 
yum install -y httpd php php-mysqlnd php-pdo php-gd php-mbstring git mysql amazon-efs-utils unzip


# Verificar instalación de Git
if ! command -v git &> /dev/null; then
  echo "ERROR: Git no se instaló correctamente" >&2
  exit 1
fi

# Habilitar e iniciar Apache
systemctl enable httpd
systemctl start httpd

# Asegurar que el directorio existe antes de montar EFS o clonar
mkdir -p /var/www/html


# Montar EFS solo si no está montado
if ! mountpoint -q /var/www/html; then
  mount -t efs -o tls ${efs_dns}:/ /var/www/html || {
    echo "ERROR: Falló el montaje de EFS" >&2
    exit 1
  }
else
  echo "EFS ya está montado en /var/www/html"
fi

# Configurar montaje persistente
grep -q "${efs_dns}" /etc/fstab || echo "${efs_dns}:/ /var/www/html efs defaults,_netdev 0 0" >> /etc/fstab

# Limpiar EFS (borrar contenidos existentes)
echo "Limpiando contenido del EFS montado"
rm -rf /var/www/html/*
rm -rf /var/www/html/.[!.]* /var/www/html/..?* 2>/dev/null || true


# Solo clonar si el repo no existe (después de montar EFS)
#if [ ! -d /var/www/html/.git ]; then
  for i in {1..3}; do
    git clone "${github_repo}" /var/www/html && break
    sleep 10
    if [ "$i" -eq 3 ]; then
      echo "ERROR: Falló la clonación del repositorio después de 3 intentos" >&2
      exit 1
    fi
  done
#else
#  echo "Repositorio ya existente en /var/www/html, no se clona"

#fi

# Copiar contenido del repo (sin .git) al EFS
rsync -a --delete --exclude='.git' /tmp/repo/ /var/www/html/


#####
# Crear healthcheck.php manualmente
cat <<EOF > /var/www/html/healthcheck.php
<?php http_response_code(200); echo "OK"; ?>
EOF

echo "Archivo healthcheck.php creado correctamente"
######


# Configurar .htaccess (si viene como "htaccess")
[ -f /var/www/html/htaccess ] && mv /var/www/html/htaccess /var/www/html/.htaccess

# Crear config.php con las credenciales para el acceso a RDS
cat <<EOF > /var/www/html/config.php
<?php
define("DB_HOST", "${db_endpoint}");
define("DB_NAME", "${db_name}");
define("DB_USER", "${db_user}");
define("DB_PASS", "${db_pass}");
?>
EOF

# Importar la estructura de tablas si aún no existe, Usamos el db-settings.sql del repo:
 if ! mysql -h "$db_endpoint" -u "$db_user" -p"$db_pass" \
         -e "USE $db_name; SHOW TABLES;" | grep -q "admin"; then
  echo "Importando estructura de base de datos desde db-settings.sql..."
  mysql -h "$db_endpoint" -u "$db_user" -p"$db_pass" \
        "$db_name" < /var/www/html/db-settings.sql
else
  echo "La base de datos ya contiene tablas, omitiendo importación."
fi

# Verificar que el archivo db.php tenga el host correcto
echo "Verificando contenido de views/db.php:"
cat /var/www/html/views/db.php

# Configurar permisos
chown -R apache:apache /var/www/html

# Esperar a que el archivo httpd.conf contenga el bloque
for i in {1..10}; do
  if grep -q '<Directory "/var/www/html">' /etc/httpd/conf/httpd.conf; then
    break
  fi
  echo "Esperando que aparezca el bloque <Directory> en httpd.conf..."
  sleep 2
done

# Ejecutar sed solo si existe el bloque
sudo sed -i '/<Directory "\/var\/www\/html">/,/<\/Directory>/ s/AllowOverride None/AllowOverride All/' /etc/httpd/conf/httpd.conf


# Reiniciar Apache para aplicar cambios
systemctl restart httpd

echo "Despliegue completado correctamente"
exit 0
