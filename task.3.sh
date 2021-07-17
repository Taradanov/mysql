#!/usr/bin/sh
echo 'Начато создание дампа'
mysqldump example > example.sql 
mysql << MYSQL_SCRIPT 
DROP DATABASE IF EXISTS sample; 
CREATE DATABASE sample; 
MYSQL_SCRIPT
mysql sample < example.sql 
echo 'Создание дампа завершено'

