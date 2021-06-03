import time
#import ampache
import requests
import random
import json
from xml.etree import ElementTree as ET

# Admin variables
ampache_url = 'http://172.24.4.51/site'
url1 = 'http://172.24.4.87'
url2 = 'http://172.24.4.198'

admin = 'admin'
admin_api = '97b38cb216d93087a3d8f966330ea094'
user_count = 0

while True:
    # Login
    encrypted_key = ampache.encrypt_string(admin_api, admin)
    ampache_session = ampache.handshake(ampache_url, encrypted_key)
    if ampache_session:
        print("ADMIN: Connection established!")
    else:
        print("ADMIN: Troubles in connecting to server!")
    
    # Decide whether to create a user or change the name of an
    # already exsisting one:
    prob = random.randint(1, 10)
    if prob > 5:
        create_user = ampache.user_create(ampache_url, ampache_session, f'user{user_count++}', 'pass', 'cmdlu@email.com', False, False)

    sleep(random.randint(4, 10))