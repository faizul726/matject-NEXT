@echo off
setlocal enabledelayedexpansion

set "gamelocation=%localappdata%\Packages\Microsoft.MinecraftUWP_8wekyb3d8bbwe\LocalState\games\com.mojang"

:monitor
for /f %%z in ('forfiles /p %gamelocation%\minecraftpe /m global_resource_packs.json /c "cmd /c echo @fdate_@ftime"') do set "modifytime=%%z"
if defined modtime (
    if !modtime! neq !modifytime! (
        echo File is modified. New time is !modifytime!
        set "modtime=!modifytime!"
        call parsePackName
    ) else echo File is not modified. ^(!modtime!^)
    timeout 5 > NUL
    goto monitor
)
set "modtime=!modifytime!"
goto monitor