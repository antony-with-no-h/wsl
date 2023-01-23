param (
    [string]$tag,
    [string]$name,
    [string]$username
)

$Image = (
    Join-Path -Path $env:UserProfile -ChildPath "rootfs" |
    Join-Path -ChildPath $tag | Join-Path -ChildPath "layer.tar")
$Directory = (Join-Path -Path $env:UserProfile -ChildPath "wsl" | Join-Path -ChildPath $name)

If (!(test-path $Directory))
{
    wsl --import $name $Directory $Image
}

$NetPath = (Join-Path -Path "\\wsl$\" -ChildPath $name | Join-Path -ChildPath "root")
$Resolv = (Join-Path -Path $NetPath -ChildPath "resolv.txt")
$Adduser = (Join-Path -Path $NetPath -ChildPath "adduser.txt")

Get-DnsClientServerAddress | 
    Select-Object -ExpandProperty ServerAddresses |
    Out-File -FilePath $Resolv

Copy-Item boot/bootstrap -Destination $NetPath
Copy-Item boot/dnf.txt -Destination $NetPath
"$username" | Out-File -FilePath $Adduser

# configure distro
wsl -d $name bash /root/bootstrap

# stop 
wsl -t $name

$NetTemp = (Join-Path -Path "\\wsl$\" -ChildPath $name | Join-Path -ChildPath "home" | Join-Path -ChildPath $username)
Copy-Item boot/localsetup -Destination $NetTemp
Copy-Item boot/init.vim -Destination $NetTemp
wsl -d $name bash -c 'cd; chmod u+x localsetup && ./localsetup'
