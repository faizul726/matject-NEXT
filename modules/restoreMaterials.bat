@echo off
setlocal enabledelayedexpansion
if not defined murgi echo [41;97mYou can't open me directly[0m :P & cmd /k

if defined debugMode echo RESTORING MATS
if defined debugMode pause

if not exist ".settings\.bins.log" (
    echo !YLW![*] Already using vanilla materials, no need to restore.!RST!
    pause
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
if defined debugMode echo BIN2=!BINS2!
if defined debugMode echo RPLC2=!replaceList2!
set /p BINS2=<".settings\.bins.log"
set /p replaceList2=<".settings\.replaceList.log"

set REPLACELIST2=!REPLACELIST2:_=%MCLOCATION%\data\renderer\materials\!
set REPLACELIST2=!REPLACELIST2:-=.material.bin!

if defined debugMode echo BIN2REBORN=!BINS2!
if defined debugMode echo RPLC2REBORN=!replaceList2!

if defined debugMode echo robocopy start
robocopy "materials.bak" "tmp" !BINS2! /NFL /NDL /NJH /NJS /nc /ns /np
if defined debugMode echo robocopy end

:restore1
if defined debugMode echo SRC2=!SRCLIST2!
for %%f in (tmp\*) do (
    set SRCLIST2=!SRCLIST2!,"%cd%\%%f"
)
set "SRCLIST2=%SRCLIST2:~1%"

if defined debugMode echo SRC2REBORN=!SRCLIST2!

if defined debugMode echo "%ProgramFiles(x86)%\IObit\IObit Unlocker\IObitUnlocker" /advanced /delete !replaceList2!
if defined debugMode pause

"%ProgramFiles(x86)%\IObit\IObit Unlocker\IObitUnlocker" /advanced /delete !replaceList2!
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

if defined debugMode echo "%ProgramFiles(x86)%\IObit\IObit Unlocker\IObitUnlocker" /advanced /move !SRCLIST2! "!MCLOCATION!\data\renderer\materials"
pause
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

if defined debugMode echo COMPLETE RSTR
if defined debugMode pause

cls
if exist ".settings\.replaceList.log" del /q /s ".settings\.replaceList.log" > NUL
if exist ".settings\.bins.log" del /q /s ".settings\.bins.log" > NUL

if exist ".settings\taskOngoing.txt" del /q /s ".settings\taskOngoing.txt" > NUL

if defined debugMode echo closed RSTR