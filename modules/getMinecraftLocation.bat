@echo off
if not defined murgi echo [41;97mYou can't open me directly[0m :P & cmd /k

echo !RST!!YLW![*] Getting Minecraft location...!RST!
for /f "tokens=*" %%i in ('powershell -command "Get-AppxPackage -Name Microsoft.MinecraftUWP | Select-Object -ExpandProperty InstallLocation"') do set "MCLOCATION=%%i"
echo.
if not defined MCLOCATION echo. & echo !ERR![^^!] Minecraft is not installed.!RST! & echo. & pause & exit