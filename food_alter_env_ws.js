// Obtem Botão Salvar
let save = document.getElementsByClassName('btn btn-primary btn-sm');
// Obtem Textarea Configuração de Terminais
let env_ws = document.getElementById('env_ws');
// Converte em JSON a Configuração de Terminais
let env_ws_json = JSON.parse(env_ws.textContent);
// Obtem Seletor Layouts de Impressão Comanda
let sel_lay_imp = document.getElementById('entity_print_layout_id_1');
// Altera o Atributo do Objeto [Aqui serão incluidos os parametros a serem alterados pelo Script]
// env_ws_json["USE_COUPON"] = "true";
//env_ws_json["USE_COUPON_MESSAGE_INSTRUCTION"] = "Olá! Você tem um cupom de desconto?";
// env_ws_json["USE_COUPON_MESSAGE_INSERT"] = "Insira aqui o seu cupom de desconto KFC.";
// env_ws_json.PAYMENT.MULTIPLE_CARDS_ACCEPTED_PAYING_METHODS = 'credito, debito';
// env_ws_json["COLLECT_NAME_AMOUNT_OF_CHARACTERS"] = "40";
let CUSTOM_STEP_INTEGRATING = {
  "USES_CUSTOM_ICON": "false",
  "TITLE": "Pedido realizado!",
  "SUBTITLE": "Aguarde que estamos imprimindo sua comanda\nFavor dirigir-se ao balcão de atendimento para retirada de seu cupom fiscal."
}
env_ws_json["CUSTOM_STEP_INTEGRATING"] = CUSTOM_STEP_INTEGRATING;
sel_lay_imp.value = 20;
// Converte o JSON alterado em String e atribui ao Textarea indentado
env_ws.textContent = JSON.stringify(env_ws_json, null, 4);
// Salva as Alterações
save[1].click();
