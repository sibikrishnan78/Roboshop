echo -e "\e[35m>>>>>>>>>enable redis<<<<<<<<<<\e[0m"
dnf install https://rpms.remirepo.net/enterprise/remi-release-8.rpm -y
dnf module enable redis:remi-6.2 -y
echo -e "\e[35m>>>>>>>>>install redis<<<<<<<<<<\e[0m"
dnf install redis -y
sed -i -e 's|127.0.0.1|0.0.0.0|' /etc/redis.conf /etc/redis/redis.conf
echo -e "\e[35m>>>>>>>>>system restart<<<<<<<<<<\e[0m"
systemctl enable redis
systemctl restart redis