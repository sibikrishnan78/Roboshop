script=$(realpath "$0")
script_path=$(dirname "$script")
source $script_path/common.sh
my_sql_password=$1

if [ -z "$my_sql_password"]; then
  echo Input missing
  exit
fi

function_colour "disabling mysql"
dnf module disable mysql -y
cp ${script_path}/mysql.repo /etc/yum.repos.d/mysql.repo
function_colour "install mysql"
dnf install mysql-community-server -y
function_colour "restart"
systemctl enable mysqld
systemctl restart mysqld
function_colour "user"
mysql_secure_installation --set-root-pass ${my_sql_password}