FROM php:7.3-apache
MAINTAINER Wayne Theisinger <wayne@intacart.co.uk>

    RUN a2enmod socache_shmcb ssl

ADD ioncube/ioncube_loader_lin_7.3.so /app/ioncube/ioncube_loader_lin_7.3.so

RUN apt-get update \
  && apt-get install -y \
    cron \
    libfreetype6-dev \
    libicu-dev \
    libjpeg62-turbo-dev \
    libpng-dev \
    libxslt1-dev \
    openssh-client \
    libzip-dev \
    unzip \
    rsync && \
    apt-get clean

RUN docker-php-ext-configure \
  gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/

RUN docker-php-ext-install \
  gd \
  intl \
  mbstring \
  pdo_mysql \
  mysqli \
  zip \
  bcmath \
  xml \
  dom \
  wddx \
  xsl \
  dom \
  soap \
  opcache \
  intl

RUN pecl install -o -f redis \
  &&  rm -rf /tmp/pear \
  &&  docker-php-ext-enable redis

RUN a2enmod rewrite
RUN a2enmod headers
RUN a2enmod http2

COPY conf/php.ini /usr/local/etc/php/
RUN chown -R root:staff /usr/local/etc/php/php.ini
