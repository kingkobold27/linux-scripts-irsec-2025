#!/bin/bash

users=$(getent passwd | awk -F: '{print $1}')
lockedusers=""

for user in $users; do 
  echo "User: $user"
  echo "Locked Users so far: $lockedusers"
  
  read -p "Do you want to lock this user? [Y/N] " answer
  
  if [ "$answer" = "Y" ]; then
    sudo passwd -l "$user"
    lockedusers+="$user "
  elif [ "$answer" = "N" ]; then
    continue
  else
    echo "Huh?"
  fi
done

echo "All locked users: $lockedusers"
