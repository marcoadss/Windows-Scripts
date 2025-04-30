# Windows-Scripts
Scripts .bat e .ps1 para remover arquivos temporarios, restaurar senha de dominio AD, reiniciar pilha de rede, verificacao de arquivos corrompidos e desfragmemntacao de HD.


# Como utilizar
Script Dominio (reseta a senha de máquina para erro de relação de dominio AD)
1 - Abra o PowerShell como administrador.
2 - Digite o codigo Set-ExecutionPolicy Bypass -Scope Process -Force para autorizar scripts terceirizados.
3 - Execute o script com o comando .\dominio.ps1.

Script ResetRede (Reinicia o adaptador de rede e a pilha de IP)
1 - Execute o script resetrede.bat como administrador.

Script WindowsCheck (Faz verificação de arquivos corrompidos e executa o chkdsk)
1 - Execute o script windowscheck.bat como administrador.

Script Desfragmentacao (Utilizado em HD's para otimizar)
1 - Execute o script desfragmentacao.bat como administrador.

Script Limpeza (Remove todos os arquivos temporarios do computador)
1 - Execute o script limpeza.bat como administrador
