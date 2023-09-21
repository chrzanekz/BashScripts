#!/bin/bash
docker container exec mysqlbackups ./backup.sh
cd /var/www/html/software/
git pull
docker container exec php composer update
docker container exec php ./vendor/bin/phinx migrate
