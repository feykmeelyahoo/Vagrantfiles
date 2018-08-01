#!/usr/bin/env bash
# check if a go version is set

ls /usr/local/share/ca-certificates/PCAcert.crt > /dev/null 2>&1
CERT_INSTALLED=$?

if [ $CERT_INSTALLED -eq 0 ]; then
    echo "Cert Already Installed"
else
    echo "Installing Cert"
    sudo cp /vagrant/PCA*.crt /usr/local/share/ca-certificates
    sudo update-ca-certificates 
fi

sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get install -y python vim openssh-server git
sudo echo "net.ipv4.ip_forward=1" >> /etc/sysctl.conf
swapoff -a
sudo systemctl start ssh
sudo systemctl enable ssh
sudo shutdown now -r
