# Get the ID and security principal of the current user account
$myWindowsID=[System.Security.Principal.WindowsIdentity]::GetCurrent()
$myWindowsPrincipal=new-object System.Security.Principal.WindowsPrincipal($myWindowsID)

# Get the security principal for the Administrator role
$adminRole=[System.Security.Principal.WindowsBuiltInRole]::Administrator

# Adapted from http://www.west-wind.com/Weblog/posts/197245.aspx
function Get-FileEncoding($Path) {
    $bytes = [byte[]](Get-Content $Path -Encoding byte -ReadCount 4 -TotalCount 4)

    if(!$bytes) { return 'utf8' }

    switch -regex ('{0:x2}{1:x2}{2:x2}{3:x2}' -f $bytes[0],$bytes[1],$bytes[2],$bytes[3]) {
        '^efbbbf'   { return 'utf8' }
        '^2b2f76'   { return 'utf7' }
        '^fffe'     { return 'unicode' }
        '^feff'     { return 'bigendianunicode' }
        '^0000feff' { return 'utf32' }
        default     { return 'ascii' }
    }
}

function File-Exists($file)
{
    return Test-Path -Path $path
}

function Folder-Exists($path)
{
	return Test-Path -PathType Container -Path $path
}

function File-IsLink($path)
{
	$folder = Get-Item $path -Force
	return [bool]($folder.Attributes -band [System.IO.FileAttributes]::ReparsePoint)
}

function Folder-IsSetup($path)
{
	return $(Folder-Exists($path)) -and $(File-IsLink($path))
}

function File-IsSetup($path)
{
	return $(File-Exists($path)) -and $(File-IsLink($path))
}

function Make-DirectoryLink($link, $target)
{
    $cmd = "/c mklink /d `"{0}`" `"{1}`" " -f $link,$target
	Start-Process "cmd.exe" -Verb runas -ArgumentList $cmd
}

function Make-FileLink($link, $target)
{
    $cmd = "/c mklink `"{0}`" `"{1}`" " -f $link,$target
	Start-Process "cmd.exe" -Verb runas -ArgumentList $cmd
}


Push-Location (Split-Path -Path $MyInvocation.MyCommand.Definition -Parent)


Write-Host "Starting drox update at $(date)"
git pull --force
Write-Host "Check git submodule"
#git submodule update --recursive --init

if(!(Folder-IsSetup("$HOME/.vim"))) {
    Write-Host "Setting up .vim"
    Make-DirectoryLink "$HOME\.vim" "$HOME\drox\vim"
    cp _vimrc $HOME/_vimrc
}

if(!(File-IsSetup("$HOME/.gitconfig"))) {
    Write-Host "Setting up .gitconfig"
    Make-FileLink "$HOME\.gitconfig" "$HOME\drox\gitconfig"
}
# Powershell setup
$profileLine = ". $HOME\drox\ps1\Profile.ps1"
if(!(Select-String -Path $PROFILE -Pattern $profileLine -Quiet -SimpleMatch)) {
    Write-Host "Adding Drox to $PROFILE..."
    @"
# Load drox Profile
$profileLine
"@ | Out-File $PROFILE -Append -Encoding (Get-FileEncoding $PROFILE)
}

Write-Host "Finished at $(date)"

Pop-Location
