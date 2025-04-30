@echo off
cls
REM ##################################################################
REM # Script para verificar arquivos do sistema (SFC) e disco (CHKDSK) #
REM # e forcar REINICIALIZACAO para executar o CHKDSK no boot.        #
REM #                                                                #
REM # !!! IMPORTANTE !!!                                             #
REM # 1. Execute este script como ADMINISTRADOR.                     #
REM # 2. SALVE TODOS OS SEUS TRABALHOS antes de executar.            #
REM # 3. O computador sera REINICIADO FORCADAMENTE no final.         #
REM # 4. O CHKDSK /f sera executado DURANTE a reinicializacao.       #
REM ##################################################################

echo ============================================================
echo Iniciando verificacao dos arquivos de sistema (SFC)...
echo Isso pode demorar bastante tempo. Por favor, aguarde.
echo ============================================================
sfc /scannow

echo.
echo ============================================================
echo Verificacao SFC concluida.
echo Agendando verificacao do disco (CHKDSK C: /f) para a proxima
echo reinicializacao...
echo ============================================================
chkdsk /f C:
REM Se o comando acima ficar parado pedindo (Y/N),
REM voce pode tentar substitui-lo por: echo Y | chkdsk /f C:

echo.
echo ============================================================
echo !!! ATENCAO !!!
echo.
echo O CHKDSK foi agendado para a proxima inicializacao.
echo O computador sera REINICIADO FORCADAMENTE em 10 segundos.
echo SALVE QUALQUER TRABALHO PENDENTE AGORA!
echo Feche esta janela se quiser cancelar a reinicializacao.
echo ============================================================
echo.

REM Contagem regressiva antes de reiniciar
timeout /t 10 /nobreak

echo Reiniciando agora...
shutdown /r /f /t 0

goto :eof