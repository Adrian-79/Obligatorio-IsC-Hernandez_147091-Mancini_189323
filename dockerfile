# Imagen base oficial con PHP 8.2 y Apache
FROM php:8.2-apache

# Habilitar mod_rewrite para URLs amigables
RUN a2enmod rewrite

# Copiar archivo .htaccess (si lo tenés localmente, descomentar COPY)
# COPY .htaccess /var/www/html/.htaccess

# Establecer el directorio de trabajo
WORKDIR /var/www/html

# Eliminar archivos default y clonar el repositorio (puede adaptarse)
RUN apt-get update && \
    apt-get install -y git unzip && \
    rm -rf /var/www/html/* && \
    git clone https://github.com/tu-usuario/ecommerce-php.git . && \
    chown -R www-data:www-data /var/www/html

# Configurar Apache para permitir .htaccess (modificar AllowOverride)
RUN sed -i '/<Directory \/var\/www\/>/,/<\/Directory>/ s/AllowOverride None/AllowOverride All/' /etc/apache2/apache2.conf

# Exponer puerto 80
EXPOSE 80

# Iniciar Apache en primer plano
CMD ["apache2-foreground"]