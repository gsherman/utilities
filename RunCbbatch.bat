@echo off
cd C:\clarify\11.5\Server\rulemgr
REM %*

start %SystemRoot%\SYSWOW64\cmd.exe /k  C:\clarify\11.5\Server\dbadmin\cbbatch -db_server . -db_name dovetail -user_name sa -password sa -f C:\dovetail\cbbatch_testing\search.cbs -r main %*

