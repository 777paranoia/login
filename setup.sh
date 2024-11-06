#!/bin/bash

cd ~/login-main || exit 1

sudo apt update
sudo apt install -y python3 python3-venv python3-pip || exit 1

# Check if pip is available, install if missing
if ! command -v pip &> /dev/null; then
    sudo apt install -y python3-pip || exit 1
fi

mkdir -p ~/.login_log
touch ~/.login_log/login_script.log

sudo cp ./com.showcrewnetwork.login.service /etc/systemd/system/
sudo cp ./com.showcrewnetwork.login.timer /etc/systemd/system/

rm -rf ./venv
python3 -m venv ./venv || exit 1

# Ensure the virtual environment has an activate script
[ -f "./venv/bin/activate" ] || exit 1

# Activate the virtual environment
source ./venv/bin/activate

# Upgrade pip and install dependencies including webdriver-manager
pip install --upgrade pip
pip install -r ./requirements.txt || { deactivate; exit 1; }
pip install webdriver-manager

# Use webdriver-manager to install chromedriver
python -c "from webdriver_manager.chrome import ChromeDriverManager; ChromeDriverManager().install()"

deactivate

sudo systemctl daemon-reload
sudo systemctl enable com.showcrewnetwork.login.service
sudo systemctl enable com.showcrewnetwork.login.timer
sudo systemctl start com.showcrewnetwork.login.timer
sudo systemctl status com.showcrewnetwork.login.timer
