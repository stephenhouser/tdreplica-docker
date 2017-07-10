#!/bin/bash

today=$(date +"%Y%m%dT%H%M")

docker run -it --rm --link my-old-database:mariadb mariadb sh -c 'echo "[client]\n user=root\n password=\"PASSWORD HERE\"" > my.cnf && exec mysqldump --defaults-file=my.cnf --databases wordpress' > tdreplica-${today}.sql