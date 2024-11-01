@echo off
if not defined murgi echo [41;97mYou can't open me directly[0m :P & cmd /k

xcopy "!MCLOCATION!\data\renderer\materials" "materials.bak" /e /i /h /y