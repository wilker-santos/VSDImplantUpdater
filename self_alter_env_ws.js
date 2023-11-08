let save = document.getElementsByClassName('btn btn-primary btn-sm');
let env_ws = document.getElementById('env_ws');
let env_ws_json = JSON.parse(env_ws.textContent);
env_ws_json.DOCK.BACK_TO_URL = 'https://food2.vsd.app?checkModules=false';
env_ws.textContent = JSON.stringify(env_ws_json, null, 4);
save[0].click();
