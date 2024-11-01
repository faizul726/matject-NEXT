@echo off
setlocal enabledelayedexpansion
if not defined murgi echo [41;97mYou can't open me directly[0m :P & cmd /k

if not exist ".settings\.bins.log" (
    echo !YLW![*] Already using vanilla materials, no need to restore.!RST!
    goto:EOF
)

if "!RESTORETYPE!" equ "full" (
    echo !RED!WORK IN PROGRESS... IT WON'T WORK.!RST!
    echo.
    echo Press any key to exit...
    pause > NUL & exit
)

if exist "tmp\" (
    rmdir /s /q tmp
    mkdir "tmp"
) else (
    mkdir "tmp"
)

:partialRestore
echo [*] Restoring modified materials from last injection...
    set /p BINS2=< ".settings\.bins.log"
    set /p replaceList2=< ".settings\.replaceList.log"
    robocopy "materials.bak" "tmp" !BINS2! /NFL /NDL /NJH /NJS /nc /ns /np


:restore1
for %%f in (tmp\*) do (
    set SRCLIST2=!SRCLIST2!,"%cd%\%%f"
)
set "SRCLIST2=%SRCLIST2:~1%"

"%ProgramFiles(x86)%\IObit\IObit Unlocker\IObitUnlocker" /advanced /delete %replaceList2%
if !errorlevel! neq 0 (
    echo [41;97m[^^!] Please accept UAC.[0m
    echo.
    pause
    cls
    goto restore1
) else (
    echo [92m[*] Partial restore: Step 1/2 succeed^^![0m
)

echo.

:restore2
"%ProgramFiles(x86)%\IObit\IObit Unlocker\IObitUnlocker" /advanced /move !SRCLIST2! "!MCLOCATION!\data\renderer\materials"
if !errorlevel! neq 0 (
    echo [41;97m[^^!] Please accept UAC.[0m
    echo.
    pause
    cls
    goto restore2
) else (
    echo [92m[*] Partial restore: Step 2/2 succeed^^![0m
    echo.
    echo.
    del /q /s ".settings\.replaceList.log" > NUL
    del /q /s ".settings\.bins.log" > NUL
    timeout 2 > NUL
    goto:EOF
)

:completed
cls
if exist ".settings\.replaceList.log" del /q /s ".settings\.replaceList.log" > NUL
if exist ".settings\.bins.log" del /q /s ".settings\.bins.log" > NUL

if exist ".settings\taskOngoing.txt" del /q /s ".settings\taskOngoing.txt" > NUL
