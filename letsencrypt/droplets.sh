#!/bin/bash
# set -x

# create servers in DigitalOcean
# https://docs.docker.com/machine/drivers/digital-ocean/

#
# DO_TOKEN should be replaced with your personal token from digitalocean.com (read/write)
DO_TOKEN=6f0d19dd4054d677a1c155aef0d90e6ea8b37f4bec831e83f1b4299b36b86e1f

#
# DO_SIZE defines droplet size
# Choose a size using DigitalOcean CLI command: doctl compute size list
# https://www.digitalocean.com/community/tutorials/how-to-use-doctl-the-official-digitalocean-command-line-client
# If you do not define it, you will get the default size
DO_SIZE=s-1vcpu-1gb

#for server in {1..3}; do
server="01"
docker-machine create \
  --driver=digitalocean \
  --digitalocean-access-token="${DO_TOKEN}" \
  --digitalocean-size="${DO_SIZE}" \
  --digitalocean-tags=traefik \
  --digitalocean-private-networking=true \
  do${server} &
#done

