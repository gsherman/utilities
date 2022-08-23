@echo off
REM Make sure they supplied 1 param - which is the DB name
REM If they didn't, show usage & exit

echo.
echo *** DIET archive utility, including license and sql logging *** 
echo.

if "%1" == "" goto usage 
if "%2" == "" goto usage 

SET DAY=%DATE:~4,2%
SET MTH=%DATE:~7,2%
SET YR=%DATE:~10,4%
SET HR=%TIME:~0,2%
SET HR0=%TIME:~0,1%
IF "%HR0%"==" " SET HR=0%TIME:~1,1%
SET MIN=%TIME:~3,2%
SET SEC=%TIME:~6,2%
SET MYDATE=%YR%%MTH%%DAY%-%HR%%MIN%%SEC%

goto skip_timing

SETLOCAL ENABLEEXTENSIONS
:: Store start time
FOR /f "tokens=1-4 delims=:.," %%T IN ("%TIME%") DO (
	SET StartTIME=%TIME%
	SET /a Start100S=%%T*360000+%%U*6000+%%V*100+%%W
)

:skip_timing

REM checksum the directives file:
REM c:\bin\diet.exe -user_name sa -password sa -db_server . -db_name %1 -directive %2 -checksum SECRET -archive

c:\bin\diet.exe -index_no_create -p_template index_template.txt -license SECRET -user_name sa -password sa -db_server . -db_name %1 -export purged_data_%MYDATE%.dat -purge -dir %2 -sqllog sql.log  -report 100 -objid -eindex -no_stopif %3 %4 %5 %6 %7 %8 %9

goto skip_timing2

:: Retrieve Stop time
FOR /f "tokens=1-4 delims=:.," %%T IN ("%TIME%") DO (
	SET StopTIME=%TIME%
	SET /a Stop100S=%%T*360000+%%U*6000+%%V*100+%%W
)

:: Test midnight rollover. If so, add 1 day=8640000 1/100ths secs
IF %Stop100S% LSS %Start100S% SET /a Stop100S+=8640000
SET /a TookTime=%Stop100S%-%Start100S%

echo.
ECHO Started: %StartTime%
ECHO Stopped: %StopTime%
ECHO Elapsed: %TookTime:~0,-2%.%TookTime:~-2% seconds
echo.

:skip_timing2

goto done

:usage
echo.
echo Missing arguments!
echo Usage: purge db_name directive_file
echo.

:done

