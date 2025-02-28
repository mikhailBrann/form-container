.env файл

```
APP_NAME=containers-name
MYSQL_ROOT_PASSWORD=pass
MYSQL_DATABASE=b2bform
MYSQL_USER=user
MYSQL_PASSWORD=pass
```


для переключений версий php в контейнере в файле nginx/default.conf

раскоментировать/закоментировать строки

```
location ~ \.php$ {
    fastcgi_split_path_info ^(.+\.php)(/.+)$;
    # fastcgi_pass ${APP_NAME}_php:9000;
    fastcgi_pass ${APP_NAME}_83php:9023;
    fastcgi_index index.php;
    include fastcgi_params;
    fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
    fastcgi_param PATH_INFO $fastcgi_path_info;
}
```


