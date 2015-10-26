# This is the install script for drox on windows with PowerShell.
# Windows and Linux dot repository living together?
# Shared git config?  Common vim config?
# MADNESS I TELL YOU MADNESS

Push-Location

if($(Get-ExecutionPolicy) -eq "Restricted") {
    Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Confirm
}

cd $HOME
if(Test-Path drox) {
    cd drox
    git pull --force
} else {
    Write-Output "drox not found, cloning"
    git clone https://github.com/oxo42/drox.git
    cd drox
    # Set push to SSH
    git remote set-url --push origin git@github.com:oxo42/drox.git
}

./Update-Drox.ps1

Pop-Location
