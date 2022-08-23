@echo off
echo.
echo Clear Clarify cache
echo. 
SET DIR=C:\clarify\11.5\client\ClarifyClient
SET DELETE=DEL /F /Q
REM -fqv

echo Deleting...
echo.

%DELETE% %DIR%\*.cfy
%DELETE% %DIR%\*.058
%DELETE% %DIR%\cbcache\*
%DELETE% %DIR%\server.log
%DELETE% %DIR%\standard.out
%DELETE% %DIR%\cbex.log

echo.
