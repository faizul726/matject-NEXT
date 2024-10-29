@echo off
setlocal enabledelayedexpansion

set "title=matjectNEXT v0.1.6"
title %title%
cd %~dp0
:: COLORS
set "GRY=[90m"
set "RED=[91m"
set "GRN=[92m"
set "YLW=[93m"
set "BLU=[94m"
set "CYN=[96m"
set "WHT=[97m"
set "RST=[0m"
set "ERR=[41;97m"

set "gamelocation=%localappdata%\Packages\Microsoft.MinecraftUWP_8wekyb3d8bbwe\LocalState\games\com.mojang"

call "modules\cachePacks"

timeout 2 > NUL
cls
echo !YLW![?] Which method would you like to try?
echo.
echo !GRN![1] Auto!RST!
echo Looks for changes in global resource packs, if any change is detected proceeds to injection with the top most pack.
echo.
echo.
echo !BLU![2] Manual!RST!
echo Injects the top most pack and closes
echo.
choice /c 12 /n
if !errorlevel! neq 1 (echo BOO^^! this is still work in progress && pause && goto:EOF)
cls
title %title% (Watcher mode)
echo [93m[*] Monitoring resource packs...[0m (cooldown 5s)
echo.

:monitor
for /f %%z in ('forfiles /p %gamelocation%\minecraftpe /m global_resource_packs.json /c "cmd /c echo @fdate__@ftime"') do set "modifytime=%%z"
if defined modtime (
    if !modtime! neq !modifytime! (
        echo.
        echo [93m^> Resource packs changed ^(!modifytime!^)[0m
        set "modtime=!modifytime!"
        call "modules\parsePackWithCache"
        echo.
        call "modules\injector"
        goto monitor
    )
    ::else echo ^> No change detected ^(!modtime!^)
    timeout 5 > NUL
    goto monitor
)
set "modtime=!modifytime!"
goto monitor