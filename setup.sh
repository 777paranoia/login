#!/bin/bash

sudo apt update
sudo apt install -y python3 python3-venv python3-pip chromium-driver

if ! command -v pip &> /dev/null; then
    sudo apt install -y python3-pip
fi

mkdir -p ~/.login_log
touch ~/.login_log/login_script.log

cd ~/login-main
python3 -m venv ./venv
source ./venv/bin/activate
pip install -r ./requirements.txt

sed -i "s|%h|$HOME|g" com.showcrewnetwork.login.service

sudo cp ./com.showcrewnetwork.login.service /etc/systemd/system/
sudo cp ./com.showcrewnetwork.login.timer /etc/systemd/system/

sudo systemctl daemon-reload
sudo systemctl enable com.showcrewnetwork.login.service
sudo systemctl enable com.showcrewnetwork.login.timer
sudo systemctl start com.showcrewnetwork.login.timer
sudo systemctl status com.showcrewnetwork.login.timer
