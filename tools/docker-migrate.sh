#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source ${DIR}/../.env

# Run on container after migreated to docker

#docker exec -it tdreplica_mariadb_1 mysql -p wordpress <<EOF
#insert into wp_options(option_name, option_value, autoload)
#	select 'theme_mods_tdreplica', option_value, autoload 
#	  from wp_options 
#	 where option_name='theme_mods_tdr.theme';
#
#select option_name from wp_options where option_name like 'theme_mods%';
#EOF

# Remove old WebWiz migration data (passwords)
docker exec -i ${COMPOSE_PROJECT_NAME}_mariadb_1 mysql --password=${DB_PASSWORD} wordpress <<EOF
create table webwiz_usermeta as
	select * from wp_usermeta where meta_key like '_bbp_%';

delete from wp_usermeta where meta_key like '_bbp_%';
EOF

# Copy header image into tdreplica-theme from twentyfourteen
#docker exec -i ${COMPOSE_PROJECT_NAME}_mariadb_1 mysql --password=${DB_PASSWORD}  wordpress <<EOF
#insert into wp_options(option_name, option_value, autoload)
#	select 'theme_mods_tdreplica-wptheme', option_value, autoload 
#	  from wp_options 
#	 where option_name='theme_mods_twentyfourteen';
#
#select option_name from wp_options where option_name like 'theme_mods%';
#EOF

# Change theme
docker exec -it ${COMPOSE_PROJECT_NAME}_wordpress_1 wp --allow-root theme activate tdreplica-wptheme

docker exec -it ${COMPOSE_PROJECT_NAME}_wordpress_1 wp --allow-root theme list

#primary color : #8b0000
#secondary color: #014225
#set header image: 

