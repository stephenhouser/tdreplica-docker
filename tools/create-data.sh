#!/bin/bash

## Copy WebWiz image files to webwiz volume
echo "Copying data to webwiz volume..."
docker run -v tdreplica_webwiz:/webwiz --name helper busybox true
docker cp ../tdreplica.com/webwiz/ helper:/
docker rm helper

## Copy user data/uploads to uploads volume
echo "Copying data to uploads volume..."
docker run -v tdreplica_uploads:/uploads --name helper busybox true
docker cp ../tdreplica.com/wp-content/uploads/ helper:/
docker rm helper