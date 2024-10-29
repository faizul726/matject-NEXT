@echo off
setlocal enabledelayedexpansion
echo [93m[*] Listing resource_packs...[0m
echo.
for /d %%D in ("%localappdata%\Packages\Microsoft.MinecraftUWP_8wekyb3d8bbwe\LocalState\games\com.mojang\resource_packs\*") do (
    if exist "%%D\manifest.json" (
        for /f "delims=" %%i in ('jq -r ".header.name" "%%D\manifest.json"') do (
            set "packName=%%i"
            for /f "delims=" %%j in ('jq -r ".header.uuid" "%%D\manifest.json"') do (
                set /a counter+=1
                set "packuuid=%%j"
                set "!packuuid!=!packName!"
                echo [92m!counter!. !packName![0m
                echo !packuuid!
            )
            echo.
        )
    )
)
::echo.
::echo [93m[*] Listing variables...[0m
::echo.
::set 
echo.
echo [93m[*] Listing DONE^^![0m

endlocal
