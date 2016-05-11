#!/bin/bash

echo "=> Updating folder ownership..."
chown -R www-data /var/www/craft/storage
chown -R www-data /var/www/craft/plugins

echo "=> Creating craft database..."
echo "CREATE DATABASE craft DEFAULT CHARACTER SET utf8 DEFAULT COLLATE utf8_unicode_ci" | mysql -u root

echo "=> Bootstrapping craft database..."
mysql -u root craft < /var/www/craft/config/bootstrap.sql