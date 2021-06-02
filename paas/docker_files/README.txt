# Available storage:
> df -h
# And memory:
> free -h

# To build this Dockerfile:
> docker build -t <name> .
-t	Tag, used to set the name of the new image
.	Position of the current file

# If something goes wrong, you can remove the cached data:
> docker builder prune

# After installation, run:
> docker run -it <name>
