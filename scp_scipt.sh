#!/bin/bash
#package backup database
tar cfzv backup_`date +%d-%m-%y`.tar.gz /var/www/html/simplyripok-v1.5/docker/mysql/backup
#copy to another machine through ssh
scp backup_`date +%d-%m-%y`.tar.gz roger@192.168.0.176:C:/Users/Roger/Backup_easyripok/backup_`date +%d-%m-%y`.tar.gz
