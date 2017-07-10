#!/bin/bash

prefix=tdreplica
volumes="${prefix}_db ${prefix}_webwiz ${prefix}_uploads"

for vol in ${volumes}
do
	docker volume rm ${vol}
done
