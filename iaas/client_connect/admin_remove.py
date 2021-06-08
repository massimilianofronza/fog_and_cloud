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
max_users = 10

# Login
encrypted_key = ampache.encrypt_string(admin_api, admin)
ampache_session = ampache.handshake(ampache_url, encrypted_key)
if ampache_session:
    print("ADMIN: Connection established!")
else:
    print("ADMIN: Troubles in connecting to server!")

# Deleting users
print(f"ADMIN: Deleting all users!")
for i in range(max_users):
    ampache.user_delete(ampache_url, ampache_session, f'user{i}')

print(f"ADMIN: Closing the connection...\n")
gb = ampache.goodbye(ampache_url, ampache_session)