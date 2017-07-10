#!/bin/perl

$old_host="http://tdreplica.com";
$new_host="http://draft.tdreplica.com";

# Look for
# Serialized versions
# s:65:\"http://tdreplica.com/wp-content/uploads/cropped-flickr-banner.jpg\";
#
# Look for http://tdreplica.com replace with http://draft.tdreplica.com

while(<>){
	while ( /s:(\d+):\\"$old_host(.*?)\\";/ ) {
		$old_url = $old_host . $2;
		$new_url = $new_host . $2;
		$new_len = length($new_url);
		$_ =~ s/s:$1:\\"$old_url\\";/s:$new_len:\\"$new_url\\";/g;
		#print("s:$new_len:$new_url\n")
	} 

	if ( /$old_host/ ) {
		$_ =~ s/$old_host/$new_host/g
	}
		

	print $_;
}
