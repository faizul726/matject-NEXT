@echo off
if not defined murgi echo [41;97mYou can't open me directly[0m :P & cmd /k

if defined debugMode echo parsing pack using cache
if defined debugMode pause

set packUuid=
set hasSubpack=
for /f "delims=" %%i in ('jq -r ".[0].pack_id" "%gamelocation%\minecraftpe\global_resource_packs.json"') do set "packUuid=%%i"
if defined debugMode echo PUUID from parser !packUuid!
if !packUuid! equ null goto:EOF

if defined debugMode echo calling version parser from wCache
if defined debugMode pause
call "modules\parsePackVersion"
if defined debugMode echo end ver parser from wcache

if defined debugMode echo variable=%packUuid%_%packVer%

set packPath=!%packUuid%_%packVer%!

if defined debugMode echo rppath=!packPath!

if defined debugMode pause


for /f "delims=" %%i in ('jq -r ".header.name" "!%packPath%!\manifest.json"') do set "packName=%%i"
if defined debugMode echo rpname=!packName!
if defined debugMode pause
for /f "delims=" %%j in ('jq ".[0] | has(\"subpack\")" "%gamelocation%\minecraftpe\global_resource_packs.json"') do set "hasSubpack=%%j"

if defined debugMode echo rphassubpack=!hasSubpack!
if defined debugMode pause

echo !WHT!^> First activated pack: !GRN!!packName! v!packVer2!!RST!
echo !WHT!^> hasSubpack: !GRN!!hasSubpack!!RST!
if "!hasSubpack!" equ "true" if defined debugMode echo calling subpack parser from wcache && pause && call "modules\parseSubpack" && if defined debugMode echo end subpack parser from wcache
echo !WHT!^> Pack path: !GRN!!packPath!!RST!

if defined debugMode echo crp=!cpack!

if "!hasSubpack!" equ "true" (
    set "cPack=!packName!_!packVer!_!subpackName!"
) else (
    set "cPack=!packName!_!packVer!"
)

if defined debugMode echo crp_u=!cpack!

set "cPack=%cPack: =%"

if defined debugMode echo crp trimmed=!cpack!

if defined debugMode echo CRP=!cpack!
if defined debugMode echo LRP=!lpack!

if "!cPack!" equ "!lPack!" (
    if defined debugMode echo in IF of equ
    if defined debugMode pause
    echo !YLW![*] Top most pack unchanged, skipping injection...!RST!
    set isSame=true
    goto:EOF
) else (
    if defined debugMode echo ISSAMEEE?=!isSame!
    if defined debugMode echo in else of equ
    if defined debugMode pause
    set isSame=
    goto:EOF
)

