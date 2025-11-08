#!/bin/bash

# Get all system users
users=$(getent passwd | awk -F: '{print $1}')
removed_users=""

# Loop through each user
for user in $users; do
  read -p "Do you want to remove sudo access for '$user'? [Y/N] " answer
  
  case "$answer" in
    [Yy])
      sudo gpasswd -d "$user" sudo
      removed_users+="$user "
      ;;
    [Nn])
      continue
      ;;
    *)
      echo "Invalid input. Please enter Y or N."
      ;;
  esac
done

echo
echo "All removed users: $removed_users"
