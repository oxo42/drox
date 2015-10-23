function Test-ReparsePoint([string]$path) {
    $file = Get-Item $path -Force -ea 0
    return [bool]($file.Attributes -band [IO.FileAttributes]::ReparsePoint)
}

Push-Location (Split-Path -Path $MyInvocation.MyCommand.Definition -Parent)


echo "Starting drox update at $(date)"
git pull --force
echo "Check git submodule"
git submodule update --recursive --init

if(!(Test-ReparsePoint($HOME/.vim))) {
    echo mklink .vim
}

echo "Finished at $(date)"

Pop-Location
