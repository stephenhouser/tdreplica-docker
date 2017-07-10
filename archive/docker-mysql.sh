
docker run --name tdreplica-db -e MYSQL_ROOT_PASSWORD=XXXX -d mariadb:10.3

# connect from another container
#$ docker run --name some-app --link some-mysql:mysql -d application-that-uses-mysql

# connect from command line
#$ docker run -it --link some-mysql:mysql --rm mysql sh -c 'exec mysql -h"$MYSQL_PORT_3306_TCP_ADDR" -P"$MYSQL_PORT_3306_TCP_PORT" -uroot -p"$MYSQL_ENV_MYSQL_ROOT_PASSWORD"'


## install plugins
#wp plugin install akismet --allow-root

# Plugins
# Activity Log (https://wordpress.org/plugins/aryo-activity-log/)
wget https://downloads.wordpress.org/plugin/aryo-activity-log.2.3.4.zip

# bbPress (https://wordpress.org/plugins/bbpress/)
wget https://downloads.wordpress.org/plugin/bbpress.2.5.12.zip

# bbPress Enable TinyMCE Visual Tab (https://wordpress.org/plugins/bbpress-enable-tinymce-visual-tab/)
wget https://downloads.wordpress.org/plugin/bbpress-enable-tinymce-visual-tab.zip

# bbPress Pencil Unread (https://wordpress.org/plugins/bbpress-pencil-unread/)
wget https://downloads.wordpress.org/plugin/bbpress-pencil-unread.zip

# BuddyPress (https://wordpress.org/plugins/buddypress/)
wget https://downloads.wordpress.org/plugin/buddypress.2.8.2.zip

# BuddyPress Usernames Only (https://li.wordpress.org/plugins/buddypress-usernames-only/)
wget https://downloads.wordpress.org/plugin/buddypress-usernames-only.0.6.zip

# Custom Admin Bar (https://wordpress.org/plugins/wp-custom-admin-bar/)
wget https://downloads.wordpress.org/plugin/wp-custom-admin-bar.zip

# Enhanced Media Library (https://wordpress.org/plugins/enhanced-media-library/)
wget https://downloads.wordpress.org/plugin/enhanced-media-library.2.4.5.zip

# Fourteen Colors

# GD bbPress Tools (https://wordpress.org/plugins/gd-bbpress-tools/)
wget https://downloads.wordpress.org/plugin/gd-bbpress-tools.zip

# Hide Admin Bar Search (https://wordpress.org/plugins/hide-admin-bar-search/)
wget https://downloads.wordpress.org/plugin/hide-admin-bar-search.zip

# rtMedia for WordPress, BuddyPress and bbPress (https://wordpress.org/plugins/buddypress-media/)
wget https://downloads.wordpress.org/plugin/buddypress-media.4.4.zip

# Simple IP Ban (https://wordpress.org/plugins/simple-ip-ban/)
wget https://downloads.wordpress.org/plugin/simple-ip-ban.1.3.0.zip

# Sitewide Message (https://wordpress.org/plugins/sitewide-message/)
https://downloads.wordpress.org/plugin/sitewide-message.0.6.zip

# Tapatalk for WordPress (https://wordpress.org/plugins/tapatalk/)
#wget https://downloads.wordpress.org/plugin/tapatalk.zip

# TinyMCE Advanced (https://wordpress.org/plugins/tinymce-advanced/)
wget https://downloads.wordpress.org/plugin/tinymce-advanced.4.6.3.zip

# WangGuard (https://wordpress.org/plugins/wangguard/)
wget https://downloads.wordpress.org/plugin/wangguard.1.7.3.zip

# WP Super Cache (https://wordpress.org/plugins/wp-super-cache/)
wget https://downloads.wordpress.org/plugin/wp-super-cache.1.4.9.zip

# Inline Image Upload for bbPress (https://wordpress.org/plugins/image-upload-for-bbpress/)
#wget https://wordpress.org/plugins/image-upload-for-bbpress/