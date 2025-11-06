#!/bin/bash

users=$(getent passwd | awk -F: '{print $1}')

