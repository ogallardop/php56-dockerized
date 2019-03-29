FROM ubuntu:14.04

MAINTAINER oscar.gallardo@outlook.com

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get upgrade && apt-get install -yq --no-install-recommends \
  apt-utils \
  curl \
  # Install git
  git \
  # Install apache
  apache2 \
  # Install php 5
  libapache2-mod-php5 \
  php5-cli \
  php5-json \
  php5-curl \
  php5-fpm \
  php5-gd \
  php5-ldap \
  php5-mysql \
  php5-intl \
  php5-pgsql \
  php-pear \
  # Install tools
  openssl \
  nano \
  graphicsmagick \
  imagemagick \
  ghostscript \
  mysql-client \
  iputils-ping \
  locales \
  sqlite3 \
  ca-certificates \
  && apt-get clean && rm -rf /var/lib/apt/lists/*

# Install pear dependencies
RUN pear install OLE-1.0.0RC3

# Install composer
RUN curl -sS https://getcomposer.org/installer | php
RUN mv composer.phar /usr/local/bin/composer

# Set locales
RUN locale-gen en_US.UTF-8 en_GB.UTF-8 de_DE.UTF-8 es_ES.UTF-8 fr_FR.UTF-8 it_IT.UTF-8 km_KH sv_SE.UTF-8 fi_FI.UTF-8

RUN a2enmod rewrite expires

# Configure vhost
ADD sites/default.conf /etc/apache2/sites-enabled/000-default.conf

EXPOSE 80 443 22 9000

WORKDIR /var/www/html
VOLUME ["/var/www"]

RUN rm index.html

CMD ["apache2ctl", "-D", "FOREGROUND"]

