#!/bin/bash

echo "=> Recursively owning craft folders..."
chown -R www-data /var/www/craft

echo "=> Creating craft database..."
echo "CREATE DATABASE craft DEFAULT CHARACTER SET utf8 DEFAULT COLLATE utf8_unicode_ci" | mysql -u root

echo "=> Bootstrapping craft database..."
echo mysql -u root craft < /var/www/craft/config/bootsrap.sql