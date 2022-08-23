@echo off
REM Make sure they supplied 1 param - which is the DB name
REM If they didn't, show usage & exit

echo.
echo *** DIET archive utility, including license and sql logging *** 
echo.

if "%1" == "" goto usage 
if "%2" == "" goto usage 

REM c:\bin\diet.exe 
REM C:\bin\diet\2.2.0\mssql\diet.exe
REM C:\bin\diet\2.2.1\mssql\diet.exe

C:\bin\diet.exe -expdef -license SECRET -user_name sa -password sa -db_server . -db_name %1 -export archived.dat -archive -dir %2 -mes_file archive.mes -query -parser -pparser -log_file archive.log -sqllog sql.log
REM -sqllog sql.log  -objid -report 100 -no_stopif %3 %4 %5 %6 %7 %8 %9 
REM -mes_file archive.mes -query -parser -pparser -log_file archive.log -sqllog sql.log

goto done

:usage
echo.
echo Missing arguments!
echo Usage: archive db_name directive_file
echo.

:done

