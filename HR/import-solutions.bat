@echo off
echo.

REM validate that the first parameter has been passed in (which should be the excel filename)
if "%1" == "" goto usage 

REM location of blue.exe
set blue=C:\repo\blue\agent\source\blue\bin\Debug\blue.exe

REM setup the dryrun option
set dryRun=
IF "%2%" == "dryrun" (
  set dryRun=--do-not-import-data
  echo [92musing dryRun mode, so no data will actually be imported[0m
  echo.
)

echo [92mwriting logs to import-solutions.log[0m

REM do the import
%blue% importsolutionsfromexcel %1 %dryrun% > import-solutions.log

REM get the latest HTML file, which should be the storyteller report of the import
FOR /F "delims=" %%I IN ('DIR "*.html" /A-D /B /O:D') DO SET NewestHtmlFile=%%I

REM open that html file
start %NewestHtmlFile%

goto done

:usage
echo [101;93mMissing arguments![0m
echo Usage: import-solutions excel-file_to_be_imported [dryrun]
echo.

:done

REM "blue.exe importsolutionsfromexcel" OPTIONS, for reference:
REM 	excelfilename -> The path to an Excel (XLSX) file which contains a worksheet named "Data" from which data will be imported
REM 	[-b, --batch-size <batchsize>] -> How many items the importer will attempt to save at one time (default: 2)
REM 	[-d, --do-not-import-data] -> By default, data will attempt to be imported if all prior steps succeed.  Include this flag to validate but not import data.
REM 	[-s, --allow-schema-validation-warnings] -> By default, schema validation warnings cause the command to fail.  Include this flag to allow schema validation warnings without failure.
REM 	[-v, --allow-data-validation-warnings] -> By default, data validation warnings cause the command to fail.  Include this flag to allow data validation warnings without failure.
