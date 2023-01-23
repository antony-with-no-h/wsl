param (
    [string]$tag,
    [string]$image
)

$env:PATH += ";C:\Program Files\7-Zip"

$Directory = (Join-Path -Path $env:UserProfile -ChildPath "rootfs" | Join-Path -ChildPath $tag)
$Output = (Join-Path -Path $Directory -ChildPath $image.Split("/")[-1])

If (!(test-path $Directory))
{
    md $Directory
}

Invoke-WebRequest -Uri $image -Outfile $Output

# uncompress 
7z e -o"$Directory" -aoa $Output

7z e -o"$Directory" -aoa -r $Output.replace(".xz","") layer.tar 

rm $Output, $Output.replace(".xz","")
