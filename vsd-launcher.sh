#!/bin/bash
# wget https://raw.githubusercontent.com/wilker-santos/VSDImplantUpdater/main/vsd-launcher.sh -O vsd-launcher && sudo chmod 755 vsd-launcher && sudo mv vsd-launcher /usr/bin/
# Função para exibir a URL conforme os parâmetros fornecidos e atualizar o script
function update_url() {
    local service=""
    local version=""
    local new_url=""

    # Parse dos parâmetros
    while getopts "s:v:" opt; do
        case $opt in
            s) service=$OPTARG ;;
            v) version=$OPTARG ;;
            \?) echo "Opção inválida: -$OPTARG" >&2; exit 1 ;;
            :) echo "Opção -$OPTARG requer um argumento." >&2; exit 1 ;;
        esac
    done

    # Construção da URL com base nos parâmetros
    if [ "$service" == "food" ]; then
        if [ "$version" == "2" ]; then
            new_url="https://food2.vsd.app"
        elif [ "$version" == "3" ] || [ -z "$version" ]; then
            new_url="https://food.vsd.app"
        else
            echo "Versão desconhecida para o serviço 'food'." >&2
            exit 1
        fi
    elif [ "$service" == "self" ]; then
        new_url="https://selfcheckout.vsd.app"
    else
        echo "Serviço desconhecido." >&2
        exit 1
    fi

    # Atualização do arquivo vs-food.sh com a nova URL
    sudo sed -i "s|^VS_URL_APP=.*|VS_URL_APP=\"$new_url\"|" /opt/videosoft/vs-food-launcher/app/vs-food.sh

    echo "URL atualizada para: $new_url"
}

# Chamada da função com os parâmetros passados para o script
update_url "$@"
