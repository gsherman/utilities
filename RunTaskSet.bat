@echo off

echo.
echo *** Publish a RunTaskSet message to Dovetail Carrier *** 
echo.

set caseId=%1%
set taskName=%~2%

SET /A ARGS_COUNT=0    
FOR %%A in (%*) DO SET /A ARGS_COUNT+=1    

if not %ARGS_COUNT% == 2 goto usage 

set message="type=RunTaskSet\r\ncaseId=%caseId%\r\nTaskSetName=%taskName%"

c:\bin\publish\Publish.exe %message%

goto done

:usage
echo.
echo Missing arguments!
echo Usage: RunTaskSet caseId taskSetName
echo Example: RunTaskSet 247 "get Stock Quote"
echo.


:done
