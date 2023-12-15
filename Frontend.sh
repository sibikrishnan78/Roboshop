echo -e "\e[32m>>>>>>>>>Install nginx<<<<<<<<<<\e[0m"
dnf install nginx -y
echo -e "\e[32m>>>>>>>>>copy roboshop file<<<<<<<<<<\e[0m"
cp roboshop.conf /etc/nginx/default.d/roboshop.conf
rm -rf /usr/share/nginx/html/*
echo -e "\e[32m>>>>>>>>>downloading zip file<<<<<<<<<<\e[0m"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip
cd /usr/share/nginx/html
echo -e "\e[32m>>>>>>>>>unzipping zip file<<<<<<<<<<\e[0m"
unzip /tmp/frontend.zip
echo -e "\e[32m>>>>>>>>>system restart<<<<<<<<<<\e[0m"
systemctl enable nginx
systemctl restart nginx