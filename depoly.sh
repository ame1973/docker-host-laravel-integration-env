#!/bin/bash

cp docker-compose.example docker-compose.yml

sed -i "s/YOUR_PROJECT_NAME/$1/g" docker-compose.yml
sed -i "s/YOUR_PROJECT_DOMAIN.com/$2/g" docker-compose.yml

sed -i "s/YOUR_PROJECT_DOMAIN.com/$2/g" docker-compose.yml

cp ./src/.env.example ./src/.env
sed -i "s/DB_HOST=.*/DB_HOST=mysql/g" ./src/.env
sed -i "s/DB_PASSWORD=.*/DB_PASSWORD=password/g" ./src/.env
sed -i "s/APP_NAME=.*/APP_NAME=$1/g" ./src/.env
sed -i "s/APP_ENV=.*/APP_ENV=production/g" ./src/.env
sed -i "s/APP_URL=.*/APP_URL=https:\/\/$2/g" ./src/.env
