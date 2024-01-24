#! /bin/bash
# sudo wget --inet4-only -O- https://raw.githubusercontent.com/wilker-santos/VSDImplantUpdater/main/UpdateServicesAlfa.sh | bash
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
    google-chrome
    sleep 5
    killall chrome
    # Nome do arquivo de configuração
    #/snap/chromium/common/chromium/Default
    arquivo_configuracao="/home/videosoft/.config/google-chrome/Default/Preferences"
    # Adiciona o trecho no arquivo
    sed -i -E 's/"autofill":\s*\{[^\}]*"last_version_deduped":\s*120\}/"autofill":\{"last_version_deduped":120,"profile_enabled":false\}/' "$arquivo_configuracao"
    log "Desabilitado Preenchimento Automatico...."
