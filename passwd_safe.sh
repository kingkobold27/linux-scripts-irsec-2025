#!/bin/bash

# Step 1: Ask for username
read -p "Enter the username: " username

# Step 2: Check if user exists
if id "$username" &>/dev/null; then
    echo "User exists. Proceeding..."
else
    echo "User does not exist. Exiting."
    exit 1
fi

# Step 3: Ask for new password twice
while true; do
    read -s -p "Enter the new password: " newpass
    echo
    read -s -p "Confirm the new password: " confpass
    echo

    if [ "$newpass" = "$confpass" ]; then
        break
    else
        echo "Passwords do not match. Please try again."
    fi
done

# Step 4: Change password using chpasswd
echo "$username:$newpass" | sudo chpasswd

# Step 5: Confirm success
if [ $? -eq 0 ]; then
    echo "Password successfully changed!"
else
    echo "Failed to change password."
fi
