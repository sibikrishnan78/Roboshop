echo -e "\e[35m>>>>>>>>>copying mongorepofile<<<<<<<<<<\e[0m"
cp mongo.repo /etc/yum.repos.d/mongo.repo
echo -e "\e[35m>>>>>>>>>Installing mongodb<<<<<<<<<<\e[0m"
dnf install mongodb-org -y
sed -i -e 's|127.0.0.1|0.0.0.0|' /etc/mongod.conf
echo -e "\e[35m>>>>>>>>>system restart<<<<<<<<<<\e[0m"
systemctl enable mongod
systemctl restart mongod
