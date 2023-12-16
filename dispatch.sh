echo -e "\e[35m>>>>>>>>>install golang<<<<<<<<<<\e[0m"
dnf install golang -y
echo -e "\e[35m>>>>>>>>>user add<<<<<<<<<<\e[0m"
useradd roboshop
echo -e "\e[35m>>>>>>>>>add directory<<<<<<<<<<\e[0m"
rm -rf /app
mkdir /app
echo -e "\e[35m>>>>>>>>>copy zip file<<<<<<<<<<\e[0m"
curl -L -o /tmp/dispatch.zip https://roboshop-artifacts.s3.amazonaws.com/dispatch.zip
echo -e "\e[35m>>>>>>>>>unzip<<<<<<<<<<\e[0m"
cd /app
unzip /tmp/dispatch.zip
echo -e "\e[35m>>>>>>>>>go mods<<<<<<<<<<\e[0m"
go mod init dispatch
go get
go build
echo -e "\e[35m>>>>>>>>>dispatch service<<<<<<<<<<\e[0m"
cp /home/centos/Roboshop/dispatch.service /etc/systemd/system/dispatch.service
echo -e "\e[35m>>>>>>>>>Restart<<<<<<<<<<\e[0m"
systemctl daemon-reload
systemctl enable dispatch
systemctl start dispatch