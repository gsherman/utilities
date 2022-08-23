@echo off
REM Make sure they supplied 1 param - which is the DB name
REM If they didn't, show usage & exit

echo.
echo *** DIET export utility, including license and sql logging *** 
echo.

if "%1" == "" goto usage 
if "%2" == "" goto usage 

c:\bin\diet.exe -license SECRET -user_name sa -password sa -db_server . -db_name %1 -export exported.dat -dir %2 -sqllog sql.log -archive

goto done

:usage
echo.
echo Missing arguments!
echo Usage: export db_name directive_file
echo.

:done

