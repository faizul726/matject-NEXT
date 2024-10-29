set "gamelocation=%localappdata%\Packages\Microsoft.MinecraftUWP_8wekyb3d8bbwe\LocalState\games\com.mojang"
for /f "delims=" %%i in ('jq -r ".[0].pack_id" "%gamelocation%\minecraftpe\global_resource_packs.json"') do set uuid=%%i
if !uuid! equ null goto:EOF
for /f "delims=" %%i in ('jq -r ".header.name" "!%uuid%!\manifest.json"') do set "packName=%%i"
for /f "delims=" %%j in ('jq ".[0] | has(\"subpack\")" "%gamelocation%\minecraftpe\global_resource_packs.json"') do set "hasSubpack=%%j"
set packPath=!%uuid%!
echo [97m^> First activated pack: [92m!packName![0m
echo [97m^> hasSubpack: [92m!hasSubpack![0m
if !hasSubpack! equ true call "modules\parseSubpack"
echo [97m^> Pack path: [92m!packPath![0m