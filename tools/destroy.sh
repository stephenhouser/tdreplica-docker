#!/bin/bash

docker-compose stop
docker-compose rm -f
docker volume rm tdreplica_database