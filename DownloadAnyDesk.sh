#!/bin/bash
# sudo wget -O- https://raw.githubusercontent.com/wilker-santos/VSDImplantUpdater/main/DownloadAnyDesk.sh | bash

# URL da página HTML
url="https://download.anydesk.com/linux/"

# Obter o conteúdo da página HTML usando wget e filtrar o primeiro link .deb encontrado
package=$(wget -qO- "$url" | grep -oP '(?<=<a href="./)[^"]*\.deb' | head -n 1)

# Exibir a versão encontrada
echo "$package"

wget -c https://download.anydesk.com/linux/$package && sudo dpkg -i $package 
