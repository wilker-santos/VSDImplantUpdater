#!/bin/bash
# wget https://raw.githubusercontent.com/wilker-santos/VSDImplantUpdater/main/vsd-launcher.sh -O vsd-launcher && sudo chmod 755 vsd-launcher && sudo mv vsd-launcher /usr/bin/

# Função para exibir a ajuda
function display_help() {
    echo "Uso: vsd-launcher -s <software> [-v <version>] [--clear-cache] [--clear-token]"
    echo
    echo "Opções:"
    echo "  -s <software>   Nome do software (ex: 'food', 'self')"
    echo "  -v <version>   Versão do software (aplicável apenas para o software 'food')"
    echo "  --clear-cache  Limpa o cache do Google Chrome"
    echo "  --clear-token  Limpa o token e cache do Google Chrome"
    echo
    echo "Exemplos:"
    echo "  vsd-launcher -s food -v 2       Atualiza a URL para 'https://food2.vsd.app'"
    echo "  vsd-launcher -s food            Atualiza a URL para 'https://food.vsd.app'"
    echo "  vsd-launcher -s self            Atualiza a URL para 'https://selfcheckout.vsd.app'"
    echo "  vsd-launcher -s food -v 2 --homolog  Atualiza a URL para 'https://food2.homolog.vsd.app'"
    echo "  vsd-launcher -s food --homolog        Atualiza a URL para 'https://food.homolog.vsd.app'"
    echo "  vsd-launcher -s self --homolog        Atualiza a URL para 'https://selfcheckout.homolog.vsd.app'"
    echo "  vsd-launcher --clear-cache      Limpa o cache do Google Chrome"
    echo "  vsd-launcher --clear-token      Limpa o token e cache do Google Chrome"
    echo
    echo "Se o software for 'food' e a versão não for especificada, a versão padrão será usada."
    echo "Para mais informações, consulte a documentação ou entre em contato com o Wilker Santos."
}

# Função para exibir a URL conforme os parâmetros fornecidos e atualizar o script
function update_url() {
    local service=""
    local version=""
    local homolog=false
    local new_url=""

    # Parse dos parâmetros
    while getopts "s:v:h--homolog" opt; do
        case $opt in
            s) service=$OPTARG ;;
            v) version=$OPTARG ;;
            h) display_help; exit 0 ;;
            --homolog) homolog=true ;;
            \?) echo "Opção inválida: -$OPTARG" >&2; display_help; exit 1 ;;
            :) echo "Opção -$OPTARG requer um argumento." >&2; display_help; exit 1 ;;
        esac
    done

    # Construção da URL com base nos parâmetros
    if [ "$service" == "food" ]; then
        if [ "$version" == "2" ]; then
            if [ "$homolog" = true ]; then
                new_url="https://food2.homolog.vsd.app"
            else
                new_url="https://food2.vsd.app"
            fi
        elif [ "$version" == "3" ] || [ -z "$version" ]; then
            if [ "$homolog" = true ]; then
                new_url="https://food.homolog.vsd.app"
            else
                new_url="https://food.vsd.app"
            fi
        else
            echo "Versão desconhecida para o serviço 'food'." >&2
            exit 1
        fi
    elif [ "$service" == "self" ]; then
        if [ "$homolog" = true ]; then
            new_url="https://selfcheckout.homolog.vsd.app"
        else
            new_url="https://selfcheckout.vsd.app"
        fi
    else
        echo "Serviço desconhecido." >&2
        exit 1
    fi

    # Atualização do arquivo vs-food.sh com a nova URL
    sudo sed -i "s|^VS_URL_APP=.*|VS_URL_APP=\"$new_url\"|" /opt/videosoft/vs-food-launcher/app/vs-food.sh

    echo "URL atualizada para: $new_url"
}

# Função para limpar o cache do Google Chrome
function clear_cache() {
    rm -r .cache/google-chrome/*
    rm -r .config/google-chrome/*
    echo "Cache do Google Chrome limpo."
}

# Função para limpar o token e cache do Google Chrome
function clear_token() {
    rm -r .cache/google-chrome/*
    rm -r .config/google-chrome/*
    sudo rm -f /opt/videosoft/vs-os-interface/log/_database*
    echo "Token e cache do Google Chrome limpos."
}

# Verifica se nenhum parâmetro foi passado e exibe a ajuda
if [ $# -eq 0 ]; then
    display_help
    exit 0
fi

# Parse dos parâmetros para as novas opções
for arg in "$@"; do
    case $arg in
        --clear-cache)
        clear_cache
        shift
        ;;
        --clear-token)
        clear_token
        shift
        ;;
        --homolog)
        homolog=true
        shift
        ;;
    esac
done

# Chamada da função com os parâmetros passados para o script
update_url "$@"
