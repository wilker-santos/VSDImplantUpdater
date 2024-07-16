#!/bin/bash
# sudo wget --inet4-only -O- https://raw.githubusercontent.com/wilker-santos/VSDImplantUpdater/main/InstallAnyDesk.sh | bash

# URL da página HTML
url="https://download.anydesk.com/linux/"

# Obter o conteúdo da página HTML usando wget e filtrar o primeiro link .deb encontrado
package=$(wget -qO- "$url" | grep -oP '(?<=<a href="./)[^"]*\.deb' | head -n 1)

# Exibir a versão encontrada
echo "$package"

wget --inet4-only -c https://download.anydesk.com/linux/$package && sudo dpkg -i $package 
