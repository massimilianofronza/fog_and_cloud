import time
import ampache
import requests
import random
from xml.etree import ElementTree as ET

#https://ampache.org/api/
#https://github.com/ampache/python3-ampache/blob/master/run_tests.py

# user variables
ampache_url = 'http://172.24.4.51/site'
url1 = 'http://172.24.4.87'
url2 = 'http://172.24.4.198'

admin = 'admin'
admin_api = '97b38cb216d93087a3d8f966330ea094'

georgi = 'georgi'
georgi_api = '191f108d69dacce4bd3b2fdcd9246d95'

random = 'random'
random_api = 'c5c3ec286d4ef31243e4d780c1ff2bb2'

eval = 'eval'
eval_api = '10f2f5515527dc3398bf300a4b67563a'

# processed details
encrypted_key = ampache.encrypt_string(admin_api, admin)
ampache_session = ampache.handshake(ampache_url, encrypted_key)

# 1. Try to get all the songs 
url = f'{url1}/server/json.server.php?action=songs&auth={ampache_session}'

if ampache_session:
	response = requests.get(url)

# 2. Try to ping
my_ping = ampache.ping(ampache_url, ampache_session)

# 3. Create user, then delete it 
create_user = ampache.user_create(ampache_url, ampache_session, 'command_line_u', 'pass', 'cmdlu@email.com', False, False)
ampache.user_delete(ampache_url, ampache_session, 'command_line_u')

# 4. Update a user on either one or the other server
ampache.user_update(ampache_url, ampache_session, 'random', fullname = 'Georgiana')

# 5. Stream a song with an id; requires server url (so url1 or url2)
stream(id, type, destination, api_format = 'xml')
streaming = ampache.stream(url2, ampache_session, '1', 'song', '/home/georgiana.bud/random.mp3') 

# 6. 'goodbye' destroys the session
gb = ampache.goodbye(ampache_url, ampache_session)

# 7. Some automatization e.g. for user insertion/update/deletion
i = 0
choices = [
 'create',
 'update',
 'delete'
]
while true:
	# do some actions
	choice = random.random(0,2)
	if choice == 0: #user create
		create_user = ampache.user_create(ampache_url, ampache_session, f'user{i++}', 'pass', f'user{i}@email.com', False, False)
	if choice == 1: #user update
		ampache.user_update(ampache_url, ampache_session, 'random', fullname = 'Georgiana')
	if choice == 2: #user delete
		ampache.user_delete(ampache_url, ampache_session, f'user{i}')
	sleep(5)
	