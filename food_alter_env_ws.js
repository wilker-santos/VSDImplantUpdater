// Obtem Botão Salvar
let save = document.getElementsByClassName('btn btn-primary btn-sm');
// Obtem Textarea Configuração de Terminais
let env_ws = document.getElementById('env_ws');
// Converte em JSON a Configuração de Terminais
let env_ws_json = JSON.parse(env_ws.textContent);
// Altera o Atributo do Objeto [Aqui serão incluidos os parametros a serem alterados pelo Script]
env_ws_json["USE_COUPON"] = "true";
env_ws_json["USE_COUPON_MESSAGE_INSTRUCTION"] = "Olá! Você tem um cupom de desconto?";
env_ws_json["USE_COUPON_MESSAGE_INSERT"] = "Insira aqui o seu cupom de desconto KFC.";
// env_ws_json.PAYMENT.MULTIPLE_CARDS_ACCEPTED_PAYING_METHODS = 'credito, debito';
// env_ws_json["COLLECT_NAME_AMOUNT_OF_CHARACTERS"] = "40";
// Converte o JSON alterado em String e atribui ao Textarea indentado
env_ws.textContent = JSON.stringify(env_ws_json, null, 4);
// Salva as Alterações
save[1].click();
