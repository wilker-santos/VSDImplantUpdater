SCRIPT_PATH="/opt/videosoft/vs-food-launcher/app/vs-food.sh"
# Verifica se o script está usando o chromium
if grep -q "chromium \"$VS_URL_APP\" $PARAMS" "$SCRIPT_PATH"; then
    echo "Alterando de chromium para google-chrome..."
    # Substitui 'chromium' por 'google-chrome'
    sudo sed -i 's/chromium "$VS_URL_APP" $PARAMS/google-chrome "$VS_URL_APP" $PARAMS/g' "$SCRIPT_PATH"
    echo "Alteração concluída."
else
    echo "O script já está usando o google-chrome."
fi
