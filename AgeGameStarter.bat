rem ###############################################################################################
rem  Age Game Starter Bat.
rem  
rem  version 1.0.0
rem  How to Use. Please read me.
rem  Repository "https://github.com/pachimonopower/AgeGameStarter"
rem ###############################################################################################

echo off

REM ■Define Game FileName
set mavFileName=マブラヴ14.exe
set mavGameName=マブラヴLatest
set mavRioFileName=muvluv14

set mavaltFileName=マブラヴオルタネイティヴ14.exe
set mavaltGameName=マブラヴオルタネイティヴLatest
set mavaltRioFileName=alternative14

set kiminozoFileName=君が望む永遠LE.exe
set kiminozoGameName=君が望む永遠LE
set kiminozoRioFileName=君望LE

REM ■Get Current Directory
set currentDir=%~dp0
set currentDir=%currentDir:~0,-1%
cd %currentDir%

REM ■Setting Game File

REM マブラヴ14
if exist %mavFileName% (
    set GameName=%mavGameName%
    set RioFile=%mavRioFileName%
    goto MAIN_PROC
)

REM マブラヴオルタネイティヴ14
if exist %mavaltFileName% (
    set GameName=%mavaltGameName%
    set RioFile=%mavaltRioFileName%
    goto MAIN_PROC
)

REM 君が望む永遠LE
if exist %kiminozoFileName% (
    set GameName=%kiminozoGameName%
    set RioFile=%kiminozoRioFileName%
    goto MAIN_PROC
)

goto ERROR_PROC

REM ■Change Key Value
:MAIN_PROC

REM 1. Installation
set installation="HKEY_CURRENT_USER\SOFTWARE\relic UGP Applications\age\%GameName%\Installation"
reg add %installation% /v strAbsolutePath /t REG_SZ /d %currentDir% /f
reg add %installation% /v strIciPath /t REG_SZ /d %currentDir%\%RioFile%.rio.ici /f
reg add %installation% /v strObjectOcean /t REG_SZ /d %currentDir%\%RioFile%.rio /f

REM 2. rUGPBasic
set rUGPBasic="HKEY_CURRENT_USER\SOFTWARE\relic UGP Applications\age\%GameName%\rUGPBasic"
reg add %rUGPBasic% /v strRugpPluginFolder /t REG_SZ /d %currentDir%\Plugins /f

REM 3. rvmmInstallation
set rvmmInstallation="HKEY_CURRENT_USER\SOFTWARE\relic UGP Applications\age\%GameName%\rvmmInstallation"
reg add %rvmmInstallation% /v strFontCachePath /t REG_SZ /d %currentDir% /f
reg add %rvmmInstallation% /v strVirtuaRegistryAbsolutePath /t REG_SZ /d %currentDir%\Vmreg\ /f

REM ■Run Game. Enjoy!!
if exist %mavFileName% (
    %mavFileName%
    goto PROC_END
)

if exist %mavaltFileName% (
    %mavaltFileName%
    goto PROC_END
)

if exist %kiminozoFileName% (
    %kiminozoFileName%
    goto PROC_END
)

:ERROR_PROC
echo msgbox "Sorry. This is Game Not Compatible.",vbCritical,"Start Failure" > %TEMP%/msgboxtest.vbs & %TEMP%/msgboxtest.vbs

:PROC_END