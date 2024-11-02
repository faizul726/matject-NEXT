@echo off
if not defined murgi echo [41;97mYou can't open me directly[0m :P & cmd /k

echo parsing pack using cache
pause

set packUuid=
set hasSubpack=
for /f "delims=" %%i in ('jq -r ".[0].pack_id" "%gamelocation%\minecraftpe\global_resource_packs.json"') do set "packUuid=%%i"
echo PUUID from parser !packUuid!
if !packUuid! equ null goto:EOF

echo calling version parser from wCache
pause
call "modules\parsePackVersion"
echo end ver parser from wcache

echo variable=%packUuid%_%packVer%

set packPath=!%packUuid%_%packVer%!

echo rppath=!packPath!

pause


for /f "delims=" %%i in ('jq -r ".header.name" "!%packPath%!\manifest.json"') do set "packName=%%i"
echo rpname=!packName!
pause
for /f "delims=" %%j in ('jq ".[0] | has(\"subpack\")" "%gamelocation%\minecraftpe\global_resource_packs.json"') do set "hasSubpack=%%j"

echo rphassubpack=!hasSubpack!
pause

echo !WHT!^> First activated pack: !GRN!!packName! v!packVer2!!RST!
echo !WHT!^> hasSubpack: !GRN!!hasSubpack!!RST!
if "!hasSubpack!" equ "true" echo calling subpack parser from wcache && pause && call "modules\parseSubpack" && echo end subpack parser from wcache
echo !WHT!^> Pack path: !GRN!!packPath!!RST!

echo crp=!cpack!

if "!hasSubpack!" equ "true" (
    set "cPack=!packName!_!packVer!_!subpackName!"
) else (
    set "cPack=!packName!_!packVer!"
)

echo crp_u=!cpack!

set "cPack=%cPack: =%"

echo crp trimmed=!cpack!

echo CRP=!cpack!
echo LRP=!lpack!

if "!cPack!" equ "!lPack!" (
    echo in IF of equ
    pause
    echo !YLW![*] Top most pack unchanged, skipping injection...!RST!
    set isSame=true
    goto:EOF
) else (
    echo ISSAMEEE?=!isSame!
    echo in else of equ
    pause
    set isSame=
    goto:EOF
)

