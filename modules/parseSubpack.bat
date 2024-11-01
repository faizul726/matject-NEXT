@echo off
if not defined murgi echo [41;97mYou can't open me directly[0m :P & cmd /k

for /f "delims=" %%i in ('jq -r ".[0].subpack" "%gamelocation%\minecraftpe\global_resource_packs.json"') do set "subpackName=%%i"
echo [97m^> Subpack name: [92m!subpackName![0m
