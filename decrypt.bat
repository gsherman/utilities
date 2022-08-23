@echo off

echo.
echo Outdated. Use crypt.bat instead
echo.
goto done



REM todo - remove c:\bin path

echo.
echo *** Decrypt a section of a Configuration file *** 
echo.

if "%1" == "" goto usage 
if "%2" == "" goto usage 

REM %1 = file to be decrypted
REM %2 section within the file to be decrypted

cscript //nologo c:\bin\find_replace.vbs %1 "<configSections>"  "<configSections><!--"
cscript //nologo c:\bin\find_replace.vbs %1 "</configSections>" "--></configSections>"

REM goto done

rename %1 web.config
%windir%\Microsoft.NET\Framework64\v4.0.30319\aspnet_regiis.exe -pdf %2 .
rename web.config %1

cscript //nologo c:\bin\find_replace.vbs %1 "<configSections><!--" "<configSections>" 
cscript //nologo c:\bin\find_replace.vbs %1 "--></configSections>"  "</configSections>" 

goto done

:usage
echo.
echo Missing arguments!
echo Usage: decrypt file-to-be-decrypted section-within-the-file-to-be-decrypted
echo.

:done

