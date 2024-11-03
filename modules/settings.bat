@echo off
if not defined murgi echo [41;97mYou can't open me directly[0m :P & cmd /k

set "toggleOff=!GRY![ ]!RST!"
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
if exist %customMinecraftPath% (set toggle7=1) else (set "toggle7=")
if exist ".settings\debugMode.txt" (set toggle10=!RED![ON]!RST!) else (set toggle10=!GRN![OFF]!RST!)


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

if not defined toggle7 (
    echo !toggleOff! 7. Use custom Minecraft app path ^(makes Matject start faster^) 
) else (
    echo !toggleOn! 7. Use custom Minecraft app path
)

echo !toggleOff! 8. Use custom Minecraft data path (WIP)
echo !toggleOff! 9. Use custom IObit Unlocker path (WIP)
echo.
echo !GRY![D] DEBUG MODE ^(shows extra info^) !toggle10!!RST!
echo.
echo.
echo !YLW!Press corresponding key to toggle desired option.!RST!
echo.
choice /c 123456789bd /n

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
if defined toggle7 (
    del /q /s %customMinecraftPath% > NUL
    goto settings
)
cls
set setCustomMinecraftPath=
echo ^< [B] Back
echo.
echo.

echo !YLW![?] How would you like to set custom Minecraft path?!RST!
echo.
echo.

echo [1] Use retrieved Minecraft path ^(!GRN!!MCLOCATION!!RST!!^)
echo [2] Use user provided Minecraft path
echo.
choice /c b12 /n

if !errorlevel! equ 1 goto settings

if !errorlevel! equ 2 (
    echo !MCLOCATION!>%customMinecraftPath%
    goto settings
)
if !errorlevel! equ 3 (
    cls
    set /p "setCustomMinecraftPath=!YLW![*] Type your custom Minecraft path ^(make sure not to include unnecessary space. Leave blank to cancel^):!RST! "
    echo.
    if not defined setCustomMinecraftPath (
        goto settings
    ) else (
        echo !setCustomMinecraftPath!
        pause
        if exist "!setCustomMinecraftPath!\AppxManifest.xml" (
            if exist "!setCustomMinecraftPath!\Minecraft.Windows.exe" (
                echo !setCustomMinecraftPath!>%customMinecraftPath%
                goto settings
            )
        )
    )
)
echo !ERR![^^!] Invalid Minecraft path.!RST!
echo.
echo Press any key to go back...
pause > NUL
goto settings

:toggle8
:toggle9
goto settings

:toggle10
goto:EOF

:toggle11
if not exist ".settings\debugMode.txt" (echo You are now a developer^^! [%date% - %time%]>".settings\debugMode.txt") else (del /q /s ".settings\debugMode.txt" > NUL)
goto settings
