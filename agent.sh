#!/usr/bin/sh

SCRIPT="/bin/bash"

# Agent configuration(to be launched on your local computer):
ssh-agent
ssh-add ~/.ssh/id_rsa

echo "Now cat this file and manually execute the following line"
# ssh -A ${LOGIN}@${LAB_HOST}
