@echo off

echo.
echo *** Publish a CalculateNextDueDate message to Dovetail Carrier *** 
echo.

set caseId=%1%
set actEntryObjid=%2%

SET /A ARGS_COUNT=0    
FOR %%A in (%*) DO SET /A ARGS_COUNT+=1    

if not %ARGS_COUNT% == 2 goto usage 

set message="type=CalculateNextDueDate\r\nCaseId=%caseId%\r\nActEntryObjid=%actEntryObjid%"

c:\bin\publish\Publish.exe %message%

goto done

:usage
echo.
echo Missing arguments!
echo Usage: CalculateNextDueDate caseId actEntryObjid
echo Example: CalculateNextDueDate 247 "268435457
echo.


:done
