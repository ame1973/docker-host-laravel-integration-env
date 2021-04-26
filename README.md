# Docker host Laravel

**php:7.4-fpm**


## host project

change this project folder name to your own project name.

clone your laravel project to **./src**

**change docker-compose.yml**

- "traefik.http.routers.YOUR_PROJECT.rule=Host(`YOUR_PROJECT_DOMAIN.com`)"
- "traefik.http.routers.YOUR_PROJECT.entrypoints=websecure"

```
docker-compose up -d
```

## mysql

DATABASE: laravel
USER: root
PASSWORD: password

## Reset

remove images
rm -rf volumes

## config Laravel

`composer` and `php artisan` command need go to php containers shell run.