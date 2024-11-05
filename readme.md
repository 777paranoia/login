### INSTALL ###

abstract:
this script will automate logins to scn in the background on a scheduled basis, on a debian-based system

####

1. change into this directory after extraction (assuming you've done so in your home folder) (do so in your home folder so this all runs smooth) 

       cd ~/login-main

2. open "credentials.txt" and insert your login info as told in the comment. save and close.

4. run setup installation script. make executable if necessary. this will begin the background service as well. enter password as prompted

       chmod +x ./setup.sh
       ./setup.sh

5. verify script is running by viewing log within newly created folder "~/.login_log". it should create a screenshot verifying each successful login, and update a .log file detailing the login process
   * note that this new directory will be hidden (~/.*) so remember to show hidden files in your file broweser to make it visible

6. verify timer is working. should currently be set to begin 5min after booting system and then repeatedly every hour

       systemctl list-timers --all | grep com.showcrewnetwork.login.timer

7. thank alec for having giant brain 

### UNINSTALL ###

to uninstall/stop the service, run the following in shell:

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
