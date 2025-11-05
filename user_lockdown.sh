#!/bin/bash

users = $(getent passwd | awk -F:)

