#!/bin/bash

sudo systemctl stop com.showcrewnetwork.login.timer
sudo systemctl disable com.showcrewnetwork.login.timer
sudo systemctl stop com.showcrewnetwork.login.service
sudo systemctl disable com.showcrewnetwork.login.service
sudo rm -f /etc/systemd/system/com.showcrewnetwork.login.service
sudo rm -f /etc/systemd/system/com.showcrewnetwork.login.timer
sudo systemctl daemon-reload
sudo systemctl reset-failed
rm -rf ~/.login_log
rm -r ~/login-main
