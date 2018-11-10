FROM php:5.6-apache
MAINTAINER Wayne Theisinger <wayne@intacart.co.uk>

ADD ioncube/ioncube_loader_lin_5.6.so /app/ioncube/ioncube_loader_lin_5.6.so

RUN apt-get update \
  && apt-get install -y \
    cron \
    nano \
    libfreetype6-dev \
    libicu-dev \
    libjpeg62-turbo-dev \
    libmcrypt-dev \
    libpng-dev \
    libxslt1-dev \
    ssmtp \
    openssh-client \
    rsync && \
    apt-get clean

RUN docker-php-ext-configure \
  gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/

RUN docker-php-ext-install \
  gd \
  intl \
  mbstring \
  mcrypt \
  pdo_mysql \
  zip \
  bcmath \
  xml \
  dom \
  wddx \
  xsl \
  mysql \
  dom \
  opcache

RUN a2enmod rewrite
RUN a2enmod headers

COPY conf/php.ini /usr/local/etc/php/
RUN chown -R root:staff /usr/local/etc/php/php.ini
