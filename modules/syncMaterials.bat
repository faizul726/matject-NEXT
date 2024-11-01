if not defined murgi echo [41;97mYou can't open me directly[0m :P & cmd /k

set "gameLocation=%localappdata%\Packages\Microsoft.MinecraftUWP_8wekyb3d8bbwe\LocalState\games\com.mojang"
for /f "delims=" %%i in ('jq -r ".[0].pack_id" "%gamelocation%\minecraftpe\global_resource_packs.json"') do set "packUuid=%%i"

if "!packUuid!" equ "null" (
    echo !YLW! [*] No packs enabled.
    echo.
    goto nopacks
)
goto version

:nopacks
if exist ".settings\.bins.log" goto restorevanilla
goto:EOF

:restorevanilla
call "modules\restoreMaterials"
del /q /s ".settings\lastPack.txt" > NUL
goto:EOF

:version
for /f "delims=" %%a in ('jq -cr ".[0].version | join(\"\")" "%gamelocation%\minecraftpe\global_resource_packs.json"') do set packVer=%%a
for /f "delims=" %%a in ('jq -cr ".[0].version | join(\".\")" "%gamelocation%\minecraftpe\global_resource_packs.json"') do set packVer2=%%a
for /f "delims=" %%j in ('jq ".[0] | has(\"subpack\")" "%gamelocation%\minecraftpe\global_resource_packs.json"') do set "hasSubpack=%%j"
if "!hasSubpack!" equ "true" for /f "delims=" %%i in ('jq -r ".[0].subpack" "%gamelocation%\minecraftpe\global_resource_packs.json"') do set "subpackName=%%i"

set packPath=!%packUuid%_%packVer%!
if not exist "!packPath!\renderer\" goto nopacks

for /f "delims=" %%i in ('jq -r ".header.name" "!%packPath%!\manifest.json"') do set "packName=%%i"

if "!hasSubpack!" equ "true" (
    set "currentPack=!packName!_!packVer!_!subpackName!"
) else (
    set "currentPack=!packName!_!packVer!"
)


if exist ".settings\lastPack.txt" goto compare
call "modules\listMaterials"
call "modules\injectMaterials"
echo !currentPack! > ".settings\lastPack.txt"
goto:EOF

:compare
set "currentPack2=%currentPack: =%"
set /p lastPack=<".settings\lastPack.txt"
set "lastPack=%lastPack: =%"

if "!currentPack2!" neq "!lastPack!" goto newject
goto:EOF
:newject
call "modules\listMaterials"
call "modules\injectMaterials"

echo !currentPack2! > ".settings\lastPack.txt"
goto:EOF