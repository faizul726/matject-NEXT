echo !YLW![*] Getting Minecraft details...!RST!
for /f "tokens=*" %%i in ('powershell -command "Get-AppxPackage -Name Microsoft.MinecraftUWP | Select-Object -ExpandProperty InstallLocation"') do set "MCLOCATION=%%i"
if not defined MCLOCATION echo FAILED && pause && goto:EOF