#!/bin/bash
# sudo wget --inet4-only -O- https://raw.githubusercontent.com/wilker-santos/VSDImplantUpdater/main/vsd-payment-installer.sh | bash

sudo apt purge vsd-payment
sudo mkdir /opt/vsd-payment/.config-bkp/
sudo mv /opt/vsd-payment/.config/database.db /opt/vsd-payment/.config-bkp/database-bkp.db
wget -c https://cdn.vsd.app/softwares/vsd-payment/prod/vsd-payment_1.1.0_amd64.deb
sudo dpkg -i vsd-payment_1.1.0_amd64.deb
rm *deb
reboot
