script=$(realpath "$0")
script_path=$(dirname "$script")
source $script_path/common.sh
component=cart

function_nodejs
function_adduser
function_restart

