script=$(realpath "$0")
script_path=$(dirname "$script")
source $script_path/common.sh

component=user

function_nodejs
function_adduser

function_npm

function_restart

function_mongodb