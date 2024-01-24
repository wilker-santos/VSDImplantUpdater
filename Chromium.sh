#!/bin/bash
# sudo wget --inet4-only -O- https://raw.githubusercontent.com/wilker-santos/VSDImplantUpdater/main/Chromium.sh | bash
# Obtém o nome do modelo da CPU usando o comando lscpu
cpu_model=$(lscpu | grep "Nome do modelo" | cut -d ':' -f 2 | sed 's/^ *//')

# Converte o nome do modelo para minúsculas para facilitar a comparação
cpu_model_lower=$(echo "$cpu_model" | tr '[:upper:]' '[:lower:]')

# Verifica o modelo da CPU e instala o navegador correspondente
if [[ $cpu_model_lower == *i5* ]]; then
    log "Download Google Chrome...."
    wget --inet4-only -c https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
    log "Instalando Google Chrome...."
    sudo dpkg -i google-chrome-stable_current_amd64.deb
    google-chrome &>/dev/null &
    sleep 5
    killall chrome
    # Nome do arquivo de configuração
    #/snap/chromium/common/chromium/Default
    arquivo_configuracao="/home/videosoft/.config/google-chrome/Default/Preferences"
    # Adiciona o trecho no arquivo
    sed -i -E 's/"autofill":\s*\{[^\}]*"last_version_deduped":\s*120\}/"autofill":\{"last_version_deduped":120,"profile_enabled":false\}/' "$arquivo_configuracao"
    log "Desabilitado Preenchimento Automatico...."
elif [[ $cpu_model_lower == *i3* ]]; then
   # log "Download Chromium...."
   # wget --inet4-only -c http://packages.linuxmint.com/pool/upstream/c/chromium/chromium_120.0.6099.216%7elinuxmint1%2buna_amd64.deb
    sudo apt update
    log "Instalando Chromium...."
    echo "Instalando Chromium...."
    sudo snap install chromium
    echo "Chromium Instalado...."
   # sudo dpkg -i chromium_120.0.6099.216~linuxmint1+una_amd64.deb
    log "Download Script VS Food For Chromium...."
    wget -c "https://raw.githubusercontent.com/wilker-santos/VSDImplantUpdater/main/vs-food.sh"
    log "Movendo Script VS Food For Chromium...."
    sudo mv vs-food.sh /opt/videosoft/vs-food-launcher/app/vs-food.sh
    chromium &>/dev/null &
    sleep 5
    killall chrome
    # Nome do arquivo de configuração
    arquivo_configuracao="/home/videosoft/snap/chromium/common/chromium/Default/Preferences"
    # Adiciona o trecho no arquivo
    sed -i -E 's/"autofill":\s*\{[^\}]*"last_version_deduped":\s*120\}/"autofill":\{"last_version_deduped":120,"profile_enabled":false\}/' "$arquivo_configuracao"
    log "Desabilitado Preenchimento Automatico...."
else
    log "Download Google Chrome...."
    wget --inet4-only -c https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
    log "Instalando Google Chrome...."
    sudo dpkg -i google-chrome-stable_current_amd64.deb
fi
