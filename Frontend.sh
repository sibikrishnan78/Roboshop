source common.sh

function_colour "Install nginx"
dnf install nginx -y
function_colour "copy roboshop file"
cp roboshop.conf /etc/nginx/default.d/roboshop.conf
rm -rf /usr/share/nginx/html/*
function_colour "downloading zip file"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip
cd /usr/share/nginx/html
function_colour "unzipping zip file"
unzip /tmp/frontend.zip
function_colour "system restart"
systemctl enable nginx
systemctl restart nginx