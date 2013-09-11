#!/bin/bash
# Simple setup.sh for configuring Ubuntu 12.04 LTS EC2 instance
# for headless setup.

compile_path=`dirname ${0}`

# Install nvm: node-version manager
# https://github.com/creationix/nvm
sudo apt-get install -y git
sudo apt-get install -y curl
curl https://raw.github.com/creationix/nvm/master/install.sh | sh

# Load nvm and install latest production node
source $HOME/.nvm/nvm.sh
nvm install v0.10.12
nvm use v0.10.12

# Install jshint to allow checking of JS code within emacs
# http://jshint.com/
npm install -g jshint
npm install -g coffee-script

# Install rlwrap to provide libreadline features with node
# See: http://nodejs.org/api/repl.html#repl_repl
sudo apt-get install -y rlwrap

# Install emacs24
# https://launchpad.net/~cassou/+archive/emacs
# sudo apt-add-repository -y ppa:cassou/emacs
# sudo apt-get -qq update
# sudo apt-get install -y emacs24-nox emacs24-el emacs24-common-non-dfsg
# bullshit; install emacs
sudo apt-get install emacs

# Install Heroku toolbelt
# https://toolbelt.heroku.com/debian
wget -qO- https://toolbelt.heroku.com/install-ubuntu.sh | sh


# Install google chrome
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
sudo sh -c 'echo "deb https://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
sudo apt-get update
sudo apt-get install google-chrome-stable

# zsh
sudo apt-get install zsh
# doxymacs
sudo apt-get install doxymacs

# git pull and install dotfiles
cd $HOME
git clone https://github.com/jackokaiser/myDotfiles.git
cd myDotfiles
./USE_WITH_CAUTION.sh


########################################
########### get redis ################
########################################
cd $HOME
sudo apt-get install tcl8.5
curl -O http://download.redis.io/releases/redis-stable.tar.gz
cd redis-stable
make
sudo make install
sudo cp src/redis-cli /usr/local/bin/
sudo cp src/redis-server /usr/local/bin/

sudo mkdir /etc/redis
sudo mkdir /var/redis
sudo cp utils/redis_init_script /etc/init.d/redis_6379

sudo cp ${compile_path}/myRedis.conf /etc/redis/6379.conf

sudo mkdir /var/redis/6379
sudo update-rc.d redis_6379 defaults
########################################
########### done redis ################
########################################


sudo chsh -s /bin/zsh
