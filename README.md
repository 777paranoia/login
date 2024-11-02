### INSTALL ###

abstract:
this script will automate logins to scn in the background on a scheduled basis, on a debian-based system

####

1. clone this repo with command below or dl it as zip

    gh repo clone 777paranoia/login
or
    wget https://github.com/777paranoia/login/archive/refs/heads/main.zip

2. change into (extracted) directory; assuming it's in your home directory  

     cd ~/login

3. add your login username and pw to 'com.showcrewnetwork.login.service' where you see this:

     Environment=USERNAME=your_username
     Environment=PASSWORD=your_password

     (replace your_username and your_password with your credentials)

4. save and close com.showcrewnetwork.login.service 

5. run setup installation script (make executable if necessary). this will begin the background service as well. enter password as prompted

     chmod +x ./setup.sh
     ./setup.sh

6. verify script is running by viewing log within newly created folder "~/.login_log". it should create a screenshot verifying each successful login, and update a .log file detailing the login process
   * note that this new directory will be hidden (~/.*) so remember to show hidden files in your file broweser to make it visible

7. verify timer is working. should currently be set to begin 5min after booting system and then repeatedly every hour

     systemctl list-timers --all | grep com.showcrewnetwork.login.timer

8. thank alec for having giant brain 

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
     rm -rf venv
     rm -rf ~/.login_log
