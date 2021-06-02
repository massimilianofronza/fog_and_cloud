# Dockerfile used to generate the user instances that will 
# interact with the Ampache servers through python

FROM ubuntu

RUN apt-get update
RUN apt install -y apt-utils
RUN apt-get install -y iputils-ping
RUN apt-get install -y nano
RUN apt-get install -y curl
RUN apt install -y python3-pip
RUN pip3 install -U ampache
RUN pip3 install requests
