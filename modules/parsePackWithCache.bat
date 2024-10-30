set packUuid=
set hasSubpack=
for /f "delims=" %%i in ('jq -r ".[0].pack_id" "%gamelocation%\minecraftpe\global_resource_packs.json"') do set "packUuid=%%i"
if !packUuid! equ null goto:EOF
call "modules\parsePackVersion"
set packPath=!%packUuid%_%packVer%!
for /f "delims=" %%i in ('jq -r ".header.name" "!%packPath%!\manifest.json"') do set "packName=%%i"
for /f "delims=" %%j in ('jq ".[0] | has(\"subpack\")" "%gamelocation%\minecraftpe\global_resource_packs.json"') do set "hasSubpack=%%j"
echo !WHT!^> First activated pack: !GRN!!packName!!RST!
echo !WHT!^> hasSubpack: !GRN!!hasSubpack!!RST!
echo !WHT!^> Pack path: !GRN!!packPath!!RST!