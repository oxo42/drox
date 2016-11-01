# Start-Transcript -Path C:/temp/profile.txt -Append -IncludeInvocationHeader 
# $VerbosePreference = "continue"

Push-Location (Split-Path -Path $MyInvocation.MyCommand.Definition -Parent)

$env:PSModulePath = $env:PSModulePath + ";$HOME\Documents\WindowsPowerShell\Modules\"

# Load posh-git module from current directory
Import-Module posh-git

# This is because sometimes jumplocation.txt gets corrupted.  If it does, blow it away
Import-Module Jump.Location

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
    Set-PSReadlineOption -EditMode Emacs
    Set-PSReadlineOption -BellStyle None
}

Pop-Location

Start-SshAgent
