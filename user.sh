echo -e "\e[35m>>>>>>>>>disabling nodejs<<<<<<<<<<\e[0m"
dnf module disable nodejs -y
dnf module enable nodejs:18 -y
echo -e "\e[35m>>>>>>>>>Installing nodejs<<<<<<<<<<\e[0m"
dnf install nodejs -y
echo -e "\e[35m>>>>>>>>>adding user<<<<<<<<<<\e[0m"
useradd roboshop
rm -rf /app
echo -e "\e[35m>>>>>>>>>creating directory<<<<<<<<<<\e[0m"
mkdir /app
curl -L -o /tmp/user.zip https://roboshop-artifacts.s3.amazonaws.com/user.zip
echo -e "\e[35m>>>>>>>>>unzipping user<<<<<<<<<<\e[0m"
cd /app
unzip /tmp/user.zip
echo -e "\e[35m>>>>>>>>>npm install<<<<<<<<<<\e[0m"
npm install
echo -e "\e[35m>>>>>>>>>copy user service file<<<<<<<<<<\e[0m"
cp /home/centos/Roboshop/user.service /etc/systemd/system/user.service
echo -e "\e[35m>>>>>>>>>system restart<<<<<<<<<<\e[0m"
systemctl daemon-reload
systemctl enable user
systemctl start user
echo -e "\e[35m>>>>>>>>>install mongodb shell<<<<<<<<<<\e[0m"
cp /home/centos/Roboshop/mongo.repo /etc/yum.repos.d/mongo.repo
dnf install mongodb-org-shell -y
echo -e "\e[35m>>>>>>>>>load schema<<<<<<<<<<\e[0m"
mongo --host mongodb.deveng23.online </app/schema/user.js