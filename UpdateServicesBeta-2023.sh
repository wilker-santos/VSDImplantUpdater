# sudo wget --inet4-only -O- https://raw.githubusercontent.com/wilker-santos/VSDImplantUpdater/main/UpdateServicesBeta-2023.sh | bash
log() 
{
    echo $(date)
    rm ~/update-status.txt
    echo "$1" > ~/update-status.txt
}

# Versions
VsOsInterface="2.23.3"
VsAutoPagSE="2.22.8"
#VsPrint="2.18.0"
VsFoodLauncher="2.0.0"

# Prepare
sudo rm /var/lib/dpkg/lock-frontend
sudo rm /var/lib/dpkg/lock
sudo ufw disable
sudo modprobe usbcore autosuspend=-1
sudo snap remove brave
# sudo apt remove google-chrome-stable -y

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
log "Download Google Chrome Beta...."
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

# IF Chrome Beta
# log "Ajustando script vs-food"
# wget --inet4-only -c https://raw.githubusercontent.com/wilker-santos/VSDImplantUpdater/main/vs-food.sh
# sudo mv vs-food.sh /opt/videosoft/vs-food-launcher/app/vs-food.sh

log "Removendo arquivos temporários...."
# Remove packages
rm *.deb
# rm vs-food.sh

log "Restaurando Backups...."
# Restaurar Backups
# Em Construção

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
