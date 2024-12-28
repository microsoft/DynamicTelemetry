$ErrorActionPreference = 'Break'

$DB_DIR = Join-Path $PWD "..\orig_media"
$DB_DIR = Resolve-Path $DB_DIR
$env:CDOCS_DB = $DB_DIR

$md = (Get-Content ../../mkdocs.yml | Select-String ".md")
#$md = (type ../../mkdocs.yml | grep ".md")



if (!(Test-Path "..\bound_docs" -PathType Container))
{
	New-Item "..\bound_docs" -type directory
}

if (Test-Path "..\bound_docs\bind.files")
{
	Remove-Item "..\bound_docs\bind.files"
}

try {
	cd ..
	foreach($file in $md)
	{
		$file = $file.ToString()

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

		$env:CDOCS_TAB=0
		if ($seperator -gt 4)
		{
			$seperatorx = $seperator
			$seperatorx -= 4
			$seperatorx /= 4
			$env:CDOCS_TAB = $seperatorx
		}

		Write-Host "Convertinging $file"
		pandoc -i $file -o ./bound_docs/$file_leaf --filter CDocsMarkdownCommentRender

		Add-Content ".\bound_docs\bind.files" $file_leaf
	}

	cd bound_docs

	Write-Host "RUN THIS IN REAL LINUX *******"
	Write-Host "pandoc -i `$(cat ./bind.files) -o ./bound.md"
	cd ..

} finally {
	cd docs
}

#cd ..
#cd docs