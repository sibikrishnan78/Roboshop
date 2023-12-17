source common.sh
rabbitmq_appuser_password=$1

if [ -z "$rabbitmq_appuser_password" ]; then
  echo Input missing
  exit
fi

function_colour "installing repos"
curl -s https://packagecloud.io/install/repositories/rabbitmq/erlang/script.rpm.sh | bash
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | bash
function_stat_check $?
function_colour "install rabbitmq"
dnf install rabbitmq-server -y
function_stat_check $?
function_colour "Restart"
systemctl enable rabbitmq-server
systemctl start rabbitmq-server
function_stat_check $?
function_colour "user"
rabbitmqctl add_user roboshop ${rabbitmq_appuser_password}
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*"
function_stat_check $?