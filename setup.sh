#!/bin/bash

sudo apt update
sudo apt install -y python3 python3-venv python3-pip chromium-driver

if ! command -v pip &> /dev/null; then
    sudo apt install -y python3-pip
fi

mkdir -p ~/.login_log
python3 -m venv ~/venv
source ~/venv/bin/activate
pip install -r requirements.txt
sed -i "s|%h|$HOME|g" com.showcrewnetwork.login.service
sudo cp com.showcrewnetwork.login.service /etc/systemd/system/com.showcrewnetwork.login.service
sudo cp com.showcrewnetwork.login.timer /etc/systemd/system/com.showcrewnetwork.login.timer
sudo systemctl daemon-reload
sudo systemctl enable com.showcrewnetwork.login.timer
sudo systemctl start com.showcrewnetwork.login.timer
