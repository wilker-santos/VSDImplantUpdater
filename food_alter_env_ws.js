// Obtem Botão Salvar
let save = document.getElementsByClassName('btn btn-primary btn-sm');
// Obtem Textarea Configuração de Terminais
let env_ws = document.getElementById('env_ws');
// Converte em JSON a Configuração de Terminais
let env_ws_json = JSON.parse(env_ws.textContent);
// Altera o Atributo do Objeto [Aqui serão incluidos os parametros a serem alterados pelo Script]
env_ws_json.DOCK.APPS[0].url = 'https://food2.vsd.app/';
env_ws_json.DOCK.APPS[1].url = 'https://selfcheckout.vsd.app?checkModules=false';
// Converte o JSON alterado em String e atribui ao Textarea indentado
env_ws.textContent = JSON.stringify(env_ws_json, null, 4);
// Salva as Alterações
save[1].click();
