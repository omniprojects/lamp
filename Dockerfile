FROM ubuntu:trusty
MAINTAINER Jonathan Azoff <dev@beomni.com>

# Install packages
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && \
  apt-get -y install supervisor git apache2 libapache2-mod-php5 mysql-server php5-imagick php5-mysql pwgen php-apc php5-mcrypt php5-curl && \
  echo "ServerName localhost" >> /etc/apache2/apache2.conf

# Add image configuration and scripts
ADD mysql-setup.sh /mysql-setup.sh
ADD start-apache2.sh /start-apache2.sh
ADD start-mysqld.sh /start-mysqld.sh
ADD run.sh /run.sh
RUN chmod 755 /*.sh
ADD my.cnf /etc/mysql/conf.d/my.cnf
ADD supervisord-apache2.conf /etc/supervisor/conf.d/supervisord-apache2.conf
ADD supervisord-mysqld.conf /etc/supervisor/conf.d/supervisord-mysqld.conf

# Remove pre-installed database
RUN rm -rf /var/lib/mysql/*

# Add MySQL utils
ADD create_mysql_admin_user.sh /create_mysql_admin_user.sh
RUN chmod 755 /*.sh

# Apache Config
RUN ln -s /etc/php5/mods-available/mcrypt.ini /etc/php5/apache2/conf.d/20-mcrypt.ini
ADD apache_default /etc/apache2/sites-available/000-default.conf
RUN a2enmod rewrite

# Setup Storage
RUN mkdir -p /var/www/craft/storage && chown -R www-data /var/www/craft/storage

#Environment variables to configure php
ENV PHP_UPLOAD_MAX_FILESIZE 10M
ENV PHP_POST_MAX_SIZE 10M

# Add Volumes for MySQL 
VOLUME  ["/etc/mysql", "/var/lib/mysql", "/var/www/craft/storage"]

EXPOSE 80 3306
CMD ["/run.sh"]
