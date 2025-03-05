$ErrorActionPreference = 'Break'

Write-Host "Binding Docs............."

cd /data/docs/docs

ls

$DB_DIR = Join-Path $PWD "../orig_media"
$DB_DIR = Resolve-Path $DB_DIR
$env:CDOCS_DB = $DB_DIR

$md = (Get-Content ../../mkdocs.yml)

if (!(Test-Path "/data/docs/bound_docs" -PathType Container))
{
	New-Item "/data/docs/bound_docs" -type directory
}
if (Test-Path "/data/docs/bound_docs/bind.files")
{
	Remove-Item "/data/docs/bound_docs/bind.files"
}

if (Test-Path "/data/docs/bound_docs/title.txt")
{
	Remove-Item "/data/docs/bound_docs/title.txt"
}

if (Test-Path "/data/docs/bound_docs\title.txt")
{
	Remove-Item "/data/docs/bound_docs\title.txt"
}
Add-Content /data/docs/bound_docs\title.txt "---"
Add-Content /data/docs/bound_docs\title.txt "title: Dynamic Telemetry $(Get-Date)"
Add-Content /data/docs/bound_docs\title.txt "author: Chris Gray at.al"
Add-Content /data/docs/bound_docs\title.txt "date: $(Get-Date)"
Add-Content /data/docs/bound_docs\title.txt "---"

# Copy Everything; just so our Includes work
Write-Host ""
Write-Host "Copying all doc files into /data/docs/bound_docs, for processing"
Write-Host ""
Copy-Item -Path ./* -Destination /data/docs/bound_docs -Recurse
Write-Host "Copy Complete"


try {
	cd /data/docs
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

		# Skip Empty Lines
		if($file.Trim().Length -eq 0)
		{
			continue
		}

		# Skip Comments
		if($file.Trim().StartsWith("#"))
		{
			continue
		}
		
		$separator = $file.IndexOf("-")
		$env:CDOCS_TAB=0
		$env:CDOCS_FILTER=1
		if ($separator -gt 4)
		{
			$separatorx = $separator

			if (0 -eq ($separator % 4))
			{
				$separatorx -= 4
				$separatorx /= 4
				$env:CDOCS_TAB = $separatorx
			}
		}
		if(!$file.EndsWith(".md"))
		{
			Write-Host ("Generating : [$file]")
			$me = $file.Replace("-","").Replace(":","").Trim();
			$id = New-Guid
			Write-Host (" ==> $me ==> $id")
			$file = "./bound_docs/$id.generated.md"
			$file_leaf = "$id.generated.converted.md"
			Add-Content "$file" "\newpage"
			Add-Content "$file" "# $me"
		} else {
			$file = $file.ToString().Trim()
			$file=$file.ToString().Trim().Split(":")[1].ToString().Trim()

			$file = Join-Path "/data/docs" $file

			if(!(Test-Path $file))
			{
				Write-Error "file doesnt exist : $file"
				exit 5
			}
			$file_leaf = Split-Path -Path $file -Leaf
		}

		$cmd = "pandoc -i $file -o ./bound_docs/$file_leaf --filter CDocsMarkdownCommentRender"
		Write-Host "Converting $file == > $file_leaf"
		Write-Host "    $cmd"
		pandoc -i $file -o ./bound_docs/$file_leaf --filter CDocsMarkdownCommentRender

		if (!(Test-Path "./bound_docs/$file_leaf"))
		{
			throw
		}

		Add-Content "./bound_docs/bind.files" $file_leaf
	}
} finally {
	cd /data/docs
}