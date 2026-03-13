#!/bin/bash

# =================================================================
# NOME: Limes-Hardening.sh
# DESCRIÇÃO: Script de automação para hardening de servidores Linux.
# AUTOR: Letícia Augusto
# COMPATIBILIDADE: Debian, Ubuntu e Arch Linux
# =================================================================

# Cores para saída
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # Sem cor

echo -e "${GREEN}[*] Iniciando Hardening do Sistema...${NC}"

# 1. Verificar se é Root
if [[ $EUID -ne 0 ]]; then
   echo -e "${RED}[!] Este script precisa ser executado como root.${NC}"
   exit 1
fi

# 2. Atualização de Repositórios e Sistema
echo -e "${GREEN}[*] Atualizando pacotes do sistema...${NC}"
if command -v apt &> /dev/null; then
    apt update && apt upgrade -y
elif command -v pacman &> /dev/null; then
    pacman -Syu --noconfirm
fi

# 3. Configuração de Firewall (UFW)
echo -e "${GREEN}[*] Configurando Firewall (UFW)...${NC}"
if ! command -v ufw &> /dev/null; then
    if command -v apt &> /dev/null; then apt install ufw -y; fi
fi
ufw default deny incoming
ufw default allow outgoing
ufw allow ssh
ufw --force enable

# 4. Segurança do SSH
echo -e "${GREEN}[*] Ajustando configurações do SSH...${NC}"
sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin no/' /etc/ssh/sshd_config
sed -i 's/PermitRootLogin yes/PermitRootLogin no/' /etc/ssh/sshd_config
systemctl restart ssh

# 5. Desabilitar protocolos inseguros e remover pacotes de risco
echo -e "${GREEN}[*] Removendo protocolos legados (Telnet/RSH)...${NC}"
apt purge telnet rsh-client rsh-server -y 2>/dev/null

# 6. Auditoria de Permissões (Arquivos SUID/SGID)
echo -e "${GREEN}[*] Auditando arquivos com permissões mundiais de escrita...${NC}"
find / -xdev -type d \( -perm -0002 -a ! -perm -1000 \) -print > /tmp/vulnerable_dirs.txt

echo -e "${GREEN}[V] Hardening Concluído com Sucesso!${NC}"
echo -e "O relatório de diretórios vulneráveis foi salvo em /tmp/vulnerable_dirs.txt"
