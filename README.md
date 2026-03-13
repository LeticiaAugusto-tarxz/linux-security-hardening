# Linux Security Hardening Script 🐧🛡️

Este projeto consiste em um script Bash desenvolvido para automatizar a segurança inicial de servidores baseados em Linux (Debian/Ubuntu/Arch).

## 🚀 Funcionalidades
- **Atualização Automatizada:** Garante que todos os patches de segurança estejam aplicados.
- **Firewall Proativo:** Configura o UFW para bloquear tráfego não solicitado por padrão.
- **SSH Hardening:** Desabilita o acesso root remoto para prevenir ataques de força bruta.
- **Remoção de Legados:** Elimina protocolos inseguros como Telnet.
- **Auditoria de Permissões:** Identifica diretórios com permissões de escrita excessivas.

## 🛠️ Como usar
1. Clone o repositório:
   `git clone https://github.com/LeticiaAugusto-tarxz/linux-security-hardening.git`
2. Dê permissão de execução:
   `chmod +x hardening.sh`
3. Execute como root:
   `sudo ./hardening.sh`

## 📊 Objetivo
Demonstrar competência em automação via Shell Scripting e aplicação de políticas de segurança em infraestrutura Linux.
