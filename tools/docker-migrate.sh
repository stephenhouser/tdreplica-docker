#!/bin/bash

# Run on container after migreated to docker

# Change theme
#wp --allow-root theme activate TDr
docker exec -it tdreplica_mariadb_1 mysql -p wordpress <<EOF
insert into wp_options(option_name, option_value, autoload)
	select 'theme_mods_tdreplica', option_value, autoload 
	  from wp_options 
	 where option_name='theme_mods_tdr.theme';

select option_name from wp_options where option_name like 'theme_mods%';
EOF

docker exec -it tdreplica_mariadb_1 mysql -p wordpress <<EOF
insert into wp_options(option_name, option_value, autoload)
	select 'theme_mods_tdreplica', option_value, autoload 
	  from wp_options 
	 where option_name='theme_mods_twentyfourteen';

select option_name from wp_options where option_name like 'theme_mods%';
EOF

primary color : #8b0000
secondary color: #014225
set header image: 

# Remove old webwiz passwords and data
mysql -p wordpress
	delete from wp_usermeta where 