@echo off
REM setlocal EnableDelayedExpansion

echo.
echo *** Publish a dovetail sdk toolkit message to Dovetail Carrier *** 
echo.

set action=%1%
set caseId=%2%
set recipient=craig@localhost.com
set msg=

set "x=0"
:SymLoop1
if defined msg[%x%] (
    set msg[%x%]=
    set /a "x+=1"
    GOTO :SymLoop1
)

SET /A ARGS_COUNT=0    
FOR %%A in (%*) DO SET /A ARGS_COUNT+=1    
if not %ARGS_COUNT% == 2 goto usage 

set NEWLINE=\r\n

IF "%action%" == "RefreshCache" (
	set msg[0]=type=RefreshCache
)


IF "%action%" == "autodest" (
	set msg[0]=type=calltoolkit
	set msg[1]=toolkit=AutoDest
	set msg[2]=method=execute	
	set msg[3]=ObjectType=case
	set msg[4]=operation=DISPATCH
	set msg[5]=Id=%caseId%
)
REM ASSIGN, ASSIGN, EMC_DISPATCH, WEB_DISPATCH


IF "%action%" == "note" (
	set msg[0]=type=calltoolkit
	set msg[1]=toolkit=Support
	set msg[2]=method=LogCaseNote
	set msg[3]=Username=hank
	set msg[4]=Notes=These are some notes from call-toolkit.bat
	set msg[5]=caseIDNum=%caseId%
	REM set msg[6]=LogDate=7/16/2016 15:31:00
	REM set msg[7]=AdditionalFields.dev=43	
	REM set msg[8]=AdditionalFields.Internal=These are internal notes 

)

IF "%action%" == "email" (
	set msg[0]=type=calltoolkit
	set msg[1]=toolkit=Support
	set msg[2]=method=LogCaseEmail
	set msg[3]=Username=hank
	set msg[4]=Message=This is a *markdown* **formatted** log email from call-toolkit.bat. 
	set msg[5]=caseIDNum=%caseId%
	set msg[6]=Recipient=%recipient%
)

IF "%action%" == "assign" (
	set msg[0]=type=calltoolkit
	set msg[1]=toolkit=Support
	set msg[2]=method=AssignCase
	set msg[3]=caseIDNum=%caseId%
	set msg[4]=NewUser=hank
)

IF "%action%" == "initial-response" (
	set msg[0]=type=calltoolkit
	set msg[1]=toolkit=Support
	set msg[2]=method=Initialresponse
	set msg[3]=caseIDNum=%caseId%
	set msg[4]=Username=annie
)

IF "%action%" == "create-contact" (
	set msg[0]=type=calltoolkit
	set msg[1]=toolkit=Interfaces
	set msg[2]=method=CreateContact
	set msg[3]=firstName=Claude
	set msg[4]=lastname=Johnson
	set msg[5]=phone=800-555-9999
	set msg[6]=siteIdNum=56
)

IF "%action%" == "close-case" (
	set msg[0]=type=calltoolkit
	set msg[1]=toolkit=Support
	set msg[2]=method=CloseCase
	set msg[3]=caseIDNum=%caseId%
	set msg[4]=Resolution=Software Shipped
	set msg[5]=AdditionalFields.x_done_in_one=1
)

IF "%action%" == "reopen-case" (
	set msg[0]=type=calltoolkit
	set msg[1]=toolkit=Support
	set msg[2]=method=ReopenCase
	set msg[3]=CaseIdNum=%caseId%
	set msg[4]=UserName=carrier
)

REM this doesn't work:
IF "%action%" == "incoming-email" (
	set msg[0]=type=urn:message:Dovetail.Carrier.Messages:IncomingEmailMessageImplementation
	set msg[1]=emailAccountUserName=dmhc-support@localhost.com
	set msg[2]=emailAccountHostName=localhost
	set msg[3]=id=id-0796ABF883AC4D3E863A272415830725@V10.eml
	set msg[4]=to=dmhc-support@localhost.com
	set msg[5]=from=perfect@localhost.com
	set msg[6]=subject=Re: About Case 6402 : details go here
	set msg[7]=body=thanks for the info!
	REM set msg[9]=type=urn:message:Dovetail.Carrier.Messages:IIdentifiedMessage
)

if not defined msg[0] (
	echo Invalid action
	goto usage
)


set "x=0"
set message1=

:SymLoop
if defined msg[%x%] (
    set /a "x+=1"
    set "message1=%message1%%%msg[%x%]%%%NEWLINE%"
    GOTO :SymLoop
)


call c:\bin\publish\publish.exe "%message1%"

goto done


:usage
	@echo:
	echo Usage: call-toolkit.bat action caseId
	echo Example: call-toolkit note 12345
	echo.
	echo  valid actions: 
	echo     note              - logs a note to a case
	echo     email             - logs an outgoing email to a case. send to: %recipient%
	echo     create-contact    - creates a contact (caseId param is ignored)
	echo     initial-response  - logs an initial response activity to a case
	echo     assign            - assigns a case
	echo     autodest          - automatically dispatches a case based on auto-dest rules
	echo     refreshcache      - refresh Carrier's internal cache 
	@echo:
	goto done


:unused

	REM message should look like:
	REM type=calltoolkit
	REM toolkit=Support
	REM method=AssignCase
	REM caseIDNum=12345
	REM NewUser=annie

	set LF="\r\n"
	
	REM sad path testing - log case notes - missing required property of case id num
	REM set message="type=calltoolkit%NEWLINE%toolkit=Support%NEWLINE%method=LogCaseNote%NEWLINE%Username=annie%NEWLINE%Notes=These are notes from the call-toolkit.bat file"

	REM sad path testing - bad toolkit name
	REM set message="type=calltoolkit%NEWLINE%toolkit=foo%NEWLINE%method=LogCaseNote%NEWLINE%caseIDNum=3048%NEWLINE%Username=annie%NEWLINE%Notes=These are notes from the call-toolkit.bat file"

	REM sad path testing - bad method name
	REM set message="type=calltoolkit%NEWLINE%toolkit=Support%NEWLINE%method=LogFoo%NEWLINE%caseIDNum=3048%NEWLINE%Username=annie%NEWLINE%Notes=These are notes from the call-toolkit.bat file"

	REM assign 
	REM set message="type=calltoolkit%NEWLINE%toolkit=Support%NEWLINE%method=AssignCase%NEWLINE%caseIDNum=247%NEWLINE%NewUser=annie"

	REM initial response
	REM set message="type=calltoolkit%NEWLINE%toolkit=Support%NEWLINE%method=Initialresponse%NEWLINE%caseIDNum=3048%NEWLINE%Username=annie"

	REM close subcase
	REM set message="type=calltoolkit%NEWLINE%toolkit=Support%NEWLINE%method=closesubcase%NEWLINE%subcaseIDNum=247-1%NEWLINE%Username=annie%NEWLINE%resolution=equipment repaired"

	REM create contact - Interfaces toolkit
	REM set message="type=calltoolkit%LF%toolkit=Interfaces%LF%method=CreateContact%LF%firstName=Claude%LF%lastname=Johnson%LF%phone=800-555-8888%LF%siteIdNum=56"

	REM log case notes
	REM set message="type=CallToolkit%NEWLINE%toolkit=Support%NEWLINE%method=LogCaseNote%NEWLINE%caseIDNum=3048%NEWLINE%Username=annie%NEWLINE%Notes=These are notes from the call-toolkit.bat file"

	REM c:\bin\publish\Publish.exe %message%
	REM call publish.bat "%message1%"

	goto done

:done
