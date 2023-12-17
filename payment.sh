script=$(realpath "$0")
script_path=$(dirname "$script")
source $script_path/common.sh
component=payment
rabbitmq_appuser_password=$1

if [ -z "$rabbitmq_appuser_password"]; then
  echo Input missing
  exit
fi

function_colour "Install python"
dnf install python36 gcc python3-devel -y
function_stat_check $?

function_adduser

function_colour "Install pip"
pip3.6 install -r requirements.txt
function_stat_check $?

function_colour "copy ${component} service file"
sed -i -e 's|rabbitmq_appuser_password|${rabbitmq_appuser_password}' $script_path/${component}.service
cp $script_path/${component}.service /etc/systemd/system/${component}.service

function_colour "system restart"
systemctl daemon-reload
systemctl enable ${component}
systemctl restart ${component}
function_stat_check $?