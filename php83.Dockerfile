FROM centos:7
# yum update
ADD http://vault.centos.org/centos/7/os/x86_64/Packages/ca-certificates-2020.2.41-70.0.el7_8.noarch.rpm /tmp/
RUN rpm -Uvh /tmp/ca-certificates-2020.2.41-70.0.el7_8.noarch.rpm --nosignature --force
ADD  http://vault.centos.org/centos/7/os/x86_64/Packages/yum-3.4.3-168.el7.centos.noarch.rpm /tmp/
RUN rpm -Uvh /tmp/yum-3.4.3-168.el7.centos.noarch.rpm --nosignature --force
ADD http://vault.centos.org/centos/7/os/x86_64/Packages/yum-plugin-fastestmirror-1.1.31-54.el7_8.noarch.rpm /tmp/
RUN rpm -Uvh /tmp/yum-plugin-fastestmirror-1.1.31-54.el7_8.noarch.rpm --nosignature --force

RUN sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-*
RUN sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*

# Run yum update
RUN yum update -y

# Install php(remi)
# RUN yum -y install epel-release && \
#     yum -y install http://rpms.remirepo.net/enterprise/remi-release-7.rpm && \
#     yum -y install yum-utils
    

# Включение репозитория PHP 8.3
RUN yum -y install epel-release && \
    yum -y install http://rpms.remirepo.net/enterprise/remi-release-7.rpm && \
    yum-config-manager --enable remi-php83 && \
    yum -y install php php-fpm
# Установка PHP 8.3 и основных расширений
RUN yum -y install php-cli php-common \
    php-fpm \
    php-mysqlnd \
    php-zip \
    php-devel \
    php-gd \
    php-mcrypt \
    php-mbstring \
    php-curl \
    php-xml \
    php-pear \
    php-bcmath \
    php-json

# Настройка PHP-FPM
RUN mkdir -p /run/php-fpm && \
    chmod 755 /run/php-fpm && \
    sed -i 's/listen = 127.0.0.1:9023/listen = 0.0.0.0:9023/g' /etc/php-fpm.d/www.conf && \
    sed -i 's/;listen.allowed_clients = 127.0.0.1/listen.allowed_clients = 0.0.0.0/g' /etc/php-fpm.d/www.conf && \
    sed -i 's/user = apache/user = bitrix/g' /etc/php-fpm.d/www.conf && \
    sed -i 's/group = apache/group = bitrix/g' /etc/php-fpm.d/www.conf

RUN useradd -r bitrix

EXPOSE 9023
CMD ["php-fpm", "-F"]

# CMD ["php-fpm", "-F"]