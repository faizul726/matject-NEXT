@echo off
if not defined murgi echo [41;97mYou can't open me directly[0m :P & cmd /k

if defined debugMode echo parsing version
if defined debugMode echo hmm PVER=!packVer!
if defined debugMode echo hmm PVER2=!packVer2!
if defined debugMode pause

set packVer=
set packVer2=
for /f "delims=" %%a in ('jq -cr ".[0].version | join(\"\")" "%gamelocation%\minecraftpe\global_resource_packs.json"') do set packVer=%%a
for /f "delims=" %%b in ('jq -cr ".[0].version | join(\".\")" "%gamelocation%\minecraftpe\global_resource_packs.json"') do set packVer2=%%b

if defined debugMode echo 1=!packVer! 2=!packVer2!