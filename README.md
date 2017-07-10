# TDReplica Container

Docker-compose project and tools for TD Replica website. 

Playbook scripts are in `tools` (see below).

buddy-bbpress-starter need to be 'built' and the image available before this
will work.

## Tools

* create.sh: creates and starts up the `mariadb` and `wordpress` containers. 
Imports data in the `data` directory.
* export.sh: exports the current database to the `data` directory.
* stop.sh: stops the `mariadb` and `wordpress` containers.
* destroy.sh: stop and remove the `mariadb` and `wordpress` containers.

## `webwiz` and `uploads`

These directories are the data files for user uploads and old WebWiz images that
are used by the wordpress container. They are (should be) persistent across
containers.

## TDr-theme
Checked out version of TDr-theme for WordPress/BuddyPress/bbpress.

NOTE: Currently the docker-compose project uses this directory directly. 
The alternative is to check it out from github when building the image.

## buddy-bbpress-starter
Checked out version of docker container configuration for creating a
WordPress instance with BuddyPress and bbPress already installed.

Use `build.sh` inside the `php7.0` directory to create the local docker image.
After that, you can then use the outer docker-compose.yml to fire things up.
