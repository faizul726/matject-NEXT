@echo off
if not defined murgi echo [41;97mYou can't open me directly[0m :P & cmd /k

if defined debugMode echo start backup

xcopy "!MCLOCATION!\data\renderer\materials" "materials.bak" /e /i /h /y

if defined debugMode echo end backup 