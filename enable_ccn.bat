@echo off
REM Make sure they supplied 1 param - which is the DB name
REM If they didn't, show usage & exit

if "%1" == "" goto usage 

REM Hard-coded values
SET LOGIN_NAME=sa
SET PASSWORD=sa
SET SERVER=localhost

sqlcmd -Usa -Psa -d%1 -i enable_ccn.sql 

goto done

:usage
echo.
echo Usage: enable_ccn db_name
echo.

:done
