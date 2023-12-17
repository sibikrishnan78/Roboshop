source common.sh

function_colour "enable redis"
function_stat_check $?
dnf install https://rpms.remirepo.net/enterprise/remi-release-8.rpm -y
function_stat_check $?
dnf module enable redis:remi-6.2 -y
function_stat_check $?
function_colour "install redis"
dnf install redis -y
function_stat_check $?
sed -i -e 's|127.0.0.1|0.0.0.0|' /etc/redis.conf /etc/redis/redis.conf
function_colour "system restart"
systemctl enable redis
systemctl restart redis
function_stat_check $?