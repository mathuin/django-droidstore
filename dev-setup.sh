#!/usr/bin/env bash
set -ex

# clean up current situation
docker-compose down -v

# rebuild containers
docker-compose build

# momentarily spin up web to create containers
docker-compose run --rm --no-deps --entrypoint=/bin/true web true

# populate public directory and nginx directory and development SSL directory
docker run --rm -it -v django-droidstore_public:/public -v $(pwd):/backup busybox tar -C /public -xf /backup/public.tar
docker run --rm -it -v django-droidstore_nginx:/nginx -v $(pwd):/backup busybox cp /backup/nginx/droidstore.conf /nginx
docker run --rm -it -v django-droidstore_devssl:/devssl -v $(pwd):/backup busybox tar -C /devssl -xf /backup/devssl.tar

# collectstatic
docker-compose run --rm web python manage.py collectstatic --noinput

# create database
docker-compose run --rm web python manage.py migrate # --fake-initial

# output logs if error
if [[ $? == 1 ]]; then
  docker logs django-droidstore-db-1
fi

# load fixtures
docker-compose run --rm web python manage.py loaddata initial_data.json
