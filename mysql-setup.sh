#!/bin/bash

echo "=> Creating craft database..."
echo 'CREATE DATABASE craft DEFAULT CHARACTER SET utf8 DEFAULT COLLATE utf8_general_c' | mysql -u root