#!/usr/bin/env bash

WP_VERSION=${WP_VERSION:-latest}
BP_VERSION=${BP_VERSION:-latest}
BB_VERSION=${BB_VERSION:-latest}
#plugins="buddypress-${BP_VERSION} bbpress-${BB_VERSION}"

read -d '' plugins <<EOF
aryo-activity-log.2.3.4
buddypress-usernames-only.0.6
bbpress.2.5.12
enhanced-media-library.2.4.5
bbpress-enable-tinymce-visual-tab.1.0.1
gd-bbpress-tools.1.9
bbpress-pencil-unread.1.3.0
image-upload-for-bbpress.1.1.14
buddypress.2.8.2
tinymce-advanced.4.6.3
buddypress-media.4.4.2
EOF

# Create cache directory
if [ ! -d cache ] 
then
	mkdir cache
fi

# Cache latest version of WordPress
if [ ! -d cache/core ] 
then
	mkdir cache/core
fi
wget -nc -P cache/core https://wordpress.org/wordpress-${WP_VERSION}.zip
wget -nc -P cache/core https://wordpress.org/wordpress-${WP_VERSION}.tar.gz

# Cache plugins we use
if [ ! -d cache/plugin ] 
then
	mkdir cache/plugin
fi

#https://downloads.wordpress.org/plugin/buddypress.2.8.2.zip
#https://downloads.wordpress.org/plugin/buddypress-2.8.2.zip

#wget -nc -P cache/plugin https://downloads.wordpress.org/plugin/buddypress.2.8.2.zip
#wget -nc -P cache/plugin https://downloads.wordpress.org/plugin/bbpress.2.5.12.zip
for plugin in ${plugins}
do
	wget -nc -P cache/plugin https://downloads.wordpress.org/plugin/${plugin}.zip
	# fix name so wp-cli recognizes it.
	nname=$(echo ${plugin} | sed 's/\./-/')
	mv cache/plugin/${plugin}.zip cache/plugin/${nname}.zip
done