import time
import ampache
import requests
import random
import json
import os.path
from os import path
import argparse #used to take parameters from command line
from xml.etree import ElementTree as ET

# Arguments
parser = argparse.ArgumentParser(description='Configuration for the users')
parser.add_argument('min_sleep_time', help='Min time to sleep between requests (recommended between 2 and 10 seconds)', type=int)
parser.add_argument('max_sleep_time', help='Max time to sleep between requests (recommended between 5 and 20 seconds)', type=int)
parser.add_argument('probability_listen', help='Probability in terms of p/10 of listening to a song', type=int)

args = parser.parse_args()
min_sleep = args.min_sleep_time
max_sleep = args.max_sleep_time
prob_listen = args.probability_listen

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
	'eval' : '10f2f5515527dc3398bf300a4b67563a',
	'user0' : 'a31730e6f3946ed7097cee2b94226ad3', 
	'user1' : '6ad9375e5da1b312cb9771bdfa2cb8c5', 
	'user2' : '5c57c3926ad81491ec0e2afaf29939f1', 
	'user3' : 'b94e22c98ed847c49bf6bf86a6efcb76', 
	'user4' : '65f10316ff6671e2c5883eaa6493adf8', 
	'user5' : '2d678332cb76822d6be9f6b39d2b399e', 
	'user6' : 'fafa08f733df7846dbdb1d191da8c0fa', 
	'user7' : '7fbaad7af0a11d080aa92e264df48a2b', 
	'user8' : '57989a80288126e7683b1f01a226fddc', 
	'user9' : '4ab92f21d4fa36ab181b880a3c54ca07'
}

time.sleep(random.randint(1,4)) # so that not all start at the same time
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
	time.sleep(1)
	
	#these are the users for which we want to simulate high activity, but not save the songs
	song_path = '/dev/null'

	num = random.randint(1,10)
	if num < prob_listen:   # prob_listen passed as parameter
		print(f"USER-{user}: I will listen to it!")
		listen_to = ampache.stream(url, ampache_session, song_id, 'song', song_path)
		time.sleep(5)
	else: 
		print(f"USER-{user}: Changed my mind...")
		time.sleep(2)
	
	# Just to let the server know you are still there
	my_ping = ampache.ping(ampache_url, ampache_session)
	
	gb = ampache.goodbye(ampache_url, ampache_session)
	
	time.sleep(random.randint(min_sleep, max_sleep))