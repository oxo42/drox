function Folder-Exists($path)
{
	return Test-Path -PathType Container -Path $path
}

function Folder-IsLink($path)
{
	$folder = Get-Item $path -Force
	return [bool]($folder.Attributes -band [System.IO.FileAttributes]::ReparsePoint)
}

function Folder-IsSetup($path)
{
	return $(Folder-Exists($path)) -and $(Folder-IsLink($path))
}


Push-Location (Split-Path -Path $MyInvocation.MyCommand.Definition -Parent)


echo "Starting drox update at $(date)"
git pull --force
echo "Check git submodule"
git submodule update --recursive --init

if(!(Folder-IsSetup($HOME/.vim))) {
    echo mklink .vim
} else {
    echo .vim all good
}

echo "Finished at $(date)"

Pop-Location
