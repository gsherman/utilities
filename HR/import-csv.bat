@echo off
echo.
if "%1" == "" goto usage 

set EmployeeMigrator=C:\repo\blue\agent\source\EmployeeMigrator\bin\Debug\EmployeeMigrator.exe

set dryRun=true 
IF "%3%" == "dryrun" (
  set dryRun=true
  echo [92musing dryRun mode, so no data will actually be imported...[0m
)

IF "%2%" == "new" (
	echo [92musing the new employee importer...[0m
	REM echo using the new employee importer...
	echo. 
	%EmployeeMigrator% import-csv --host localhost -f %1 --do-not-import-data %dryRun%
) ELSE ( 
	echo [92musing the legacy employee importer...[0m
	REM echo using the legacy employee importer...
	echo. 
	%EmployeeMigrator% import-csv --host localhost -f %1 --use-legacy-import true 
)

goto done

:usage
echo [101;93mMissing arguments![0m
echo Usage: import-csv file_to_be_imported [legacy_or_new (default is legacy) ] [dryrun (only for new importer)]
echo.

:done