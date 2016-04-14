Push-Location (Split-Path -Path $MyInvocation.MyCommand.Definition -Parent)

$env:PSModulePath = $env:PSModulePath + ";$HOME\drox\ps1\Modules"

# Load posh-git module from current directory
Import-Module posh-git

# This is because sometimes jumplocation.txt gets corrupted.  If it does, blow it away
try {
    Import-Module Jump.Location
} catch {
    Write-Host "In catch block"
    Remove-Item $HOME\jump-location.txt*
    Import-Module Jump.Location
}

# If module is installed in a default location ($env:PSModulePath),
# use this instead (see about_Modules for more information):
# Import-Module posh-git


# Set up a simple prompt, adding the git prompt parts inside git repos
function global:prompt {
    $realLASTEXITCODE = $LASTEXITCODE

    Write-Host($pwd.ProviderPath) -nonewline

    Write-VcsStatus

    $global:LASTEXITCODE = $realLASTEXITCODE
    Write-Host
	Write-Host $(Get-Date).ToString("HH:mm") -nonewline
    return " $ "
}

Remove-Item Alias:wget
Remove-Item Alias:curl

if(Get-Module PSReadline) {
    Import-Module PSReadLine

    #Set-PSReadlineKeyHandler -Key Tab -Function Complete
    Set-PSReadlineKeyHandler -Key Ctrl+a -Function BeginningOfLine
    Set-PSReadlineKeyHandler -Key Ctrl+e -Function EndOfLine
    Set-PSReadlineKeyHandler -Key Ctrl+u -Function BackwardDeleteLine
    Set-PSReadlineKeyHandler -Key Ctrl+w -Function BackwardKillWord
    Set-PSReadlineOption -BellStyle None
}

Pop-Location

Start-SshAgent -Quiet
