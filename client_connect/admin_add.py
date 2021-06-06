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
parser = argparse.ArgumentParser(description='Configuration for the admin')
parser.add_argument('min_sleep_time', help='Min time to sleep between requests (recommended between 2 and 10 seconds)', type=int)
parser.add_argument('max_sleep_time', help='Max time to sleep between requests (recommended between 5 and 20 seconds)', type=int)

args = parser.parse_args()
min_sleep = args.min_sleep_time
max_sleep = args.max_sleep_time

# Admin variables
ampache_url = "http://172.24.4.51/site"

# Admin name and API key
admin = "admin"
admin_api = "97b38cb216d93087a3d8f966330ea094"
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

    # Decide whether to create a user or change the name of an
    # already existing one:
    prob = random.randint(1, 10)
    if prob > 5:
        print(f"ADMIN: Maybe I'll create a user.")
        
        if user_count == max_users:
            print(f"ADMIN: I've already created {max_users} users!")
        else:
            print(f"ADMIN: Creating the new USER-{user_count}!")
            create_user = ampache.user_create(ampache_url, ampache_session, f"user{user_count}", "pass", f"user{user_count}@email.com", False, False)
            user_count += 1

    gb = ampache.goodbye(ampache_url, ampache_session)
    print(f"ADMIN: Closing the connection...\n")

    time.sleep(random.randint(min_sleep, max_sleep))