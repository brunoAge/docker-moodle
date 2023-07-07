# Imagem base
FROM php:7.4-apache

# Diretório de trabalho
WORKDIR /var/www

# # Variáveis de ambiente
# ENV COMPOSER_ALLOW_SUPERUSER=1

# Instalando pacotes e extensões necessárias
RUN apt update -y && \
    apt upgrade -y && \
    apt install unzip wget git curl -y && \
    apt install -y libonig-dev libcurl4-openssl-dev libxml2-dev libzip-dev libpng-dev && \
    docker-php-ext-install iconv mbstring curl tokenizer xmlrpc soap ctype zip gd simplexml dom xml intl json && \
    rm -rf /var/lib/apt/lists/*

# # Install Moodle
RUN git clone -b MOODLE_310_STABLE git://git.moodle.org/moodle.git /var/www/html

# Set Moodle data directory permissions
RUN chown -R www-data:www-data /var/www/html

# Expose port 80 for Apache
EXPOSE 80
