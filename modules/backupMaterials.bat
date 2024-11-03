@echo off
if not defined murgi echo [41;97mYou can't open me directly[0m :P & cmd /k

if defined debugMode echo start backup

title %title% (making backup)

echo !GRN![*] Creating first backup...!RST!

xcopy "!MCLOCATION!\data\renderer\materials" "materials.bak" /e /i /h /y

title %title%

echo !GRN![*] Materials backup OK!RST!
echo.

if defined debugMode echo end backup 