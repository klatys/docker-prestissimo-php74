FROM php:7.4-cli

MAINTAINER Yannick Pereira-Reis <yannick.pereira.reis@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && \
    apt-get install -y \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libmcrypt-dev \
    libsodium-dev \
    libbz2-dev \
    libonig-dev \
    libxslt-dev \
    libzip-dev \
    curl \
    git \
    subversion \
    unzip \
    sudo \
  && rm -r /var/lib/apt/lists/*

RUN docker-php-ext-install sodium zip bz2 mbstring xsl bcmath intl pdo_mysql soap \
  && docker-php-ext-configure gd --with-freetype --with-jpeg \
  && docker-php-ext-install gd

RUN echo "memory_limit=-1" > $PHP_INI_DIR/conf.d/memory-limit.ini
RUN echo "date.timezone=${PHP_TIMEZONE:-UTC}" > $PHP_INI_DIR/conf.d/date_timezone.ini
RUN php --version
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN composer --version

# PRESTISSIMOOOOOOOOOO !!
RUN composer global require hirak/prestissimo --ignore-platform-reqs

VOLUME ["/srv"]
WORKDIR /srv

##########################################################################################################
# No ENTRYPOINT in my docker images to let people execute scripts or commands before using the image tools
##########################################################################################################

CMD []
