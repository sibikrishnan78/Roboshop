user_add=roboshop

function_nodejs() {
  echo -e "\e[35m>>>>>>>>>disable nodejs<<<<<<<<<<\e[0m"
  dnf module disable nodejs -y
  dnf module enable nodejs:18 -y
  echo -e "\e[35m>>>>>>>>>Installing nodejs<<<<<<<<<<\e[0m"
  dnf install nodejs -y
  echo -e "\e[35m>>>>>>>>>adding user<<<<<<<<<<\e[0m"
  useradd ${user_add}
  rm -rf /app
  echo -e "\e[35m>>>>>>>>>creating directory<<<<<<<<<<\e[0m"
  mkdir /app
  curl -L -o /tmp/cart.zip https://roboshop-artifacts.s3.amazonaws.com/cart.zip
  echo -e "\e[35m>>>>>>>>>unzipping cart<<<<<<<<<<\e[0m"
  cd /app
  unzip /tmp/cart.zip
  echo -e "\e[35m>>>>>>>>>npm install<<<<<<<<<<\e[0m"
  npm install
  echo -e "\e[35m>>>>>>>>>copy cart service file<<<<<<<<<<\e[0m"
  cp $script_path/cart.service /etc/systemd/system/cart.service
  echo -e "\e[35m>>>>>>>>>system restart<<<<<<<<<<\e[0m"
  systemctl daemon-reload
  systemctl enable cart
  systemctl start cart
}