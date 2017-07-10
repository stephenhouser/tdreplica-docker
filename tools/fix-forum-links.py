import sys
import re
import getopt
import MySQLdb
from hashlib import sha512

#		 Either 
#			>http://www.tdreplica/forum2/forum_posts.asp?TID=([\d])+(.*)?<
#			"http://www.tdreplica/forum2/forum_posts.asp?TID=([\d])+(.*)?"
#
#		 http://www.tdreplica.com/forum2/forum_posts.asp?TID=3320&title=new-gallery-work-in-progress
#
#		select post_id from wp_postmeta where meta_key = '_bbp_old_topic_id' and meta_value=3320;
#
#		==> 234004
#
#		select post_name,guid from wp_posts where id=234004;
#		
#		==> member-photo-gallery | http://draft.tdreplica.com/forums/topic/member-photo-gallery/
#19987

thread_links = {}       # thread_links[old thread id] = (new post id, new post name, new post url)
bbp_post_id = {}        # bbp_post_id[old post id] = new post_id
bbp_user_id = {}        # bbp_user_id[username] = (old user id, new user id, user nice name)

bbp_user_id['stacks'] = (19987, -1, 'stacks')

def load_user_ids(db):
    global bbp_user_id

    cur = db.cursor()    
    cur.execute(r'select u.user_login, m.meta_value, m.user_id, u.user_nicename from wp_usermeta m, wp_users u where m.user_id = u.id and m.meta_key="_bbp_user_id"')
    for row in cur.fetchall():
        bbp_user_id[row[0].replace(" ", "")] = (row[1], row[2], row[3])
    
    return

def load_thread_links(db):
    global thread_links

    cur = db.cursor()    
    cur.execute(r'select m.meta_value, m.post_id, p.post_name, p.guid from wp_postmeta m, wp_posts p where m.post_id = p.id and m.meta_key = "_bbp_old_topic_id"')
    for row in cur.fetchall():
        thread_links[row[0]] = (row[1], row[2], row[3])

def load_post_ids(db):
    global bbp_post_id

    cur = db.cursor()    
    cur.execute(r'select meta_value, post_id from wp_postmeta where meta_key = "_bbp_post_id"')
    for row in cur.fetchall():
        bbp_post_id[row[0]] = row[1]


def fix_real_old_photos(post_id, post_content):
    content = post_content

    photo_re = re.compile(r'src="/forum/uploads/(.+?)/(.+?)"')
    for match in photo_re.finditer(content):
        user = match.group(1)
        img_src = match.group(2)

        if user in bbp_user_id:
            user_login = bbp_user_id[user][1]
            webwiz_id =  bbp_user_id[user][0]
            repl = r'src="/webwiz/uploads/{}/{}"'.format(webwiz_id, img_src)
            #print('{} --> {} == {}/{} for {}'.format(post_id, user, user_login, webwiz_id, img_src))

            content = photo_re.sub(repl, content, 1)
        else:
            print('{} --> Username {} not found for {}'.format(post_id, user, img_src))


    return content

def print_old_links(post_id, post_content):
    old_re = re.compile(r'<(.*?)tdreplica.com/forum2(.*?)>')
    for match in old_re.finditer(post_content):
        print('{}: {}'.format(post_id, match.group(0)))
    
def fix_photo_links(post_id, post_content):
    return re.sub(r'href="http://(www\.|draft\.)?tdreplica.com/forum2/uploads/', 
                  r'href="/webwiz/uploads/', 
                  post_content)

def fix_old_photos(post_id, post_content):
    return re.sub(r'src="http://(www\.|draft\.)?tdreplica.com/forum2/uploads/', 
                  r'src="/webwiz/uploads/', 
                  post_content)

def fix_smileys(post_id, post_content):
    content = post_content
    content = re.sub(r'src="smileys/', 
                     r'src="/webwiz/smileys/', 
                     content)
    content = re.sub(r'http://(www\.|draft\.)?tdreplica.com/forum2/smileys/', 
                     r'/webwiz/smileys/', 
                     content)
    return content

def fix_forum_images(post_id, post_content):
    content = post_content
    content = re.sub(r'http://(www\.|draft\.)?tdreplica.com/forum2/forum_images/', 
                     r'/webwiz/forum_images/', 
                     content)
    return content

def fix_post_links(post_id, post_content):
    content = post_content
    base_url = 'http://(?:www.|draft.)?tdreplica.com/forum2/forum_posts.asp'
    url_re = re.compile(r'(?<=[>"]){}\?TID=(\d+)(.*?)(#\d+)?(?=[<"])'.format(base_url))
    for match in url_re.finditer(content):
        #print('FIX POST {} --> {}'.format(post_id,match.group(0)))
        tid = match.group(1)

        if tid in thread_links:
            repl = thread_links[tid][2]
            if match.group(3):
                pid = match.group(3)[1:]
                if pid in bbp_post_id:
                    repl = repl + '#post-' + str(bbp_post_id[pid])
                #else:
                #    print('\t --> REPLY ID NOT FOUND')

            content = url_re.sub(repl, content, 1)
        else:
            print('{}: Thread ID {} not found.'.format(post_id, tid))

    return content

def usage():
    print("usage:")

def main():
    db = MySQLdb.connect(host="mysql.tdreplica.com",
                         user="tdreplica",
                         passwd="RWFpR-uG",
                         db="tdreplica") 

    load_thread_links(db)
    load_post_ids(db)
    load_user_ids(db)

    cur = db.cursor()    
    cur.execute(r'select id, post_content from wp_posts')
    for post in cur.fetchall():
        post_id = post[0]
        content = post[1]

        content = fix_post_links(post_id, content)
        content = fix_smileys(post_id, content)
        content = fix_old_photos(post_id, content)
        content = fix_real_old_photos(post_id, content)
        content = fix_photo_links(post_id, content)
        content = fix_forum_images(post_id, content)

        print_old_links(post_id, content)

        if sha512(post[1]).digest() != sha512(content).digest():
            print("BEFORE: {}".format(post_id))
            print(post[1])
            print("AFTER: {}".format(post_id))
            print(content)
            print('\n\n\n')

            cur.execute('update wp_posts set post_content=%s where id=%s', (content, post_id))
            db.commit()
            print("Post {} updated.".format(post_id))

    db.close()

if __name__ == "__main__":
    main()