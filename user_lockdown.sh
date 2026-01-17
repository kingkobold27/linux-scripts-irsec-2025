#!/bin/bash

# Require root
if [[ $EUID -ne 0 ]]; then
  echo "Run this script as root."
  exit 1
fi

lockedusers=()

# Only users with UID >= 1000 (normal users)
users=$(getent passwd | awk -F: '$3 >= 1000 {print $1}')

for user in $users; do
  echo
  echo "User: $user"
  read -rp "Lock this user? [y/N]: " answer

  case "$answer" in
    [yY])
      passwd -l "$user"
      lockedusers+=("$user")
      ;;
    *)
      echo "Skipping $user"
      ;;
  esac
done

echo
echo "All locked users:"
printf ' - %s\n' "${lockedusers[@]}"
