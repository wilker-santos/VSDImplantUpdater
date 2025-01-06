#!/bin/bash
# sudo wget --inet4-only -O- https://raw.githubusercontent.com/wilker-santos/VSDImplantUpdater/main/UpdateServicesIfoodLTS.sh | bash
log() 
{
    echo $(date)
    rm ~/update-status.txt
    echo "$1" > ~/update-status.txt
}

# Versions
VsOsInterface="2.24.0"
VsdPayment="1.1.0"
VsFoodLauncher="2.0.0"
PinpadServer="3.7.5"

# Output
killall chrome
wget --inet4-only -c https://images.food.vsd.app/uploads/10075/advertising/2024/07/30/f304c1ba70673b9a.webp
google-chrome --password-store=basic --kiosk --disable-pinch --force-device-scale-factor=1.75 f304c1ba70673b9a.webp &>/dev/null &

# Prepare
sudo rm /var/lib/dpkg/lock-frontend
sudo rm /var/lib/dpkg/lock
sudo ufw disable
sudo modprobe usbcore autosuspend=-1
xfconf-query -c xfwm4 -p /general/use_compositing -s false
sudo apt install intel-media-va-driver -y
sudo apt remove vs-print -y
sudo apt remove vs-autopag-se -y

log "Parando serviços..."
# Stop all services
killall node

# Backups
log "Criando Backups..."
sudo mkdir -p /opt/videosoft_bkp_log/vsd-payment/
sudo mkdir -p /opt/videosoft_bkp_log/vs-os-interface/
sudo mkdir -p /opt/videosoft_bkp_log/vs-print/

sudo mv /opt/videosoft/*tar.gz /opt/videosoft_bkp_log/
sudo mv /opt/vsd-payment/log/ /opt/videosoft_bkp_log/vsd-payment/
sudo mv /opt/videosoft/vs-os-interface/log/ /opt/videosoft_bkp_log/vs-os-interface/

# Remove Packages
sudo apt purge vsd-payment -y
sudo apt purge pinpad-server -y
# Error apport Ubuntu remove
sudo rm /var/crash/*
sudo apt remove apport apport-symptoms -y

# Download packages
log "Download VS OS Interface...."
wget --inet4-only -c https://cdn.vsd.app/softwares/vs-os-interface/$VsOsInterface/vs-os-interface_$VsOsInterface'_amd64.deb'
log "Download VSD Payment...." 
wget --inet4-only -c https://cdn.vsd.app/softwares/vsd-payment/prod/vsd-payment_$VsdPayment'_amd64.deb'
log "Download VS Food Launcher...." 
wget --inet4-only -c https://github.com/wilker-santos/VSDImplantUpdater/raw/main/vs-food-launcher_2.0.0_amd64.deb
log "Download Pinpad Server...." 
wget --inet4-only -c https://github.com/getzoop/zoop-package-public/releases/download/zoop-desktop-server_$PinpadServer/pinpad-server-installer_linux_$PinpadServer.deb

# Install packages
log "Instalando Pinpad Server...."
sudo dpkg -i pinpad-server-installer_linux_$PinpadServer.deb
log "Instalando VSD Payment...."
sudo dpkg -i vsd-payment_$VsdPayment'_amd64.deb'
log "Instalando VS OS Interface...."
sudo dpkg -i vs-os-interface_$VsOsInterface'_amd64.deb'
log "Instalando VS Food Launcher...."
sudo dpkg -i vs-food-launcher_2.0.0_amd64.deb
log "Download Google Chrome...."
wget --inet4-only -c https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
log "Instalando Google Chrome...."
sudo dpkg -i google-chrome-stable_current_amd64.deb
# Caminho para o script
SCRIPT_PATH="/opt/videosoft/vs-food-launcher/app/vs-food.sh"
# Verifica se o script está usando o chromium
if grep -q "chromium \"$VS_URL_APP\" $PARAMS" "$SCRIPT_PATH"; then
    echo "Alterando de chromium para google-chrome..."
    # Substitui 'chromium' por 'google-chrome'
    sudo sed -i 's/chromium "$VS_URL_APP" $PARAMS/google-chrome "$VS_URL_APP" $PARAMS/g' "$SCRIPT_PATH"
    echo "Alteração concluída."
else
    echo "O script já está usando o google-chrome."
fi
log "Removendo arquivos temporários...."
# Remove packages
rm *.deb

log "Instalação Concluida"
echo "*****************Instalação Concluida*************************"
log "Reiniciando...."
echo "Reiniciando Terminal em 5..."
sleep 1
echo "Reiniciando Terminal em 4..."
sleep 1
echo "Reiniciando Terminal em 3..."
sleep 1
echo "Reiniciando Terminal em 2..."
sleep 1
echo "Reiniciando Terminal em 1..."
sleep 1
echo "Reiniciando Terminal em 0..."
sleep 1
reboot
EOF
