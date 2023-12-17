source common.sh

function_colour "copying mongorepofile"
cp mongo.repo /etc/yum.repos.d/mongo.repo
function_stat_check $?
function_colour "Installing mongodb"
dnf install mongodb-org -y
function_stat_check $?
sed -i -e 's|127.0.0.1|0.0.0.0|' /etc/mongod.conf
function_colour "system restart"
systemctl enable mongod
systemctl restart mongod
function_stat_check $?
