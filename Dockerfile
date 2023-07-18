# Imagem base
FROM php:7.4-apache

ENV MOODLE_DATABASE_TYPE=mysqli
ENV MOODLE_DATABASE_HOST=localhost
ENV MOODLE_DATABASE_NAME=moodle
ENV MOODLE_DATABASE_USER=moodle
ENV MOODLE_DATABASE_PASSWORD=''
ENV MOODLE_DATABASE_PREFIX=mdl_
ENV MOODLE_DATABASE_PORT_NUMBER=3306
ENV MOODLE_SLAVE_DATABASE_HOST=false
ENV MOODLE_HOST=http://localhost
ENV MOODLEDATA_PATH=/var/www/moodledata
ENV MOODLE_USERNAME=admin

ENV MOODLE_ENABLE_SESSION_MEMCACHED=false
ENV MOODLE_SESSION_HANDLER_CLASS='\core\session\memcached'
ENV MOODLE_SESSION_MEMCACHED_SAVE_PATH=127.0.0.1:11211
ENV MOODLE_SESSION_MEMCACHED_PREFIX=memc.sess.key.
ENV MOODLE_SESSION_MEMCACHED_ACQUIRE_LOCK_TIMEOUT=120
ENV MOODLE_SESSION_MEMCACHED_LOCK_EXPIRE=7200
ENV MOODLE_SESSION_MEMCACHED_LOCK_RETRY_SLEEP=150

# Diretório de trabalho
WORKDIR /var/www

# # Variáveis de ambiente
# ENV COMPOSER_ALLOW_SUPERUSER=1

# Instalando pacotes e extensões necessárias
RUN apt update -y && \
    apt upgrade -y && \
    apt install unzip wget git curl -y && \
    apt install -y libonig-dev libcurl4-openssl-dev libxml2-dev libzip-dev libpng-dev libmemcached-dev && \
    docker-php-ext-install iconv mbstring curl tokenizer xmlrpc soap ctype zip gd simplexml dom xml intl json mysqli opcache && \
    printf "\n" | pecl install memcached  && \
    docker-php-ext-enable memcached  && \
    printf "\n" | pecl install redis  && \
    docker-php-ext-enable redis  && \
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