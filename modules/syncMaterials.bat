if not defined murgi echo [41;97mYou can't open me directly[0m :P & cmd /k

echo !YLW![*] Syncing with current global resource packs...!RST!
echo.

for /f "delims=" %%i in ('jq -r ".[0].pack_id" "%gamelocation%\minecraftpe\global_resource_packs.json"') do set "packUuid=%%i"

echo pUUID -^> !packUuid!
pause

if "!packUuid!" equ "null" (
    echo !YLW![*] No packs enabled.!RST!
    echo.
    goto nopacks
)
goto version

:nopacks
echo noPACKS found
pause
if exist ".settings\.bins.log" goto restorevanilla
goto:EOF

:restorevanilla
call "modules\restoreMaterials"
del /q /s ".settings\lastPack.txt" > NUL
goto:EOF

:version
for /f "delims=" %%a in ('jq -cr ".[0].version | join(\"\")" "%gamelocation%\minecraftpe\global_resource_packs.json"') do set packVer=%%a
echo 1. pVer !pVer!
pause
for /f "delims=" %%a in ('jq -cr ".[0].version | join(\".\")" "%gamelocation%\minecraftpe\global_resource_packs.json"') do set packVer2=%%a
echo 2. pVer2 !pVer2!
pause
for /f "delims=" %%j in ('jq ".[0] | has(\"subpack\")" "%gamelocation%\minecraftpe\global_resource_packs.json"') do set "hasSubpack=%%j"
echo 3. hasSubpack? !hasSubpack!
pause
if "!hasSubpack!" equ "true" for /f "delims=" %%i in ('jq -r ".[0].subpack" "%gamelocation%\minecraftpe\global_resource_packs.json"') do set "subpackName=%%i"
echo 4. subpackName? !subpackName!
pause

set packPath=!%packUuid%_%packVer%!
echo 5. pPath !packPath!

if not exist "!packPath!\renderer\" goto nopacks

for /f "delims=" %%i in ('jq -r ".header.name" "!%packPath%!\manifest.json"') do set "packName=%%i"

echo syncpName !packName!

if "!hasSubpack!" equ "true" (
    echo fullpack
    set "currentPack=!packName!_!packVer!_!subpackName!"
) else (
    echo minpack
    set "currentPack=!packName!_!packVer!"
)

echo !currentPack!


if exist ".settings\lastPack.txt" goto compare
echo calling listMaterials from sync
pause
call "modules\listMaterials"
echo calling injectMaterials from sync
pause
call "modules\injectMaterials"
echo !currentPack! > ".settings\lastPack.txt"
goto:EOF

:compare
echo lastpack not found comparing
echo cpack !currentPack!
pause
set "currentPack2=%currentPack: =%"
echo cpack2 !currentPack2!
pause
set /p lastPack=<".settings\lastPack.txt"
echo lPack !lastPack!
pause
set "lastPack=%lastPack: =%"
echo lPack trimmed !lastPack!

if "!currentPack2!" neq "!lastPack!" goto newject
echo koshto
goto:EOF
:newject
echo calling listMaterials from newject
pause
call "modules\listMaterials"
echo calling injectMaterials from newject
pause
call "modules\injectMaterials"

echo cPack2 from newject !currentPack2!
pause

echo !currentPack2! > ".settings\lastPack.txt"
goto:EOF