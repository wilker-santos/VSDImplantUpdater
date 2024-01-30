// Obtem Botão Salvar
let save = document.getElementsByClassName('btn btn-primary btn-sm');
// Obtem Textarea Configuração de Terminais
let env_ws = document.getElementById('env_ws');
// Converte em JSON a Configuração de Terminais
let env_ws_json = JSON.parse(env_ws.textContent);
// Altera e/ou inclui Parametros
env_ws_json["USE_PRINTER_BY_INTERFACE"] = "true";
// Identa JSON e Inclui no TextArea
env_ws.textContent = JSON.stringify(env_ws_json, null, 4);
// Salva as Alterações
save[1].click();
