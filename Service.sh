#!/bin/bash

echo "=============================="
echo "       Service Check"
echo "=============================="

SERVICE="sshd"

if pgrep "$SERVICE" > /dev/null
then
    echo "$SERVICE is running"
else
    echo "$SERVICE is NOT running"
fi

echo "=============================="
echo "Check completed!"