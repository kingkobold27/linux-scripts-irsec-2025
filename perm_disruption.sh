#!/bin/bash

users=$(getent passwd | awk -F: '{print $1}')
effectedusers=""

for user in $users; do 
  echo "User: $user"

  read -p "Change Perms? [Y/N] " answer

  if [ "$answer" = "Y" ]; then
    if [ ! -d /restricted ]; then
      sudo mkdir /restricted
      sudo chmod 400 /restricted
    fi
    sudo setfacl -Rm u:"$user":r-- /restricted
    sudo usermod -s /usr/sbin/nologin "$user"
    sudo usermod -d /restricted "$user"
    effectedusers+="$user "

  elif [ "$answer" = "N" ]; then
    continue
  else
    echo "Invalid input. Please answer Y or N."
  fi
done

echo "Affected users: $effectedusers"
echo "System changes complete."
