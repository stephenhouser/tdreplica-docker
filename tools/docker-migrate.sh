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
# Done in live database 2017-08-17
#docker exec -i ${COMPOSE_PROJECT_NAME}_mariadb_1 mysql --password=$#{DB_PASSWORD} wordpress <<EOF
#create table webwiz_usermeta as
#	select * from wp_usermeta where meta_key like '_bbp_%';
#
#delete from wp_usermeta where meta_key like '_bbp_%';
#EOF

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

#
# Image migration
# wp_usermeta contains
#| umeta_id | user_id | meta_key                   | meta_value     
#+----------+---------+----------------------------+----------------
#|   104828 |     519 | _bbp_user_id               | 28857
# Which tells us that the old userid 28857 translates to the new userid 519.
# Images are thus...
# ./webwiz/uploads/28857
# ./wp-content/uploads/rtMedia/users/519

# rtMedia tables
#wp_rt_rtm_activity          |
#| wp_rt_rtm_api               |
#| wp_rt_rtm_media             |
#| wp_rt_rtm_media_interaction |
#| wp_rt_rtm_media_meta
##
#
#
#wordpress_1  | 172.18.0.1 - - [11/Jul/2017:20:19:32 +0000] "POST /members/tdreplica/upload/ HTTP/1.1" 200 622 "http://localhost:8080/members/tdreplica/media/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.115 Safari/537.36"
#
#wordpress_1  | 172.18.0.1 - - [11/Jul/2017:20:19:32 +0000] "POST /wp-admin/admin-ajax.php?action=rtmedia_get_template&template=media-gallery-item HTTP/1.1" 200 666 "http://localhost:8080/members/tdreplica/media/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.115 Safari/537.36"
#wordpress_1  | 172.18.0.1 - - [11/Jul/2017:20:19:32 +0000] "GET /members/tdreplica/media/?json=true&rtmedia_page=1&is_up_shortcode=&context=bp_member&mode=file_upload HTTP/1.1" 200 1131 "http://localhost:8080/members/tdreplica/media/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.115 Safari/537.36"
#wordpress_1  | 172.18.0.1 - - [11/Jul/2017:20:19:32 +0000] "GET /wp-content/uploads/rtMedia/users/1/StephenHouser-Avatar-150x150.jpg HTTP/1.1" 200 6186 "http://localhost:8080/members/tdreplica/media/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.115 Safari/537.36"
#
#
#select * from wp_rt_rtm_media where media_author=519;
#| id  | blog_id | media_id | media_author | media_title                  | album_id | #media_type | context | context_id | source | source_id | activity_id | cover_art | #privacy | views | downloads | ratings_total | ratings_count | ratings_average | likes | #dislikes | upload_date         | file_size |
# 546 |       1 |   303747 |          519 | IMG_9881                     |        1 | photo      | profile |        519 | NULL   |      NULL |       35981 | NULL      |       0 |     0 |         0 |             0 |             0 | 0.00            |     0 |        0 | 2017-07-10 20:31:20 |   1879938 |