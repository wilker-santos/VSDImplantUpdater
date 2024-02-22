#!/bin/bash
# sudo wget -O- https://raw.githubusercontent.com/wilker-santos/VSDImplantUpdater/main/Install_Chromium.sh | bash
sudo apt install chromium-browser -y

wget -c "https://raw.githubusercontent.com/wilker-santos/VSDImplantUpdater/main/vs-food.sh"
sudo mv vs-food.sh /opt/videosoft/vs-food-launcher/app/vs-food.sh



# sudo add-apt-repository ppa:system76/pop
# sudo apt update && sudo apt install chromium

