# sudo wget --inet4-only -O- https://raw.githubusercontent.com/wilker-santos/VSDImplantUpdater/main/UpdateServicesAWS_6-2023.sh | bash
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
VsFoodLauncher="2.0.0"

# Prepare
sudo rm /var/lib/dpkg/lock-frontend
sudo rm /var/lib/dpkg/lock
sudo ufw disable
sudo modprobe usbcore autosuspend=-1
sudo snap remove brave

log "Parando serviços..."
# Stop all services
killall node

# Backups
log "Criando Backups..."
sudo mkdir -p /opt/videosoft_bkp_log/vs-autopag-se/
sudo mkdir -p /opt/videosoft_bkp_log/vs-os-interface/
sudo mkdir -p /opt/videosoft_bkp_log/vs-print/

sudo mv /opt/videosoft/*tar.gz /opt/videosoft_bkp_log/
sudo mv /opt/videosoft/vs-autopag-se/log/ /opt/videosoft_bkp_log/vs-autopag-se/
sudo mv /opt/videosoft/vs-os-interface/log/ /opt/videosoft_bkp_log/vs-os-interface/
sudo mv /opt/videosoft/vs-print/log/ /opt/videosoft_bkp_log/vs-print/

# Error apport Ubuntu remove
sudo rm /var/crash/*
sudo apt remove apport apport-symptoms -y

# Download packages
log "Download VS OS Interface...."
wget --inet4-only -c https://cdn.vsd.app/softwares/vs-os-interface/$VsOsInterface/vs-os-interface_$VsOsInterface'_amd64.deb'
log "Download VS Autopag S.E...." 
wget --inet4-only -c https://cdn.vsd.app/softwares/vs-autopag-se/$VsAutoPagSE/vs-autopag-se_$VsAutoPagSE'_amd64.deb'
log "Download VS Food Launcher...." 
wget --inet4-only -c https://github.com/wilker-santos/VSDImplantUpdater/raw/main/vs-food-launcher_2.0.0_amd64.deb
log "Download Google Chrome...." 
wget --inet4-only -c https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb

# Install packages
log "Instalando VS Autopag S.E...."
sudo dpkg -i vs-autopag-se_$VsAutoPagSE'_amd64.deb'
log "Instalando VS OS Interface...."
sudo dpkg -i vs-os-interface_$VsOsInterface'_amd64.deb'
log "Instalando VS Food Launcher...."
sudo dpkg -i vs-food-launcher_2.0.0_amd64.deb
log "Instalando Google Chrome...."
sudo dpkg -i google-chrome-stable_current_amd64.deb

log "Removendo arquivos temporários...."
# Remove packages
rm *.deb

log "Restaurando Backups...."
# Restaurar Backups
sudo mv /opt/videosoft_bkp_log/vs-autopag-se/log/*2023-07* /opt/videosoft/vs-autopag-se/log/
sudo mv /opt/videosoft_bkp_log/vs-autopag-se/log/*2023-06* /opt/videosoft/vs-autopag-se/log/
sudo mv /opt/videosoft_bkp_log/vs-autopag-se/log/*2023-05* /opt/videosoft/vs-autopag-se/log/
sudo mv /opt/videosoft_bkp_log/vs-autopag-se/log/*2023-04* /opt/videosoft/vs-autopag-se/log/

sudo mv /opt/videosoft_bkp_log/vs-autopag-se/log/dmp/*202307* /opt/videosoft/vs-autopag-se/log/dmp/
sudo mv /opt/videosoft_bkp_log/vs-autopag-se/log/dmp/*202306* /opt/videosoft/vs-autopag-se/log/dmp/
sudo mv /opt/videosoft_bkp_log/vs-autopag-se/log/dmp/*202305* /opt/videosoft/vs-autopag-se/log/dmp/
sudo mv /opt/videosoft_bkp_log/vs-autopag-se/log/dmp/*202304* /opt/videosoft/vs-autopag-se/log/dmp/

sudo mv /opt/videosoft_bkp_log/vs-os-interface/log/*2023-07* /opt/videosoft/vs-os-interface/log/
sudo mv /opt/videosoft_bkp_log/vs-os-interface/log/*2023-06* /opt/videosoft/vs-os-interface/log/
sudo mv /opt/videosoft_bkp_log/vs-os-interface/log/*2023-05* /opt/videosoft/vs-os-interface/log/
sudo mv /opt/videosoft_bkp_log/vs-os-interface/log/*2023-04* /opt/videosoft/vs-os-interface/log/
sudo mv /opt/videosoft_bkp_log/vs-os-interface/log/_data* /opt/videosoft/vs-os-interface/log/

sudo mv /opt/videosoft_bkp_log/vs-print/log/*2023-07* /opt/videosoft/vs-print/log/
sudo mv /opt/videosoft_bkp_log/vs-print/log/*2023-06* /opt/videosoft/vs-print/log/
sudo mv /opt/videosoft_bkp_log/vs-print/log/*2023-05* /opt/videosoft/vs-print/log/
sudo mv /opt/videosoft_bkp_log/vs-print/log/*2023-04* /opt/videosoft/vs-print/log/

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

# Incluindo Script Rotação no Init
echo "xrandr --output HDMI-1 --mode 1920x1080 --rotate right" >>/opt/videosoft/scripts/rotacionar-tela.sh
echo "xfconf-query --channel xfce4-desktop --property /backdrop/screen0/monitorHDMI-1/workspace0/last-image --set /opt/videosoft/scripts/image-install/videosoft-vertical.png" >>/opt/videosoft/scripts/rotacionar-tela.sh
echo "xfconf-query --channel xfce4-desktop --property /backdrop/screen0/monitorHDMI-2/workspace0/last-image --set /opt/videosoft/scripts/image-install/videosoft-vertical.png" >>/opt/videosoft/scripts/rotacionar-tela.sh

mv /opt/videosoft/scripts/rotacionar-tela.sh /opt/videosoft/scripts/init/

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
