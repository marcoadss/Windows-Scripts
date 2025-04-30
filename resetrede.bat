@echo off
cls
REM ####################################################################
REM # Script para Redefinir Winsock, TCP/IP e Limpar Cache DNS         #
REM # IMPORTANTE: Execute este script como ADMINISTRADOR!              #
REM # Um REINICIO do computador sera necessario apos executar.         #
REM ####################################################################

echo ==================================================
echo  Redefinindo o Catalogo Winsock...
echo ==================================================
netsh winsock reset

echo.
echo ==================================================
echo  Redefinindo a Pilha TCP/IP...
echo ==================================================
netsh int ip reset
REM Voce pode opcionalmente especificar um arquivo de log com:
REM netsh int ip reset resetlog.txt

echo.
echo ==================================================
echo  Limpando o Cache DNS local...
echo ==================================================
ipconfig /flushdns

echo.
echo =====================================================================
echo  COMANDOS EXECUTADOS!
echo.
echo  *** IMPORTANTE: REINICIE O SEU COMPUTADOR AGORA ***
echo  para que as redefinicoes de rede (Winsock/IP) sejam concluidas corretamente.
echo =====================================================================
echo.
pause