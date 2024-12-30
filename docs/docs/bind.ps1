$ErrorActionPreference = 'Break'

$DB_DIR = Join-Path $PWD "..\orig_media"
$DB_DIR = Resolve-Path $DB_DIR
$env:CDOCS_DB = $DB_DIR

$env:PATH+=";C:\\Source\\CDocs\\tools\\CDocsMarkdownCommentRender\\bin\\Debug\\net8.0"

$md = (Get-Content ../../mkdocs.yml)
#$md = (type ../../mkdocs.yml | grep ".md")

if (!(Test-Path "..\bound_docs" -PathType Container))
{
	New-Item "..\bound_docs" -type directory
}

if (Test-Path "..\bound_docs\bind.files")
{
	Remove-Item "..\bound_docs\bind.files"
}

# Copy Everything; just so our Includes work
Copy-Item -Path .\* -Destination ..\bound_docs -Recurse 

try {
	cd ..
	$inNav = $false
	foreach($file in $md)
	{
		$file = $file.ToString()

		if($file -eq "#<START_BINDING>")
		{
			Write-Host "Found NAV"
			$inNav = $true
			continue
		}
		elseif($file -eq "#<END_BINDING>")
		{
			Write-Host "End NAV"
			$inNav = $false
			continue
		}

		if (!$inNav)
		{
			continue
		}

		if($file.Trim().Length -eq 0)
		{
			continue
		}

		$seperator = $file.IndexOf("-")
		$env:CDOCS_TAB=0
		$env:CDOCS_FILTER=1

		if ($seperator -gt 4)
		{
			$seperatorx = $seperator
			$seperatorx -= 4
			$seperatorx /= 4
			$env:CDOCS_TAB = $seperatorx
		}

		if(!$file.EndsWith(".md"))
		{
			Write-Host ("Generating : [$file]")
			$me = $file.Replace("-","").Replace(":","").Trim();
			$id = New-Guid
			Write-Host (" ==> $me ==> $id")

			$file = ".\bound_docs\$id.generated.md"
			$file_leaf = "$id.generated.converted.md"

			Add-Content "$file" "# $me"
		} else {
			$file = $file.ToString().Trim()
			$file=$file.ToString().Trim().Split(":")[1].ToString().Trim()

			if(!(Test-Path $file))
			{
				Write-Error "file doesnt exist : $file"
				exit 5
			}

			$file_leaf = Split-Path -Path $file -Leaf
		}

		Write-Host "Convertinging $file == > $file_leaf"
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