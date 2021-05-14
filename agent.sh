#!/usr/bin/sh

# Instructions to connect to the machines where there's the public key of
# the admin under ~/.ssh/authorized_keys:
# From your local computer, inside this repo:
# > ./agent.sh
# > ssh -A ${LOGIN}@${LAB_HOST}
#
# And you'll be in the VM. From there:
# > ssh ubuntu@<floating IP>


# Agent configuration(to be launched on your local computer):
ssh-agent
ssh-add ~/.ssh/id_rsa

echo "Now cat this file and manually execute the following line"
# ssh -A ${LOGIN}@${LAB_HOST}
