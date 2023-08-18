# sudo wget -O- https://raw.githubusercontent.com/wilker-santos/VSDImplantUpdater/main/UpdateServices_5-2023.sh | bash
log() 
{
    echo $(date)
    rm ~/update-status.txt
    echo "$1" > ~/update-status.txt
}

# Versions
VsOsInterface="2.22.0"
VsAutoPagSE="2.22.4"
#VsPrint="2.18.0"
#VsFoodLauncher="1.3.0"

# Prepare
sudo rm /var/lib/dpkg/lock-frontend
sudo rm /var/lib/dpkg/lock
sudo ufw disable
sudo modprobe usbcore autosuspend=-1
sudo snap remove brave
mkdir bkp_autopag
sudo mv /opt/videosoft/vs-autopag-se/log/ bkp_autopag/

# Error apport Ubuntu remove
sudo rm /var/crash/*
sudo apt remove apport apport-symptoms -y

log "Parando serviços..."
# Stop all services
killall node

# Download packages
log "Download VS OS Interface...."
wget -c https://cdn.vsd.app/softwares/vs-os-interface/$VsOsInterface/vs-os-interface_$VsOsInterface'_amd64.deb'
log "Download VS Autopag S.E...." 
wget -c https://cdn.vsd.app/softwares/vs-autopag-se/$VsAutoPagSE/vs-autopag-se_$VsAutoPagSE'_amd64.deb'
log "Download Google Chrome...." 
wget -c https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb

# Install packages
log "Instalando VS Autopag S.E...."
sudo dpkg -i vs-autopag-se_$VsAutoPagSE'_amd64.deb'
log "Instalando VS OS Interface...."
sudo dpkg -i vs-os-interface_$VsOsInterface'_amd64.deb'
log "Instalando Google Chrome...."
sudo dpkg -i google-chrome-stable_current_amd64.deb

log "Removendo arquivos temporários...."
# Remove packages
rm *.deb

log "Instalando Intel Graphics"
#Install Intel Graphics
sudo su
mkdir -p /etc/X11/xorg.conf.d
touch 20-intel.conf
echo 'Section "Device"
  Identifier "Intel Graphics"
  Driver "intel"
  Option "TearFree" "true"
EndSection' >>/etc/X11/xorg.conf.d/20-intel.conf

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
