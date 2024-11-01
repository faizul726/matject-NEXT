@echo off
if not defined murgi echo [41;97mYou can't open me directly[0m :P & cmd /k

echo !YLW![*] Updating materials using material-updater...!RST!
echo.

for %%m in ("MATERIALS\*.material.bin") do (
    "modules\material-updater" "%%m" -o "%%m"
)

echo !GRN![*] Materials updated to support latest version!RST!