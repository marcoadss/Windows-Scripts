<#
.SYNOPSIS
Tenta resetar a senha da conta da maquina local no Active Directory.
.DESCRIPTION
Este script solicita credenciais com privilegios de AD e usa o cmdlet
Reset-ComputerMachinePassword para tentar reparar a relacao de confianca.
.NOTES
Requer o modulo PowerShell do Active Directory instalado na maquina.
Precisa ser executado com privilegios elevados (Como Administrador).
As credenciais fornecidas devem ter permissao para resetar contas de computador no AD.
#>

Write-Host "-----------------------------------------------------" -ForegroundColor Cyan
Write-Host " Reset da Senha da Conta da Maquina no Active Directory" -ForegroundColor Cyan
Write-Host "-----------------------------------------------------"
Write-Host "Este script tentara resetar a senha da conta desta maquina no AD."
Write-Host "Voce precisara fornecer credenciais com permissao para isso (ex: Admin do Dominio)."
Write-Host ""

# Verifica se esta executando como Administrador
if (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Warning "Este script precisa ser executado como Administrador!"
    Write-Warning "Clique com o botao direito no PowerShell ou CMD e escolha 'Executar como administrador'."
    Read-Host "Pressione ENTER para sair."
    exit
}

# Verifica se o comando Reset-ComputerMachinePassword existe (indicativo do modulo AD)
if (-not (Get-Command Reset-ComputerMachinePassword -ErrorAction SilentlyContinue)) {
    Write-Error "ERRO: O comando 'Reset-ComputerMachinePassword' nao foi encontrado."
    Write-Error "Verifique se o Modulo Active Directory para Windows PowerShell esta instalado nesta maquina."
    Write-Error "(Parte das Ferramentas de Administracao de Servidor Remoto - RSAT)"
    Read-Host "Pressione ENTER para sair."
    exit
}

try {
    # 1. Obter Credenciais
    Write-Host "Solicitando credenciais de dominio..." -ForegroundColor Yellow
    $cred = Get-Credential

    if ($null -eq $cred) {
        Write-Warning "Nenhuma credencial fornecida. Saindo."
        Read-Host "Pressione ENTER para sair."
        exit
    }

    # 2. Tentar Resetar a Senha da Máquina
    Write-Host "Tentando resetar a senha da conta da maquina ($($env:COMPUTERNAME))..." -ForegroundColor Yellow
    # O parametro -Server pode ser usado para especificar um DC, mas geralmente nao e necessario.
    Reset-ComputerMachinePassword -Credential $cred -ErrorAction Stop

    Write-Host ""
    Write-Host "SUCESSO: Comando executado." -ForegroundColor Green
    Write-Host "A senha da conta da maquina foi resetada no Active Directory (se as credenciais tinham permissao)." -ForegroundColor Green
    Write-Host "RECOMENDACAO: Reinicie o computador para garantir que a nova relacao de confianca seja estabelecida." -ForegroundColor Yellow

} catch {
    # Captura e exibe erros
    Write-Host ""
    Write-Error "ERRO: Falha ao tentar resetar a senha da maquina!"
    Write-Error "Detalhes: $($_.Exception.Message)"
    Write-Error "Verifique as credenciais fornecidas e as permissoes no AD."
}

Write-Host ""
Read-Host "Pressione ENTER para finalizar o script."