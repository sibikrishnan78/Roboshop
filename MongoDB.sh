cp mongo.repo /etc/yum.repos.d/mongo.repo
dnf install mongodb-org -y
systemctl enable mongod
systemctl start mongod
vim /etc/mongod.conf
sed 's|127.0.0.1|0.0.0.0|g'
systemctl restart mongod
