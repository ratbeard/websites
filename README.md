COOL!

# Docker notes

Basing off passenger-full image, which contains:

- nodejs, ruby, python, nginx, memcache, redis
- runit and a legit init script
- stripped down core, 10mb memory

https://github.com/phusion/passenger-docker

Basic workflow:

- make change to Dockerfile (preferribly towards the bottom so it caches correctly)
- docker build -t ratbeard/dreams .
- docker run -p 8080:80 ratbeard/dreams
- see if it works.  if not, debug via:
- docker ps -notrunc
- sudo lxc-attach -n <container id>

To run it in production (as a daemon):

		docker run -p 8080:80 ratbeard/dreams

You can include the 8080:80 as part of the EXPOSE command for convenience,
though this seems to be frowned upon.  Passenger docker also allows ssh
access, but its more complicated than lxc-attach it seems.


