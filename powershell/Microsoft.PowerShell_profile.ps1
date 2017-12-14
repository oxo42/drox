# Start-Transcript -Path C:/temp/profile.txt -Append -IncludeInvocationHeader 
# $VerbosePreference = "continue"

Push-Location (Split-Path -Path $MyInvocation.MyCommand.Definition -Parent)

$env:PSModulePath = $env:PSModulePath + ";$HOME\Documents\WindowsPowerShell\Modules\"

# Load posh-git module from current directory
Import-Module posh-git -ErrorAction SilentlyContinue

# This is because sometimes jumplocation.txt gets corrupted.  If it does, blow it away
Import-Module Jump.Location -ErrorAction SilentlyContinue

# Set up a simple prompt, adding the git prompt parts inside git repos
function global:prompt {
  $realLASTEXITCODE = $LASTEXITCODE

  Write-Host "$env:COMPUTERNAME $($pwd.ProviderPath)" -NoNewline

  if (Get-Command Write-VcsStatus) {
    Write-VcsStatus
  }

  $global:LASTEXITCODE = $realLASTEXITCODE
  Write-Host
  Write-Host $(Get-Date).ToString("HH:mm") -NoNewline
  return " $ "
}

Remove-Item Alias:wget
Remove-Item Alias:curl

if (Get-Module PSReadline) {
  Import-Module PSReadLine
  Set-PSReadlineOption -EditMode Vi
  Set-PSReadlineOption -BellStyle None
}

Import-Module ~/local/PowerShell-Beautifier/PowerShell-Beautifier.psd1 -ErrorAction SilentlyContinue

Pop-Location

if (Get-Command Start-SshAgent -ErrorAction SilentlyContinue) {
  Start-SshAgent
}
