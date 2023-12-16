script=$(realpath "$0")
script_path=$(dirname "$script")
source $script_path/common.sh

component=catalogue

function_nodejs


echo -e "\e[35m>>>>>>>>>install mongodb shell<<<<<<<<<<\e[0m"
cp $script_path/mongo.repo /etc/yum.repos.d/mongo.repo
dnf install mongodb-org-shell -y
echo -e "\e[35m>>>>>>>>>load schema<<<<<<<<<<\e[0m"
mongo --host mongodb.deveng23.online </app/schema/catalogue.js