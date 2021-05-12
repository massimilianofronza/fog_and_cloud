#!/usr/bin/sh

# Agent configuration(to be launched on your local computer):
ssh-agent
ssh-add ~/.ssh/id_rsa
ssh -A ${LOGIN}@${LAB_HOST}
