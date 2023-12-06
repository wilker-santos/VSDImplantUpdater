#!/bin/sh

VS_URL_APP="https://food2.vsd.app"

# Parâmetros a ser passado ao Navegador
PARAMS="--password-store=basic --kiosk --disable-pinch --disable-component-update"

# Abre navegador avisando que vai atualizar o navegador
# echo "Aguarde, atualizando o navegador..."
# google-chrome /opt/videosoft/vs-food-launcher/app/updating-browser.html $PARAMS &>/dev/null &
# echo "Abriu o navegador, aguarde..."

# Atualiza navegador
# echo "Chamando Os Interface para atualizar o navegador..."
# curl http://localhost:3300/update/chrome
# echo "Passou pelo update do chrome"
# killall chrome
# echo "Fechou chrome com mensagem de atualização"
# sleep 3

# Abre a aplicação
echo "Abrindo a aplicação..."
chromium "$VS_URL_APP" $PARAMS

