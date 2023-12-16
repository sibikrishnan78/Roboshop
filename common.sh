user_add=roboshop

function_colour() {
  echo -e "\e[36m>>>>>>>>>$1<<<<<<<<<<\e[0m"
}

function_nodejs() {
  function_colour "disable nodejs"
  dnf module disable nodejs -y
  dnf module enable nodejs:18 -y

  function_colour "Installing nodejs"
  dnf install nodejs -y

  function_colour "adding user"
  useradd ${user_add}
  rm -rf /app

  function_colour "creating directory"
  mkdir /app
  curl -L -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip

  function_colour "unzipping cart"
  cd /app
  unzip /tmp/${component}.zip

  function_colour "npm install"
  npm install

  function_colour "copy cart service file"
  cp $script_path/${component}.service /etc/systemd/system/${component}.service

  function_colour "system restart"
  systemctl daemon-reload
  systemctl enable ${component}
  systemctl restart ${component}
}