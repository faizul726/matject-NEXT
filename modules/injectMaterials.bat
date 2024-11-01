@echo off
if not defined murgi echo [41;97mYou can't open me directly[0m :P & cmd /k

echo !GRN![*] Found !SRCCOUNT! material(s) in the "MATERIALS" folder.!RST!
echo.

if exist %disableInjectionPrompt% (goto inject)
msg * Resource packs changed, injecting new materials...
echo !YLW![*] Press [Y] to confirm injection or [B] to cancel.!RST!
echo.
choice /c yb /N
if !errorlevel! neq 1 goto:EOF

:inject
echo !YLW![*] Injecting !RED!!packName! !GRN!v!packVer2! !RST!+ !BLU!!subpackName!!RST!
echo.

if exist %thanksMcbegamerxx954% call "modules\updateMaterials"

echo Yes, task ongoing -,- > ".settings\taskOngoing.txt"
if exist ".settings\.bins.log" call "modules\restoreMaterials"

echo !YLW![*] Deleting materials to replace...!RST!
"%ProgramFiles(x86)%\IObit\IObit Unlocker\IObitUnlocker" /advanced /delete !REPLACELIST!

echo.

echo !YLW![*] Replacing materials...!RST!
"%ProgramFiles(x86)%\IObit\IObit Unlocker\IObitUnlocker" /advanced /move !SRCLIST! "!MCLOCATION!\data\renderer\materials"

echo !GRN![*] Succeed.!RST!


echo !REPLACELIST! > ".settings\.replaceList.log" && echo !BINS! > ".settings\.bins.log"

if !hasSubpack! equ true (
    echo !packName!_!packVer!_!subpackName! > ".settings\lastPack.txt"
) else (
    echo !packName!_!packVer! > ".settings\lastPack.txt"
)


del /q /s ".settings\taskOngoing.txt" > NUL


if defined cPack (
    set "lPack=!cPack!"
)

goto:EOF