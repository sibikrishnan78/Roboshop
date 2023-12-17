script=$(realpath "$0")
script_path=$(dirname "$script")
source $script_path/common.sh
component=dispatch

function_colour "install golang"
dnf install golang -y

function_adduser

function_colour "go mods"
go mod init dispatch
go get
go build

function_restart