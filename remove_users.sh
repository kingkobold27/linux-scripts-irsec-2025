#!/bin/bash

users=$(getent passwd | awk -F: '{print $1}')
removed_users=""

for user in $users; do 
  echo "User: $user"
  echo "Removed Users so far: $removed_users"
  
  read -p "Do you want to remove this user? [Y/N] " answer
  
  if [ "$answer" = "Y" ]; then
    sudo userdel "$user"
    removed_users+="$user "
  elif [ "$answer" = "N" ]; then
    continue
  else
    echo "Invalid input. Please enter Y or N."
  fi
done

echo "All removed users: $removed_users"

