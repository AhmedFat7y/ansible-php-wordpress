#!/usr/bin/env bash

destination_port=$1
destination_user=$2
destination_host=$3
project_name=$4
project_path=$5
out_file=$6
db_name_backup_file=$7

project_config_wp="$project_path/wp-config.php"
project_config_laravel="$project_path/.env"

echo "- Project: $project_path"
if [ -e  $project_config_wp ]; then
  echo "  - Found wp-config.php"
  db_name=$(sed -n -e "/DB_NAME.*/p" $project_config_wp | grep -oP "DB_NAME', '\K\w+")
  db_user=$(sed -n -e "/DB_USER.*/p" $project_config_wp | grep -oP "DB_USER', '\K\w+")
  db_pass=$(sed -n -e "/DB_PASSWORD.*/p" $project_config_wp | grep -oP "DB_PASSWORD', '\K\w+")
  db_host=$(sed -n -e "/DB_HOST.*/p" $project_config_wp | grep -oP "DB_HOST', '\K\w+")
elif [ -e $project_config_laravel ]; then
  echo "  - Found laravel .env"
  db_name=$(sed -n -e "/^DB_DATABASE.*/p" $project_config_laravel | grep -o "[^=]*$")
else
  db_name=
fi

mysqldump -h$db_host -u$db_user -p$db_pass --databases $db_name | bzip2 > $db_name_backup_file

tar -cjf $project_path