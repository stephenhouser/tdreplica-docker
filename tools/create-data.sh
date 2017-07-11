#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source ${DIR}/../.env

## Copy WebWiz image files to webwiz volume
echo "Copying data to ${COMPOSE_PROJECT_NAME}_webwiz volume..."
docker run -v ${COMPOSE_PROJECT_NAME}_webwiz:/webwiz --name helper busybox true
docker cp ../tdreplica.com/webwiz/ helper:/
docker rm helper

## Copy user data/uploads to uploads volume
echo "Copying data to ${COMPOSE_PROJECT_NAME}_uploads volume..."
docker run -v ${COMPOSE_PROJECT_NAME}_uploads:/uploads --name helper busybox true
docker cp ../tdreplica.com/wp-content/uploads/ helper:/
docker rm helper
