$ErrorActionPreference = 'Break'

$DB_DIR = Join-Path $PWD "..\orig_media"
$DB_DIR = Resolve-Path $DB_DIR
$env:CDOCS_DB = $DB_DIR

$md = (Get-Content ../../mkdocs.yml | Select-String ".md")
#$md = (type ../../mkdocs.yml | grep ".md")

if (Test-Path "bind.files")
{
	Remove-Item "bind.files"
}

if (!(Test-Path "..\bound_docs" -PathType Container))
{
	New-Item "..\bound_docs" -type directory
}


try {
	cd ..
	foreach($file in $md)
	{
		$file = $file.ToString()
		#Write-Host "Looking $file"
		#Write-Host "MD: " $file.EndsWith(".md")

		if(!$file.EndsWith(".md"))
		{
			Write-Host ("Skipping : $file")
			continue
		}

		$seperator = $file.IndexOf("-")
		$file = $file.ToString().Trim()
		$file=$file.ToString().Trim().Split(":")[1].ToString().Trim()

		if(!(Test-Path $file))
		{
			Write-Error "file doesnt exist : $file"
			exit 5
		}

		$file_leaf = Split-Path -Path $file -Leaf
		Add-Content "bind.files" $file[1]

		Write-Host "SEP: $seperator, $file"

		pandoc -i $file -o ./bound_docs/$file_leaf --filter CDocsMarkdownCommentRender
	}
} finally {
	cd docs
}


#cd ..
#bash -c "pandoc $(cat ./docs/bind.files) -o ./docs/bound.md"
#cd docs