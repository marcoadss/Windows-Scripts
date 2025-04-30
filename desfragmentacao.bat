@echo off
chcp 65001 >nul

net session >nul 2>&1
if %errorLevel% neq 0 (
    echo Solicitando privilégios de administrador...
    powershell -Command "Start-Process '%~f0' -Verb runAs"
    exit /b
)

ver | find "10.0." >nul && set os=Win10/11 || set os=Legacy

echo Detectando unidades para desfragmentação...
set drives=
for /f "skip=1 tokens=2" %%d in ('wmic logicaldisk where "drivetype=3" get deviceid') do (
    fsutil fsinfo drivetype %%d | find "HDD" >nul && set drives=!drives! %%d
)

if not defined drives (
    echo Nenhuma unidade HDD detectada. Saindo...
    timeout /t 3 >nul
    exit /b
)

echo Iniciando desfragmentação em: %drives%
echo (Isso pode levar horas. Não interrompa o processo!)
echo.

for %%d in (%drives%) do (
    echo ======================================================================
    echo PROCESSANDO UNIDADE: %%d
    echo ======================================================================
    
    defrag.exe %%d /A /U /V > "%%d_analysis.txt"
    
    defrag.exe %%d /X /H /V /U >> "%%d_analysis.txt"
    
    if %errorLevel% equ 3 (
        echo Unidade %%d em uso. Agendando para proxima inicializacao...
        schtasks /create /tn "Desfragmentacao_%%d" /tr "defrag %%d /X /H /V" /sc onstart /ru SYSTEM
    )
)

echo.
echo Desfragmentacao concluida! Logs salvos em: %cd%
echo Pressione qualquer tecla para sair...
pause >nul