@echo off

cat mkdocs.yml  | grep "\.md" | gawk 'BEGIN{FS=":"}{print $2}' > 2glue.file

pushd docs

set OUTPUT_DIR=c:\Source\TelAnalytics\BigRed\PoC_LookoutTower\docs\web\docs\Output
set FINAL_FILE=Final.docx

IF NOT EXIST %OUTPUT_DIR% (
	mkdir %OUTPUT_DIR%
)

copy %OUTPUT_DIR%\FrontPage.docx %OUTPUT_DIR%\%FINAL_FILE%

dir

for /F %%i in (..\2glue.file) DO (
	echo "MERGING : %%i"
	ls %%i -l
	cat "%%i"  >> %OUTPUT_DIR%\Final.document.md
)

call cdocs-render %OUTPUT_DIR%\Final.document.md -OutputDir %OUTPUT_DIR%

popd