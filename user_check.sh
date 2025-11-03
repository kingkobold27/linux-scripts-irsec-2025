#!/bin/bash

# Script to disable user accounts interactively
# Run as root or with sudo

echo "=== User Disable Script ==="
echo "Iterating through system users..."

# Read each user from /etc/passwd
while IFS=: read -r username _ userid _ _ home shell; do
    # Skip system accounts (UID < 1000 usually)
    if [ "$userid" -lt 1000 ]; then
        continue
    fi

    echo ""
    echo "User: $username"
    echo "Home directory: $home"
    echo "Shell: $shell"

    read -p "Do you want to disable this user? (y/n): " choice
    if [[ "$choice" == "y" || "$choice" == "Y" ]]; then
        # Lock the account
        sudo usermod -L "$username"
        # Optionally expire the account to prevent any login
        sudo usermod -e 1 "$username"
        echo "→ User $username has been disabled."
    else
        echo "→ Skipping $username."
    fi
done < /etc/passwd

echo ""
echo "=== Done. User check complete. ==="
