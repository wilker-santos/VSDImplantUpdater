#!/bin/bash
# sudo wget --inet4-only -O- https://raw.githubusercontent.com/wilker-santos/VSDImplantUpdater/main/bkp_log.sh | bash
sudo su
# Diretórios
LOG_DIR="/opt/videosoft/vs-os-interface/log"
DEST_DIR="/opt/videosoft/"
DIAS=90

# Nome do arquivo final (inclui data)
ARQ_DEST="$DEST_DIR/vs-os-interface_$(date +%Y-%m-%d).tar.gz"

# Cria diretório de destino se não existir
mkdir -p "$DEST_DIR"

# Encontra arquivos antigos e cria o tar.gz
find "$LOG_DIR" -type f -mtime +$DIAS -print0 | tar -czvf "$ARQ_DEST" --null -T -

# Remove os originais apenas se o tar foi criado com sucesso
if [ -f "$ARQ_DEST" ]; then
    find "$LOG_DIR" -type f -mtime +$DIAS -delete
    echo "Logs antigos comprimidos em: $ARQ_DEST"
else
    echo "Falha ao criar o arquivo tar.gz"
fi
