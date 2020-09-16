# Dev Setup

* Productivity - Window Management/Quick Launcher
	## Coverflow Alt-Tab
	## Dash to Panel

* Settings - Dock/Finder
  * Application Finder
  * DocFetcher 
  * CerebroApp
  * Albert 
* Web Browser - Extensions - AdBlock, Privacy Badger, OneTab, JSONViewer, Stylus, Vue Devtools, React Devtools, Caret clock
* Node.js - nvm
* Code Editor - vs code
* Code Editor Extensions
* Break timer and Flux



# Setup commands

#curl
sudo apt install curl

## Pules Audio
sudo apt install pulseaudio
sudo apt install pavucontrol

#MS Fonts
sudo apt update && sudo apt install ttf-mscorefonts-installer

#Gnome shell connector
sudo apt-get install chrome-gnome-shell

## gnome-tweaks
sudo apt install gnome-tweaks

## OCS-URL 
from .deb

##Vim
sudo apt install vim

#Bluetooth controller
sudo apt-get install blueman
#https://www.maketecheasier.com/setup-bluetooth-in-linux/

#audio source selection

#Mail
sudo apt remove thunderbird
sudo apt autoremove
sudo snap install thunderbird
## imap.mail.yahoo.com - 993
## smtp.mail.yahoo.com - 465

#Drop Box  – via .deb from internet.

# KeePassX 2 – Backup 
sudo add-apt-repository ppa:eugenesan/ppa
sudo apt-get update
sudo apt-get install keepassx

#imwheel
sudo apt-get install imwheel

# http://www.webupd8.org/2015/12/how-to-change-mouse-scroll-wheel-speed.html
# start application with, add to startup
# imwheel --kill --buttons "4 5"



#Browser
sudo apt remove chromium-browser
sudo apt remove firefox
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb
sudo apt install chromium-browser
sudo apt install firefox

sudo snap install opera
# from Opera Store
#wget -qO- https://deb.opera.com/archive.key | sudo apt-key add -
#sudo add-apt-repository "deb [arch=i386,amd64] https://deb.opera.com/opera-stable/ stable non-free"
#sudo apt install opera-stable

#Canon Printer

#1. Connect Printer via USB Cable
#2. Install and run "IJ Network Device Setup Utility" for Canon
#3. Password for Printer is Serial Number - KKMR21884
#4. Setup Wifi Setting.
#5. Add Network Printer to Windows or Unix
#https://ugp01.c-ij.com/ij/webmanual/Manual/All/E470%20series/EN/CNT/Top.html
#https://canon-print.com/canon-pixma-e470-series-drivers-windows-mac-linux/
	#A. Windows
	#B. Unix - run cnijfilter2-5.40-1-deb to add printer
	#C. run scangearmp2-3.40-1-deb for Scanner	



## Albert
echo 'deb http://download.opensuse.org/repositories/home:/manuelschneid3r/xUbuntu_20.04/ /' | sudo tee /etc/apt/sources.list.d/home:manuelschneid3r.list
curl -fsSL https://download.opensuse.org/repositories/home:manuelschneid3r/xUbuntu_20.04/Release.key | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/home:manuelschneid3r.gpg > /dev/null
sudo apt update
sudo apt install albert
set CMD+space to launch albert



#Setup for development

#Setup Git
sudo apt update
sudo apt install git
sudo apt install git-all
git config --global user.name "Ravi Prakash Rathi"
git config --global user.email "raviprakash.rathi@sunrise.net"


## setup public key

ssh-keygen -t rsa -b 4096 -C "itzravirathi@yahoo.co.in"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_rsa
ssh -T git@github.com
ssh -T git@bitbucket.org

#change from http to ssh
git remote -v
git remote set-url origin git@bitbucket.org:sunrisedigitalbusiness/sunrise-esim-service.git



#Java
sudo apt install openjdk-8-jdk-headless
sudo update-alternatives --config java


#Node and NPP Install Node.js Version – 6.x on Ubuntu 16.04
curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash -
sudo apt-get install -y nodejs
sudo apt-get install -y npm

#intellij
sudo snap install intellij-idea-ultimate --classic

#Terminal
#open Gnome terminal /usr/bin/gnome-terminal
#Terminator
sudo apt install fortune-mod
sudo apt install cowsay
sudo apt-get install terminator
#Copy .bashrc from github
## change size of terminator
gedit ~/.config/terminator/config 
      [[[window0]]]
      type = Window
      parent = ""
      profile = None
      size = 1000, 900

#Postman
sudo snap install postman

#GitKraken
sudo snap install gitkraken --classic


#Setup for Office

#Sunrise VPN Cisco anyconnect
OS VPN plugin for cisco open connect
sudo apt-get install network-manager-openconnect-gnome
# https://vpn01.sunrise.net/VPN_sunrise
## Add 10.0.0.0 as vdi are having dynamic range when starts.
Add Routes for 192.168.0.0,10.0.0.0,212.35.60.0

	excluded
	mail.sunrise.net (212.35.62.52)

	192.168.0.0
		confluence.swi.srse.net (192.168.59.59)
		wilma (192.168.57.223)
		jira.swi.srse.net (192.168.59.59)
	10.0.0.0
		10.192.0.0
			t1-aem
			m-as-01.swi.srse.net (10.192.56.72)
		10.254.60.40
			vdi.swi.srse.net (10.254.60.40)
			vdi.sunrise.net (195.141.180.40)
			Dynamic IP, can’t be hard coded.
	212.35.60.0
	www-t01.sunrise.ch (212.35.60.21)

	Except - 
	sudo ip route add 212.35.60.35 via 10.0.0.1 dev wlp4s0
	sudo ip route add 212.35.60.35 via 192.168.1.1 dev enp3s0

##VMWare
chmod a+x VMware-Horizon-Client-2006-8.0.0-16522670.x64.bundle
sudo ./VMware-Horizon-Client-2006-8.0.0-16522670.x64.bundle 
### https://iag-vdi.sunrise.net
### https://vdi.swi.srse.net


##evolution
sudo apt-get remove evolution
sudo apt-get update
sudo apt-get install evolution
sudo apt-get install evolution-ews

##MSteams
sudo snap install teams-for-linux
##Change the permision from software center
