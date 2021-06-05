import time
import ampache
import requests
import random
import json
from xml.etree import ElementTree as ET

# Admin variables
ampache_url = "http://172.24.4.51/site"

# Admin name and API key
admin = "admin"
admin_api = "97b38cb216d93087a3d8f966330ea094"
update = 0
user_count = 0
max_users = 10

while True:
    # Login
    encrypted_key = ampache.encrypt_string(admin_api, admin)
    ampache_session = ampache.handshake(ampache_url, encrypted_key)
    if ampache_session:
        print("ADMIN: Connection established!")
    else:
        print("ADMIN: Troubles in connecting to server!")

    if ampache_session:
        # Rename users
        print(f"ADMIN: I'm gonna update someone.")
        ampache.user_update(ampache_url, ampache_session, f'user{user_count}', fullname = f'update{update}-user{user_count}')
        print(f"ADMIN: Updating user{user_count}!")
        user_count += 1
        
        if user_count == 10:
            user_count = 0
            if update < 10000:
                update += 1
            else:
                update = 0

    gb = ampache.goodbye(ampache_url, ampache_session)
    print(f"ADMIN: Closing the connection...\n")

    time.sleep(random.randint(5, 15))
