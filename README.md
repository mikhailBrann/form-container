rpm -Uvh http://vault.centos.org/centos/7/os/x86_64/Packages/ca-certificates-2020.2.41-70.0.el7_8.noarch.rpm --nosignature
rpm -Uvh http://vault.centos.org/centos/7/os/x86_64/Packages/yum-3.4.3-168.el7.centos.noarch.rpm --nosignature
rpm -Uvh http://vault.centos.org/centos/7/os/x86_64/Packages/yum-plugin-fastestmirror-1.1.31-54.el7_8.noarch.rpm --nosignature


sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-*
sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*

yum clean all

