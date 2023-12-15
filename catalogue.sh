dnf module disable nodejs -y
dnf module enable nodejs:18 -y
dnf install nodejs -y
cp catalogue.service /etc/systemd/system/catalogue.service
cp mongo.repo /etc/yum.repos.d/mongo.repo
useradd roboshop
rm -rf app
mkdir /app
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip
cd /app
unzip /tmp/catalogue.zip
cd /app
npm install
systemctl daemon-reload
systemctl enable catalogue
systemctl start catalogue
cp mongo.repo /etc/yum.repos.d/mongo.repo
dnf install mongodb-org-shell -y
mongo --host mongodb.deveng23.online </app/schema/catalogue.js
