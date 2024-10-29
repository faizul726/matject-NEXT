@echo off
setlocal enabledelayedexpansion
title matjectNEXT (Watcher mode)
set "gamelocation=%localappdata%\Packages\Microsoft.MinecraftUWP_8wekyb3d8bbwe\LocalState\games\com.mojang"

echo [93m[*] Monitoring resource packs...[0m (cooldown 5s)
echo.

:monitor
for /f %%z in ('forfiles /p %gamelocation%\minecraftpe /m global_resource_packs.json /c "cmd /c echo @fdate__@ftime"') do set "modifytime=%%z"
if defined modtime (
    if !modtime! neq !modifytime! (
        echo.
        echo [93m^> Resource packs changed ^(!modifytime!^)[0m
        set "modtime=!modifytime!"
        call parsePackName
        echo.
        goto monitor
    ) else echo ^> No change detected ^(!modtime!^)
    timeout 5 > NUL
    goto monitor
)
set "modtime=!modifytime!"
goto monitor