echo -e "\e[35m>>>>>>>>>Install nginx<<<<<<<<<<\e[0m"
dnf install nginx -y
echo -e "\e[35m>>>>>>>>>copy roboshop file<<<<<<<<<<\e[0m"
cp roboshop.conf /etc/nginx/default.d/roboshop.conf
rm -rf /usr/share/nginx/html/*
echo -e "\e[35m>>>>>>>>>downloading zip file<<<<<<<<<<\e[0m"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip
cd /usr/share/nginx/html
echo -e "\e[35m>>>>>>>>>unzipping zip file<<<<<<<<<<\e[0m"
unzip /tmp/frontend.zip
echo -e "\e[35m>>>>>>>>>system restart<<<<<<<<<<\e[0m"
systemctl enable nginx
systemctl restart nginx