# TDReplica Container Scripts

This project contains the `docker-compose` files to create, import, and start the [MG TD Replica Car Club](http://tdreplica.com) website. The website uses [WordPress](http://wordpress.org) and [MariaDB](http://mariadb.com) in addition to several WordPress plugins. Most notably [BuddyPress](http://buddypress.org) and [bbPress](http://bbpress.org)

# Requirements

* [buddy-bbpress-starter](https://github.com/stephenhouser/buddy-bbpress-starter) needs to be 'built' and the image available before any of this
will work.

* [tdreplica-theme](https://github.com/stephenhouser/tdreplica-theme) is used as the WordPress theme. The current `master` branch is pulled at creation time. NOTE: `wp-cli` does some funny stuff with directory names when pulling from tagged versions of GitHub repositories. That means, things won't work correctly if you specify a tag and not master!

* `.env` file with `DB_PASSWORD=` must also exist. This is MariaDB's root password. It is used by the WordPress install to create tables and access the data. It is never checked in to git!

## Playbook

* Startup: `docker-compose up` (creates and starts up the `mariadb` and `wordpress` containers. Imports SQL data in the `data` directory).

* Shutdown: `docker-compose stop` (stops the `mariadb` and `wordpress` containers).

* Destroy: `docker-compose stop; docker-compose rm` (stop and remove the `mariadb` and `wordpress` containers. Does *not* destroy data volumes)

* Export MariaDB Data: `export.sh` exports the current database to the `data` directory.

* Destroy Data: `docker volume rm tdreplica_database tdreplica_webwiz tdreplica_uploads`

Additional playbook scripts are in `tools` (see below).

# Directories

* `data`: Location for SQL to be imported at creation time by MariaDB container.

* `webwiz`: Images from old WebWiz forum used by the WordPress container. Maps to `/webwiz` inside container's web directory. This folder contains WebWiz files along with un-migrated user images posted to the original WebWiz forums. By 'un-migrated' I mean not migrated into the WordPress rtMedia folder content in `uploads`.

* `uploads`: WordPress user uploads directory. Maps to `.../wp-content/uploads` in WordPress container. This should be persistent across containers. It is user submitted content and should not be lost!

## tdreplica-theme
Checked out version of TDr-theme for WordPress/BuddyPress/bbpress.

NOTE: Currently the docker-compose project uses this directory directly. 
The alternative is to check it out from github when building the image.

## buddy-bbpress-starter
Checked out version of docker container configuration for creating a
WordPress instance with BuddyPress and bbPress already installed.

Use `build.sh` inside the `php7.0` directory to create the local docker image.
After that, you can then use the outer docker-compose.yml to fire things up.
