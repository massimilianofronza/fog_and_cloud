# Available storage:
> df -h
# And memory:
> free -h

# To build this Dockerfile:
> docker build -t <i_name> .
-t	Tag, used to set the name of the new image
.	Position of the current file

# If something goes wrong, you can remove the cached data:
> docker builder prune

# After installation, run:
> docker run -it <i_name>

# If a container is running, check its status:
> docker logs -f <c_name>
-f	To follow the continuous output log
