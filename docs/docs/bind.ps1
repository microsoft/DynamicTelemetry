
if ($IsLinux -eq $False)
{
	Write-Error "Must run on linux"
	exit
}

$md = (Get-Content ../../mkdocs.yml | Select-String ".md")
#$md = (type ../../mkdocs.yml | grep ".md")

if (Test-Path "bind.files")
{
	Remove-Item "bind.files"
}

foreach($file in $md)
{
	$file=$file.ToString().Trim().Split(":")
	Add-Content "bind.files" $file[1]
	Write-Host $file[1]
}

cd ..
bash -c "pandoc $(cat ./docs/bind.files) -o ./docs/bound.md"
cd docs
