#!/bin/bash

cd ~/login-main || exit 1

sudo apt update
sudo apt install -y python3 python3-venv python3-pip || exit 1

if ! sudo apt install -y chromium-chromedriver; then
    sudo apt install -y chromium-driver || exit 1
fi

if ! command -v pip &> /dev/null; then
    sudo apt install -y python3-pip || exit 1
fi

mkdir -p ~/.login_log
touch ~/.login_log/login_script.log

sudo cp ./com.showcrewnetwork.login.service /etc/systemd/system/
sudo cp ./com.showcrewnetwork.login.timer /etc/systemd/system/

rm -rf ./venv
python3 -m venv ./venv || exit 1

[ -f "./venv/bin/activate" ] || exit 1

source ./venv/bin/activate
pip install --upgrade pip
pip install -r ./requirements.txt || { deactivate; exit 1; }

sudo systemctl daemon-reload
sudo systemctl enable com.showcrewnetwork.
