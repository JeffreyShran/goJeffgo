#!bin/bash

######################################################################################################################################################
# goJeffgo
#
# Installs golang unattended directly from google
# Debian sources are out of date so we need to sort it out manually
#
# RUN: curl https://raw.githubusercontent.com/JeffreyShran/goJeffgo/master/goJeffgo.sh | bash
######################################################################################################################################################

if [ $EUID != 0 ]; then # Elevate if not already.
    sudo "$0" "$@"
    exit $?
fi

function version() {
  echo "$@" | awk -F. '{ printf("%d%03d%03d%03d\n", $1,$2,$3,$4); }'
}

AVAILABLEVERSION=$(curl -s https://golang.org/VERSION?m=text) # Returns in form of "go1.13.5"

function installGoFromTheGOOG() { # Pulls down latest golang direct from Google and sets PATH / GOPATH
  cd ~
  curl https://dl.google.com/go/$AVAILABLEVERSION.linux-amd64.tar.gz --output $AVAILABLEVERSION.linux-amd64.tar.gz
  tar -C /usr/local -xzf $AVAILABLEVERSION.linux-amd64.tar.gz
  sudo chown -R $SUDO_USER:$SUDO_USER /usr/local/go
  sudo echo "export GOPATH=/home/$SUDO_USER/go" >> /home/$SUDO_USER/.bash_profile; source /home/$SUDO_USER/.bash_profile
  sudo echo "export PATH=$PATH:$GOPATH/bin:/usr/local/go/bin" >> /home/$SUDO_USER/.bash_profile
  sudo echo "export GOBIN=$GOPATH/bin" >> /home/$SUDO_USER/.bash_profile
  sudo chown $SUDO_USER:$SUDO_USER /home/$SUDO_USER/.bash_profile
  mkdir -p /home/$SUDO_USER/go/{bin,src}
  sudo chown -R $SUDO_USER:$SUDO_USER /home/$SUDO_USER/go
  . /home/$SUDO_USER/.bash_profile
  sudo rm $AVAILABLEVERSION.linux-amd64.tar.gz
  echo " [!] Installed $AVAILABLEVERSION"
}

function updateGoFromTheGOOG() { # Pulls down latest golang direct from Google and sets PATH / GOPATH
  cd ~
  curl https://dl.google.com/go/$AVAILABLEVERSION.linux-amd64.tar.gz --output $AVAILABLEVERSION.linux-amd64.tar.gz
  tar -C /usr/local -xzf $AVAILABLEVERSION.linux-amd64.tar.gz
  sudo rm $AVAILABLEVERSION.linux-amd64.tar.gz
  echo " [!] Updated to $AVAILABLEVERSION"
}

if [[ $(which go | tr -d ' \n\r\t ' | head -c1 | wc -c) -ne 0 ]]; then # https://stackoverflow.com/a/35165216/4373967
  echo "Found golang installation"

  INSTALLEDVERSION=$(go version | {
    read _ _ v _
    echo ${v#go}
  }) # Strips out the response and returns in the form of "1.13.5"

  if [ $(version $INSTALLEDVERSION | cut -c 3-) -lt $(version $AVAILABLEVERSION) ]; then # Comparison Operators - http://tldp.org/LDP/abs/html/comparison-ops.html also pipe to cut and remove leading 2 characters
    echo " [-] Current go version is older than the one available from Google"
    sudo rm -rf /usr/local/go/    # remove current golang if exists. -f will ignore nonexistent files, never prompt
    updateGoFromTheGOOG # Update to latest verion
  else
    echo " [-] Currently installed golang v$INSTALLEDVERSION is already latest version"
    echo " [!] Finished"
  fi

else
  echo " [-] Installing golang from source as no current version exists"
  installGoFromTheGOOG
fi
