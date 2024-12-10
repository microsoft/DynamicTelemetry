@echo off

cat mkdocs.yml  | grep "\.md" | gawk 'BEGIN{FS=":"}{print $2}' > 2glue.file

pushd docs

set OUTPUT_DIR=C:\Source\DynamicTelemetry\docs\docx
set FINAL_FILE=Final.docx

IF NOT EXIST %OUTPUT_DIR% (
	mkdir %OUTPUT_DIR%
)

cp %OUTPUT_DIR%\FrontPage.docx %OUTPUT_DIR%\%FINAL_FILE%

dir

for /F %%i in (..\2glue.file) DO (
	cdocs-render %%i
	
	echo.
	echo.
	echo.
	echo.
	echo "Copying %%i.docx to %OUTPUT_DIR%"
	echo copy %%i.docx %OUTPUT_DIR% >> x.bat
)

popd