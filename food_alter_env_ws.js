// Obtem Botão Salvar
let save = document.getElementsByClassName('btn btn-primary btn-sm');
// Obtem Textarea Configuração de Terminais
let env_ws = document.getElementById('env_ws');
// Converte em JSON a Configuração de Terminais
let env_ws_json = JSON.parse(env_ws.textContent);
// Altera o Atributo do Objeto [Aqui serão incluidos os parametros a serem alterados pelo Script]
env_ws_json.DOCK.MULTIPLE_CARDS_ACCEPTED_PAYING_METHODS = 'credito, debito';
// Converte o JSON alterado em String e atribui ao Textarea indentado
env_ws.textContent = JSON.stringify(env_ws_json, null, 4);
// Salva as Alterações
save[1].click();
