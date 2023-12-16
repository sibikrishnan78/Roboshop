script=$(realpath "$0")
script_path=$(dirname "$script")
source $script_path/common.sh

echo -e "\e[35m>>>>>>>>>Install maven<<<<<<<<<<\e[0m"
dnf install maven -y
echo -e "\e[35m>>>>>>>>>adding user<<<<<<<<<<\e[0m"
useradd ${user_add}
rm -rf /app
mkdir /app
curl -L -o /tmp/shipping.zip https://roboshop-artifacts.s3.amazonaws.com/shipping.zip
echo -e "\e[35m>>>>>>>>>unzipping shipping<<<<<<<<<<\e[0m"
cd /app
unzip /tmp/shipping.zip
mvn clean package
mv target/shipping-1.0.jar shipping.jar
echo -e "\e[35m>>>>>>>>>copying service file<<<<<<<<<<\e[0m"
cp $script_path/shipping.service /etc/systemd/system/shipping.service
echo -e "\e[35m>>>>>>>>>Restart<<<<<<<<<<\e[0m"
systemctl daemon-reload
systemctl enable shipping
systemctl start shipping
echo -e "\e[35m>>>>>>>>>load schema<<<<<<<<<<\e[0m"
dnf install mysql -y
mysql -h mysql.deveng23.online -uroot -pRoboShop@1 < /app/schema/shipping.sql
systemctl restart shipping