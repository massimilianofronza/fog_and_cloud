import time
import ampache
import requests
import random
import json
import os.path
from os import path
from xml.etree import ElementTree as ET

# Server variables
ampache_url = 'http://172.24.4.51/site'

urls = [
	'http://172.24.4.87',
	'http://172.24.4.198'
]

# Users and their API keys
users = {
	'admin' : '97b38cb216d93087a3d8f966330ea094',
	'georgi' : '191f108d69dacce4bd3b2fdcd9246d95',
	'mass' : 'b0d5f4168caf5160a0cdecc7ce03b1e4',
	'random' : 'c5c3ec286d4ef31243e4d780c1ff2bb2', 
	'eval' : '10f2f5515527dc3398bf300a4b67563a'
}

while True: 
	user, api_key = random.choice(list(users.items()))
	#print(user); print(api_key)
	encrypted_key = ampache.encrypt_string(api_key, user)
	ampache_session = ampache.handshake(ampache_url, encrypted_key)
	if ampache_session:
		print(f"USER-{user}: Connection established!")
	else: 
		print(f"USER-{user}: Troubles in connecting to server!")

	# Request the list of all songs
	url = random.choice(list(urls))
	songs_url = f'{ampache_url}/server/json.server.php?action=songs&auth={ampache_session}'
	response = requests.get(songs_url)
	content = response.json()
	time.sleep(1)

	# Get a random song 
	n = len(content)
	i = random.randint(0, n-1)
	chosen = content[i]
	song_id = chosen['id']
	song_title = chosen['title']
	print(f"USER-{user}: I am thinking of listening to {song_title}")
	
	song_path = f'/media/downloaded/{user}-{song_title}.mp3'
	if path.exists(song_path):
		song_path = '/dev/null'

	prob = random.randint(1,10)
	if prob >= 7:
		print(f"USER-{user}: I will listen to it!")
		listen_to = ampache.stream(url, ampache_session, song_id, 'song', song_path)
		time.sleep(5)
	else: 
		print(f"USER-{user}: Changed my mind...")
		time.sleep(2)
		
	my_ping = ampache.ping(ampache_url, ampache_session)
	
	gb = ampache.goodbye(ampache_url, ampache_session)
	
	time.sleep(random.randint(10,20))