#!/bin/bash
# sudo wget --inet4-only -O- https://raw.githubusercontent.com/wilker-santos/VSDImplantUpdater/main/UpdateServicesAWS_6-2023.sh | bash
log() 
{
    echo $(date)
    rm ~/update-status.txt
    echo "$1" > ~/update-status.txt
}

# Versions
VsOsInterface="2.23.5"
VsAutoPagSE="2.29.0"
#VsPrint="2.18.0"
VsFoodLauncher="2.0.0"
# Output
killall chrome
wget --inet4-only -c https://images.food.vsd.app/uploads/10075/advertising/2024/05/09/8645317ab77b45f7.gif
google-chrome --password-store=basic --kiosk --disable-pinch 8645317ab77b45f7.gif &>/dev/null &

# Prepare
sudo rm /var/lib/dpkg/lock-frontend
sudo rm /var/lib/dpkg/lock
sudo ufw disable
sudo modprobe usbcore autosuspend=-1
xfconf-query -c xfwm4 -p /general/use_compositing -s false
sudo apt install intel-media-va-driver -y
# sudo snap remove brave
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

# Install packages
log "Instalando VS Autopag S.E...."
sudo dpkg -i vs-autopag-se_$VsAutoPagSE'_amd64.deb'
log "Instalando VS OS Interface...."
sudo dpkg -i vs-os-interface_$VsOsInterface'_amd64.deb'
log "Instalando VS Food Launcher...."
sudo dpkg -i vs-food-launcher_2.0.0_amd64.deb

# Obtém o nome do modelo da CPU usando o comando lscpu
#cpu_model=$(lscpu | grep "Nome do modelo" | cut -d ':' -f 2 | sed 's/^ *//')

# Converte o nome do modelo para minúsculas para facilitar a comparação
#cpu_model_lower=$(echo "$cpu_model" | tr '[:upper:]' '[:lower:]')

# Verifica o modelo da CPU e instala o navegador correspondente
#if [[ $cpu_model_lower == *i* ]]; then
log "Download Google Chrome...."
wget --inet4-only -c https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
log "Instalando Google Chrome...."
sudo dpkg -i google-chrome-stable_current_amd64.deb
# elif [[ $cpu_model_lower == *A3* ]]; then
   # log "Download Chromium...."
   # wget --inet4-only -c http://packages.linuxmint.com/pool/upstream/c/chromium/chromium_120.0.6099.216%7elinuxmint1%2buna_amd64.deb
   # sudo apt update
   # log "Instalando Chromium...."
   # echo "Instalando Chromium...."
   # sudo snap install chromium
   # echo "Chromium Instalado...."
   # sudo dpkg -i chromium_120.0.6099.216~linuxmint1+una_amd64.deb
   # log "Download Script VS Food For Chromium...."
   # wget -c "https://raw.githubusercontent.com/wilker-santos/VSDImplantUpdater/main/vs-food.sh"
   # log "Movendo Script VS Food For Chromium...."
   # sudo mv vs-food.sh /opt/videosoft/vs-food-launcher/app/vs-food.sh
# else
   # log "Download Google Chrome...."
   # wget --inet4-only -c https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
   # log "Instalando Google Chrome...."
   # sudo dpkg -i google-chrome-stable_current_amd64.deb
#fi



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
EOF
