#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source ${DIR}/../.env

prefix=tdreplica
volumes="db webwiz uploads"

for vol in ${volumes}
do
	docker volume rm ${COMPOSE_PROJECT_NAME}_${vol}
done
