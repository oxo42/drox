
Set-PSRepository  -Name PSGallery

Install-Module posh-git -Scope CurrentUser
Install-Module PSReadline -Scope CurrentUser
Install-Module Jump.Location -Scope CurrentUser

# as Admin
# cmd /c mklink .gitconfig .\drox\gitconfig