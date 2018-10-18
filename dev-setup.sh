#!/usr/bin/env bash

# clean up current situation
docker-compose down -v

# rebuild containers
docker-compose build

# populate public directory and nginx directory
docker run --rm -it -v djangodroidstore_public:/public -v $(pwd):/backup busybox tar -C /public -xf /backup/public.tar
docker run --rm -it -v djangodroidstore_nginx:/nginx -v $(pwd):/backup busybox cp /backup/nginx/droidstore.conf /nginx

# collectstatic
docker-compose run --rm web python manage.py collectstatic --noinput

# create database
docker-compose run --rm web python manage.py migrate # --fake-initial

# load fixtures
docker-compose run --rm web python manage.py loaddata initial_data.json
