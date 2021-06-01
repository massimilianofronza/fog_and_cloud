import time
import ampache
import requests
from xml.etree import ElementTree as ET

#https://ampache.org/api/
#https://github.com/ampache/python3-ampache/blob/master/run_tests.py

# user variables
ampache_url = 'http://172.24.4.81'
my_api_key = '7a4ad40f5fca1b59d267e39e18f89560'
user = 'admin'

# processed details
encrypted_key = ampache.encrypt_string(my_api_key, user)
ampache_session = ampache.handshake(ampache_url, encrypted_key)

# 1. Try to get all the songs 
url = "http://172.24.4.81/server/xml.server.php?action=songs&auth=96bb645ad48ca3f586e9d0c958a5832e"

if ampache_session:
	response = requests.get(url)

# 2. Try to get the songs but without authentication
url = "http://172.24.4.81/server/xml.server.php?action=songs"
trial = requests.get(url)

# 3. Try to ping
my_ping = ampache.ping(ampache_url, ampache_session)

# 4. Create user, then delete it 
create_user = ampache.user_create(ampache_url, ampache_session, 'command_line_u', 'pass', 'cmdlu@email.com', False, False)
ampache.user_delete(ampache_url, ampache_session, 'command_line_u')

# 5. From the song requests, understand where can the songs be accessed
song_url = "http://172.24.4.81/play/index.php?ssid=96bb645ad48ca3f586e9d0c958a5832e&type=song&oid=1&uid=1&player=api&name=Komiku%20-%20Balance.mp3"
url_to_song = ampache.url_to_song(ampache_url, ampache_session, song_url)

stream(id, type, destination, api_format = 'xml')
streaming = ampache.stream(ampache_url, ampache_session, '1', 'song', '/home/georgiana.bud/streaming.mp3') 