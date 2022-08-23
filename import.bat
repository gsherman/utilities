@echo off
REM Make sure they supplied 1 param - which is the DB name
REM If they didn't, show usage & exit

echo.
echo *** DIET import utility, including license and sql logging *** 
echo.

if "%1" == "" goto usage 
if "%2" == "" goto usage 

REM c:\bin\diet.exe 
REM C:\bin\diet\2.2.0\mssql\diet.exe
REM C:\bin\diet\2.2.1\mssql\diet.exe

C:\bin\diet.exe -pick_one -license 655934BB -user_name sa -password sa -db_server . -db_name %1 -import %2 -objid -mto "last_close2case" -mto "reject_reason2case" %3 %4 %5 %6 
REM -sqllog sql.log -log_file diet.log -mes_file diet.mes
REM -parser -pparser -errors_max 200 -bad_fields 
REM -lite

goto done

:usage
echo.
echo Missing arguments!
echo Usage: import db_name file_to_be_imported [option1] [option2] [option3] [option4]
echo.

:done

