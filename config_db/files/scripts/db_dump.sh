#!/bin/bash

. ./ENV
docker exec -i --env=MYSQL_ROOT_PASSWORD="$MYSQL_ROOT_PASSWORD" -t config_db /usr/local/bin/dump_all_databases
