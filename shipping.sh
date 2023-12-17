script=$(realpath "$0")
script_path=$(dirname "$script")
source $script_path/common.sh
component=shipping
my_sql_password=$1

if [ -z "$my_sql_password"]; then
  echo Input missing
  exit
fi

function_colour "Install maven"
dnf install maven -y

function_adduser

mvn clean package
mv target/shipping-1.0.jar shipping.jar

function_restart

function_colour "load schema"
dnf install mysql -y
mysql -h mysql.deveng23.online -uroot -p${my_sql_password} < /app/schema/shipping.sql
systemctl restart shipping