@echo off
if not defined murgi echo [41;97mYou can't open me directly[0m :P & cmd /k

set packUuid=
set hasSubpack=
for /f "delims=" %%i in ('jq -r ".[0].pack_id" "%gamelocation%\minecraftpe\global_resource_packs.json"') do set "packUuid=%%i"
if !packUuid! equ null goto:EOF
call "modules\parsePackVersion"
set packPath=!%packUuid%_%packVer%!
for /f "delims=" %%i in ('jq -r ".header.name" "!%packPath%!\manifest.json"') do set "packName=%%i"
for /f "delims=" %%j in ('jq ".[0] | has(\"subpack\")" "%gamelocation%\minecraftpe\global_resource_packs.json"') do set "hasSubpack=%%j"
if !hasSubpack! equ true call "modules\parseSubpack"
echo !WHT!^> First activated pack: !GRN!!packName! v!packVer2!!RST!
echo !WHT!^> hasSubpack: !GRN!!hasSubpack!!RST!
echo !WHT!^> Pack path: !GRN!!packPath!!RST!

if "!hasSubpack!" equ "true" (
    set "cPack=!packName!_!packVer!_!subpackName!"
) else (
    set "cPack=!packName!_!packVer!"
)

set "cPack=%cPack: =%"

if "!cPack!" equ "!lPack!" (
    echo !YLW![*] Top most pack unchanged, skipping injection...!RST!
    set isSame=true
    goto:EOF
) else (
    set isSame=
    goto:EOF
)

