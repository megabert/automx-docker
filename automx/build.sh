#!/bin/bash 

docker kill automx 
docker rm automx   

set -e

docker build -t automx  .
docker run -d --name=automx -p 80:80 -p 443:443 --link config_db:mysql -t automx
