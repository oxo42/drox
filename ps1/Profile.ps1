Push-Location (Split-Path -Path $MyInvocation.MyCommand.Definition -Parent)


# Load posh-git module from current directory
Import-Module .\posh-git
Import-Module .\Jump-Location\Jump.Location.psd1

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

#Remove-Item Alias:wget
#Remove-Item Alias:curl

Pop-Location

Start-SshAgent -Quiet
