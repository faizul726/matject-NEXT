@echo off
if not defined murgi echo [41;97mYou can't open me directly[0m :P & cmd /k

set "toggleOff=[ ]"
set "toggleOn=!GRN![x]!RST!"

:settings
title %title% settings
cls

if exist %disableModuleVerification% (set toggle1=!toggleOn!) else (set toggle1=!toggleOff!)
if exist %thanksMcbegamerxx954% (
    if not exist "modules\material-updater.exe" (
        del /q /s %thanksMcbegamerxx954%
        set toggle2=!toggleOff!
    ) else (set toggle2=!toggleOn!)
) else (set toggle2=!toggleOff!)

if exist %disableInjectionPrompt% (set toggle3=!toggleOn!) else (set toggle3=!toggleOff!)
if exist %disableInterruptionCheck% (set toggle4=!toggleOn!) else (set toggle4=!toggleOff!)
if exist %useAutoAlways% (set toggle5=!toggleOn!) else (set toggle5=!toggleOff!)
if exist %useManualAlways% (set toggle6=!toggleOn!) else (set toggle6=!toggleOff!)


echo ^< [B] Back
echo.
echo.

echo !YLW!Here you can change how matjectNEXT works.!RST!
echo.
echo.

echo !toggle1! 1. Disable module verification
echo !toggle2! 2. Use material-updater to update materials (fixes invisible blocks)
echo !toggle3! 3. Disable injection confirmation
echo !toggle4! 4. Disable interruption check
echo !toggle5! 5. Use auto mode always
echo !toggle6! 6. Use manual mode always
echo.
echo !toggleOff! 7. Use custom Minecraft app path (WIP)
echo !toggleOff! 8. Use custom Minecraft data path (WIP)
echo !toggleOff! 9. Use custom IObit Unlocker path (WIP)
echo.
echo.
echo !YLW!Press corresponding key to toggle desired option.!RST!
echo.
choice /c 123456789b /n

goto toggle!errorlevel!

:toggle1
if not exist %disableModuleVerification% (echo. > %disableModuleVerification%) else (del /q /s %disableModuleVerification% > NUL) 
goto settings

:toggle2
if exist %thanksMcbegamerxx954% (del /q /s %thanksMcbegamerxx954% > NUL && goto settings) 

if not exist "modules\material-updater.exe" (call "modules\getMaterialUpdater") else (if not exist %thanksMcbegamerxx954% (echo. > %thanksMcbegamerxx954%))
goto settings

:toggle3
if not exist %disableInjectionPrompt% (echo. > %disableInjectionPrompt%) else (del /q /s %disableInjectionPrompt% > NUL)
goto settings

:toggle4
if not exist %disableInterruptionCheck% (echo. > %disableInterruptionCheck%) else (del /q /s %disableInterruptionCheck% > NUL)
goto settings

:toggle5
if not exist %useAutoAlways% (
    if exist %useManualAlways% del /q /s %useManualAlways% > NUL
    echo. > %useAutoAlways%
    ) else (del /q /s %useAutoAlways% > NUL)        
goto settings

:toggle6
if not exist %useManualAlways% (
    if exist %useAutoAlways% del /q /s %useAutoAlways% > NUL
    echo. > %useManualAlways%
    ) else (del /q /s %useManualAlways% > NUL)
goto settings

:toggle7
:toggle8
:toggle9
goto settings

:toggle10
goto:EOF