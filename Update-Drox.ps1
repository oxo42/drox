# Get the ID and security principal of the current user account
$myWindowsID=[System.Security.Principal.WindowsIdentity]::GetCurrent()
$myWindowsPrincipal=new-object System.Security.Principal.WindowsPrincipal($myWindowsID)

# Get the security principal for the Administrator role
$adminRole=[System.Security.Principal.WindowsBuiltInRole]::Administrator


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


function Make-DirectoryLink($link, $target)
{
    $cmd = "/c mklink /d `"{0}`" `"{1}`" " -f $link,$target

	Start-Process "cmd.exe" -Verb runas -ArgumentList $cmd
}


Push-Location (Split-Path -Path $MyInvocation.MyCommand.Definition -Parent)


echo "Starting drox update at $(date)"
git pull --force
echo "Check git submodule"
#git submodule update --recursive --init

if(!(Folder-IsSetup("$HOME/.vim"))) {
    echo "Setting up .vim"
    Make-DirectoryLink "$HOME\.vim" "$HOME\drox\vim"
} else {
    echo ".vim all good"
}

echo "Finished at $(date)"

Pop-Location
