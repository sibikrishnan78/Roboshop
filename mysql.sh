echo -e "\e[35m>>>>>>>>>disabling mysql<<<<<<<<<<\e[0m"
dnf module disable mysql -y
cp /home/centos/Roboshop/mysql.repo /etc/yum.repos.d/mysql.repo
echo -e "\e[35m>>>>>>>>>install mysql<<<<<<<<<<\e[0m"
dnf install mysql-community-server -y
echo -e "\e[35m>>>>>>>>>restart<<<<<<<<<<\e[0m"
systemctl enable mysqld
systemctl restart mysqld
echo -e "\e[35m>>>>>>>>>user<<<<<<<<<<\e[0m"
mysql_secure_installation --set-root-pass RoboShop@1