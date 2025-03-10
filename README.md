перед запуском контейнеров создаем .env файл

```
APP_NAME=b2b-form-container
MYSQL_ROOT_PASSWORD=rootpass
MYSQL_DATABASE=database
MYSQL_USER=testuser
MYSQL_PASSWORD=testpassword
GID=1000 # не менять, нужно для того, что бы битрикс мог писать в папку с контейнером
UID=1000 # не менять, нужно для того, что бы битрикс мог писать в папку с контейнером
```


для переключений версий php в контейнере в файле nginx/default.conf раскоментировать/закоментировать строки в nginx/default.conf

```
location ~ \.php$ {
    fastcgi_split_path_info ^(.+\.php)(/.+)$;
    # fastcgi_pass ${APP_NAME}_php:9000;
    fastcgi_pass ${APP_NAME}_83php:9023; # нужно полностью куказать название контейнера и порт
    fastcgi_index index.php;
    include fastcgi_params;
    fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
    fastcgi_param PATH_INFO $fastcgi_path_info;
}
```

сам сайт находится в папке ./home/bitrix, путь до него так же можно поменять в nginx/default.conf

```
server {
    listen 80;
    root /home/bitrix/название-папки-с-сайтом;
    index index.php;
```

если в сборке у контейнеров поменяли порты, то нужно так же их прописать в конфиге nginx и www

1) php/81/www.conf
2) php/83/www.conf

```
# php/81/www.conf пример
listen = 0.0.0.0:9000
```

при разворачивании бекапа сайта стандартными средства битрикс в строке сервер БД указать название сервиса БД, т.е. mariadb а так же данные из .env файла

запуск контейнеров

```bash
docker-compose up -d --build
```

