@echo off
chcp 65001 >nul

net session >nul 2>&1
if %errorLevel% neq 0 (
    echo Solicitando privilégios de administrador...
    powershell -Command "Start-Process '%~f0' -Verb runAs"
    exit /b
)

taskkill /f /im chrome.exe /t >nul 2>&1
taskkill /f /im explorer.exe /t >nul 2>&1
timeout /t 2 >nul

echo Excluindo arquivos da pasta %%temp%%...
del /q /s "%temp%\*.*" || echo Erro ao excluir %%temp%%
echo Excluindo arquivos de C:\Windows\Temp...
del /q /s "C:\Windows\Temp\*.*" || echo Erro em C:\Windows\Temp
echo Limpando cache de inicialização (Prefetch)...
del /q /s "C:\Windows\Prefetch\*.*" || echo Erro em Prefetch

echo Removendo subpastas vazias...
for /d %%i in ("%temp%\*") do rmdir /q /s "%%i" 2>nul

echo Reiniciando o Windows Explorer...
start explorer.exe

echo.
echo Limpeza concluída! Pressione qualquer tecla para sair...
pause >nul