# Imagem base
FROM php:7.4-apache

ENV MOODLE_DATABASE_TYPE=mysqli
ENV MOODLE_DATABASE_HOST=localhost
ENV MOODLE_DATABASE_NAME=moodle
ENV MOODLE_DATABASE_USER=moodle
ENV MOODLE_DATABASE_PASSWORD=''
ENV MOODLE_DATABASE_PREFIX=mdl_
ENV MOODLE_DATABASE_PORT_NUMBER=3306
ENV MOODLE_HOST=http://localhost
ENV MOODLEDATA_PATH=/var/www/moodledata
ENV MOODLE_USERNAME=admin

# Diretório de trabalho
WORKDIR /var/www

# # Variáveis de ambiente
# ENV COMPOSER_ALLOW_SUPERUSER=1

# Instalando pacotes e extensões necessárias
RUN apt update -y && \
    apt upgrade -y && \
    apt install unzip wget git curl -y && \
    apt install -y libonig-dev libcurl4-openssl-dev libxml2-dev libzip-dev libpng-dev && \
    docker-php-ext-install iconv mbstring curl tokenizer xmlrpc soap ctype zip gd simplexml dom xml intl json mysqli && \
    rm -rf /var/lib/apt/lists/*

# # Install Moodle
RUN git clone -b MOODLE_310_STABLE git://git.moodle.org/moodle.git /var/www/html

RUN mkdir moodledata
RUN chmod 777 moodledata
COPY config.php /var/www/html/

# Set Moodle data directory permissions
RUN chown -R www-data:www-data /var/www

# Expose port 80 for Apache
EXPOSE 80
