@echo off

REM depends on find_replace.vbs, assumed to be in same directory as this file (crypt.bat)

echo.
echo *** Encrypt/Decrypt a section of a Configuration file *** 
echo.

if "%1" == "" goto usage 
if "%2" == "" goto usage 
if "%3" == "" goto usage 

set operation=e
set options=-prov DataProtectionConfigurationProvider

if "%1" == "decrypt" (
	set operation=d
	set options=
	) 
if "%1" == "d" (
	set operation=d
	set options=
	) 

cscript //nologo  "%~dp0find_replace.vbs" %2 "<configSections>"  "<configSections><!--"
cscript //nologo  "%~dp0find_replace.vbs" %2 "</configSections>" "--></configSections>"

rename %2 web.config
%windir%\Microsoft.NET\Framework64\v4.0.30319\aspnet_regiis.exe -p%operation%f %3 . %options%
rename web.config %2

cscript //nologo  "%~dp0find_replace.vbs" %2 "<configSections><!--" "<configSections>" 
cscript //nologo  "%~dp0find_replace.vbs" %2 "--></configSections>"  "</configSections>" 

goto done

:usage
echo.
echo Missing arguments!
echo Usage: crypt.bat operation(encrypt or decrypt) file-to-be-crypted section-within-the-file-to-be-crypted
echo.

:done
