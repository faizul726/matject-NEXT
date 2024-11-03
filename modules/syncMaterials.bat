if not defined murgi echo [41;97mYou can't open me directly[0m :P & cmd /k

echo !YLW![*] Syncing with current global resource packs...!RST!
echo.

for /f "delims=" %%i in ('jq -r ".[0].pack_id" "%gamelocation%\minecraftpe\global_resource_packs.json"') do set "packUuid=%%i"

if defined debugMode echo pUUID -^> !packUuid!
if defined debugMode pause

if "!packUuid!" equ "null" (
    echo !YLW![*] No packs enabled.!RST!
    echo.
    goto nopacks
)
goto version

:nopacks
if defined debugMode echo noPACKS found
if defined debugMode pause
if exist ".settings\.bins.log" goto restorevanilla
goto:EOF

:restorevanilla
call "modules\restoreMaterials"
del /q /s ".settings\lastPack.txt" > NUL
goto:EOF

:version
for /f "delims=" %%a in ('jq -cr ".[0].version | join(\"\")" "%gamelocation%\minecraftpe\global_resource_packs.json"') do set packVer=%%a
if defined debugMode echo 1. pVer !pVer!
if defined debugMode pause
for /f "delims=" %%a in ('jq -cr ".[0].version | join(\".\")" "%gamelocation%\minecraftpe\global_resource_packs.json"') do set packVer2=%%a
if defined debugMode echo 2. pVer2 !pVer2!
if defined debugMode pause
for /f "delims=" %%j in ('jq ".[0] | has(\"subpack\")" "%gamelocation%\minecraftpe\global_resource_packs.json"') do set "hasSubpack=%%j"
if defined debugMode echo 3. hasSubpack? !hasSubpack!
if defined debugMode pause
if "!hasSubpack!" equ "true" for /f "delims=" %%i in ('jq -r ".[0].subpack" "%gamelocation%\minecraftpe\global_resource_packs.json"') do set "subpackName=%%i"
if defined debugMode echo 4. subpackName? !subpackName!
if defined debugMode pause

set packPath=!%packUuid%_%packVer%!
if defined debugMode echo 5. pPath !packPath!

if not exist "!packPath!\renderer\" goto nopacks

for /f "delims=" %%i in ('jq -r ".header.name" "!%packPath%!\manifest.json"') do set "packName=%%i"

if defined debugMode echo syncpName !packName!

if "!hasSubpack!" equ "true" (
    if defined debugMode echo fullpack
    set "currentPack=!packName!_!packVer!_!subpackName!"
) else (
    if defined debugMode echo minpack
    set "currentPack=!packName!_!packVer!"
)

if defined debugMode echo !currentPack!


if exist ".settings\lastPack.txt" goto compare
if defined debugMode echo calling listMaterials from sync
if defined debugMode pause
call "modules\listMaterials"
if defined debugMode echo calling injectMaterials from sync
if defined debugMode pause
call "modules\injectMaterials"
echo !currentPack! > ".settings\lastPack.txt"
goto:EOF

:compare
if defined debugMode echo lastpack found comparing
if defined debugMode echo cpack !currentPack!
pause
set "currentPack2=%currentPack: =%"
if defined debugMode echo cpack2 !currentPack2!
if defined debugMode pause
set /p lastPack=<".settings\lastPack.txt"
if defined debugMode echo lPack !lastPack!
if defined debugMode pause
set "lastPack=%lastPack: =%"
if defined debugMode echo lPack trimmed !lastPack!

if "!currentPack2!" neq "!lastPack!" goto newject
if defined debugMode echo koshto
goto:EOF
:newject
if defined debugMode echo calling listMaterials from newject
if defined debugMode pause
call "modules\listMaterials"
if defined debugMode echo calling injectMaterials from newject
if defined debugMode pause
call "modules\injectMaterials"

if defined debugMode echo cPack2 from newject !currentPack2!
if defined debugMode pause

echo !currentPack2! > ".settings\lastPack.txt"
goto:EOF