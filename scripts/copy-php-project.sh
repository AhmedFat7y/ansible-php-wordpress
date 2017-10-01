#!/usr/bin/env bash
destination_host='178.62.16.179'
destination_user='robusta'
destination_port='22'
project_name='blog.robustastudio.com'
project_path="/var/www/$project_name"
out_file="$project_path.tar.bz2"
db_name_backup_file="$project_path/db.sql.bz2"

ssh -p$destination_port $destination_user@$destination_host "bash -s" -- < ./copy-php-project_helper.sh \
  $destination_port \
  $destination_user \
  $destination_host \
  $project_name \
  $project_path \
  $out_file \
  $db_name_backup_file

scp -P$destination_port $destination_user@$destination_host:$out_file ~/

