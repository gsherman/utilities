@echo off

set NEWLINE=\r\n

set msg=
set "x=0"
:SymLoop1
if defined msg[%x%] (
    set msg[%x%]=
    set /a "x+=1"
    GOTO :SymLoop1
)

set msg[0]=type=calltoolkit
set msg[1]=toolkit=Support
set msg[2]=method=LogCaseNote
set msg[3]=Username=hank
set msg[4]=Notes=These are some notes
set msg[5]=caseIDNum=4158
set msg[6]=AdditionalFields.dev=43	
set msg[7]=AdditionalFields.Internal=These are internal notes 

set "x=0"
set message1=

:SymLoop
if defined msg[%x%] (
    set /a "x+=1"
    set "message1=%message1%%%msg[%x%]%%%NEWLINE%"
    GOTO :SymLoop
)

call c:\bin\publish\publish.exe "%message1%"

