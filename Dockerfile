FROM finalduty/archlinux:weekly

MAINTAINER Jakub Pistek <mail@jakubpistek.cz>

ENV ProjectName nfn

ENV LANGUAGE en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LC_ALL C

RUN pacman --noconfirm --quiet -Syu \
    base-devel \
    openssh \
    git \
    php-fpm \
    php-memcached \
    php-sqlite \
    php-gd \
    php-apcu \
    php-cgi \
    qrencode \
    unzip \
    xdebug \
    sudo \
    curl \
    php-pgsql

ADD nginx.conf /etc/nginx/nginx.conf
ADD app-php-fpm /bin/app-php-fpm
ADD inst_yaourt.sh inst_yaourt.sh
ADD php-fpm.conf /etc/php/php-fpm.d/www.conf

RUN sh -x ./inst_yaourt.sh

USER user
RUN yaourt -S --noconfirm php-imagick php-redis
USER root

EXPOSE 80

VOLUME /project/

CMD app-php-fpm
