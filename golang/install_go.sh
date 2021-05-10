#!/bin/sh

set -euo pipefail

curl https://dl.google.com/go/go1.16.3.linux-386.tar.gz -o go1.16.3.linux-386.tar.gz
sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf go1.16.3.linux-386.tar.gz
rm go1.16.3.linux-386.tar.gz
echo 'export PATH=$PATH:/usr/local/go/bin' > $HOME/.bashrc
source $HOME/.bashrc
