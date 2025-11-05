#!/bin/bash

users=$(getent passwd | awk -F: '{print $1}')

for user in $users; do
    echo "Found user: $user"
done
