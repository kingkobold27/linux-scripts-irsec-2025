#!/bin/bash

# Interactive script to review and disable ANY user account

echo "=== User Account Review ==="
echo "You will be shown every user on the system, one at a time."
echo "Choose whether to disable each user."
echo

# Loop through ALL users in /etc/passwd
while IFS=: read -r username _ uid _ _ home shell; do
    echo "----------------------------------------"
    echo "User: $username"
    echo "UID: $uid"
    echo "Home Directory: $home"
    echo "Shell: $shell"

    # Show last login info
    lastlog -u "$username" | tail -n 1

    # Show account status
    if passwd -S "$username" &>/dev/null; then
        status=$(passwd -S "$username" | awk '{print $2}')
        if [[ "$status" == "L" ]]; then
            echo "Status: LOCKED"
        else
            echo "Status: ACTIVE"
        fi
    else
        echo "Status: UNKNOWN"
    fi

    echo
    read -p "Disable this user? (y/n/skip): " choice

    case "$choice" in
        y|Y)
            sudo usermod -L "$username" 2>/dev/null
            if [ $? -eq 0 ]; then
                echo "User '$username' has been DISABLED."
            else
                echo "Failed to disable '$username' (may be a system or root account)."
            fi
            ;;
        n|N)
            echo "User '$username' left active."
            ;;
        s|S|skip)
            echo "Skipping user '$username'."
            ;;
        *)
            echo "Invalid input — skipping."
            ;;
    esac
    echo
done < /etc/passwd

echo "=== Review Complete ==="
