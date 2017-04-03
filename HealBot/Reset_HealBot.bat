:: HealBot_Clean_WTF.bat
::
:: Deletes All healbot text files from WTF
::
:: This must be run from the Healbot addon directory
::
:: Use this if your getting nil errors with HealBot.
::

@ECHO OFF
set WD=%CD:~-9,9%
set HBDIR=s\HealBot


if /i NOT %WD%==%HBDIR% goto ERRHB

CLS
ECHO.
ECHO.
ECHO  Press D - Clean Healbot files in your WTF directory
ECHO.
ECHO  Any other key - Do NOTHING and exit
ECHO.

SET /P GOWHERE=Enter D to Delete: 

if /i %GOWHERE%==D goto DELHB

goto SKIP

:DELHB

cls

del /s ..\..\..\WTF\Account\Healbot.*

echo.
echo.
echo Deleted all healbot text files from WTF sub-directories ** Completed **
echo.

goto DONE

:SKIP

echo.
echo  D NOT pressed - NOTHING DELETED
echo.

goto DONE

:ERRHB

echo.
echo ERROR - Running in the wrong Directory
echo ERROR - Run this in the addons own directory .\Interface\AddOn%HBDIR%
echo.

goto DONE

:DONE

pause
EXIT