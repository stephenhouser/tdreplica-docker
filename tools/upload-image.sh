#!/usr/bin/env bash

curl -iv -X POST \
	-F "action=wp_handle_upload" \
	-F "mode=file_upload" \
	-F "rt_media_upload_nonce=f1de52009c" \
	-F "title=facepalm" \
	-F "FILES[]=@facepalm.jpg" \
 	http://localhost:8080/members/tdreplica/upload/

#	-F "mode=link_input" \
#	-F "link_input=http://localhost:8080/webwiz/uploads/28857/IMG_5196.png" \
