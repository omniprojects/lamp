#!/bin/bash

echo "=> Recursively owning craft folders..."
chown -R www-data /var/www/craft/config
chown -R www-data /var/www/craft/storage