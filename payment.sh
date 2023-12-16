script=$(realpath "$0")
script_path=$(dirname "$script")
source $script_path/common.sh

echo -e "\e[35m>>>>>>>>>Install python<<<<<<<<<<\e[0m"
dnf install python36 gcc python3-devel -y
echo -e "\e[35m>>>>>>>>>Useradd<<<<<<<<<<\e[0m"
useradd ${user_add}
rm -rf /app
mkdir /app
echo -e "\e[35m>>>>>>>>>payment service<<<<<<<<<<\e[0m"
curl -L -o /tmp/payment.zip https://roboshop-artifacts.s3.amazonaws.com/payment.zip
echo -e "\e[35m>>>>>>>>>unzip payment<<<<<<<<<<\e[0m"
cd /app
unzip /tmp/payment.zip
echo -e "\e[35m>>>>>>>>>Install pip<<<<<<<<<<\e[0m"
pip3.6 install -r requirements.txt
cp $script_path/payment.service /etc/systemd/system/payment.service
echo -e "\e[35m>>>>>>>>>Restart<<<<<<<<<<\e[0m"
systemctl daemon-reload
systemctl enable payment
systemctl start payment