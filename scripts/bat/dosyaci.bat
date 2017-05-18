@ECHO OFF

C:\DOS\XSET DAY DAYOFWEEK
IF NOT "%DAY%" == "1" GOTO END

:BACKUP
C:\DOS\XSET CUR-DATE DATE YY-MM-DD
IF EXIST C:\BACKUP\%CUR-DATE%.ZIP GOTO FILE
C:\UTIL\PKZIP\PKZIP C:\BACKUP\%CUR-DATE%.ZIP C:\DATA\*.*

XXCOPY C:\BACKUP\*.ZIP /DB#90 /RSY /PD0 /ED
GOTO END

:FILE
ECHO.
ECHO    %CUR-DATE%.ZIP File Already Exists!
ECHO      No Additional Backup Performed.
ECHO.

:END
SET DAY=
SET CUR-DATE=