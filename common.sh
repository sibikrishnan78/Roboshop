user_add=roboshop

function_colour() {
  echo -e "\e[36m>>>>>>>>>$1<<<<<<<<<<\e[0m"
}
function_stat_check() {
  if[ $1 -eq 0 ]; then
        echo -e "\e[32msuccess\e[0m"
      else
        echo -e "\e[32mfailure\e[0m"
  fi
}
function_nodejs() {
  function_colour "disable nodejs"
  dnf module disable nodejs -y
  dnf module enable nodejs:18 -y
  function_stat_check $?
  function_colour "Installing nodejs"
  dnf install nodejs -y
  function_stat_check $?
}

function_npm() {
   function_colour "npm install"
   npm install
   function_stat_check $?
}

function_adduser() {
    function_colour "adding user"
    useradd ${user_add}
    function_stat_check $?
    rm -rf /app

    function_colour "creating directory"
    mkdir /app
    curl -L -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip
    function_stat_check $?

    function_colour "unzipping ${component}"
    cd /app
    unzip /tmp/${component}.zip
    function_stat_check $?
}

function_restart() {
  function_colour "copy ${component} service file"
    cp $script_path/${component}.service /etc/systemd/system/${component}.service

    function_colour "system restart"
    systemctl daemon-reload
    systemctl enable ${component}
    systemctl restart ${component}
    function_stat_check $?
}

function_mongodb() {
  function_colour "install mongodb shell"
  cp $script_path/mongo.repo /etc/yum.repos.d/mongo.repo
  dnf install mongodb-org-shell -y
  function_stat_check $?

  function_colour "load schema"
  mongo --host mongodb.deveng23.online </app/schema/${component}.js
  function_stat_check $?
}