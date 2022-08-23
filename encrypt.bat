@echo off

echo.
echo Outdated. Use crypt.bat instead
echo.
goto done



echo.
echo *** Encrypt a section of a Configuration file *** 
echo.

if "%1" == "" goto usage 
if "%2" == "" goto usage 


rename %1 web.config
%windir%\Microsoft.NET\Framework64\v4.0.30319\aspnet_regiis.exe -pef %2 . -prov DataProtectionConfigurationProvider
rename web.config %1

goto done

:usage
echo.
echo Missing arguments!
echo Usage: encrypt file-to-be-encrypted section-within-the-file-to-be-encrypted
echo.

:done
