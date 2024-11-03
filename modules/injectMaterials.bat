@echo off
if not defined murgi echo [41;97mYou can't open me directly[0m :P & cmd /k

if defined debugMode echo START INJECTING MATS

echo !GRN![*] Found !SRCCOUNT! material(s) in the "MATERIALS" folder.!RST!
echo.

if exist %disableInjectionPrompt% (goto inject)
msg * Resource packs changed, injecting new materials...
echo !YLW![*] Press [Y] to confirm injection or [B] to cancel.!RST!
echo.
choice /c yb /N
if defined debugMode echo ERRLVL=!errorlevel!
if !errorlevel! neq 1 goto:EOF

:inject
echo !YLW![*] Injecting !RED!!packName! !GRN!v!packVer2! !RST!+ !BLU!!subpackName!!RST!
echo.

if exist %thanksMcbegamerxx954% call "modules\updateMaterials"

echo Yes, task ongoing -,- > ".settings\taskOngoing.txt"
if exist ".settings\.bins.log" (
    if defined debugMode echo FOUND .BINS
    if defined debugMode echo calling rstrmats from inject
    if defined debugMode pause
    call "modules\restoreMaterials"
    if defined debugMode (echo end rstrmats from inject)
)

echo !YLW![*] Deleting materials to replace...!RST!

echo.
if defined debugMode echo "%ProgramFiles(x86)%\IObit\IObit Unlocker\IObitUnlocker" /advanced /delete !REPLACELIST!
echo.

"%ProgramFiles(x86)%\IObit\IObit Unlocker\IObitUnlocker" /advanced /delete !REPLACELIST!

echo.

echo !YLW![*] Replacing materials...!RST!

echo.
if defined debugMode echo "%ProgramFiles(x86)%\IObit\IObit Unlocker\IObitUnlocker" /advanced /move !SRCLIST! "!MCLOCATION!\data\renderer\materials"
echo.

"%ProgramFiles(x86)%\IObit\IObit Unlocker\IObitUnlocker" /advanced /move !SRCLIST! "!MCLOCATION!\data\renderer\materials"

echo !GRN![*] Succeed.!RST!


if defined debugMode echo RPLCLIST=!REPLACELIST!
if defined debugMode echo RPLC3LIST=!REPLACELIST3!
if defined debugMode echo BINNIE=!BINS!
if defined debugMode pause

echo !REPLACELIST3!>".settings\.replaceList.log" && echo !BINS!>".settings\.bins.log"

if defined debugMode echo DOESHAVESUBRP?=!hasSubpack!
if defined debugMode pause

if "!hasSubpack!" equ "true" (
    echo !packName!_!packVer!_!subpackName! > ".settings\lastPack.txt"
) else (
    echo !packName!_!packVer! > ".settings\lastPack.txt"
)

if defined debugMode echo COMBINED=!packName!_!packVer!_!subpackName!


del /q /s ".settings\taskOngoing.txt" > NUL

if defined debugMode echo chiken=!cpack!

if defined cPack (
    set "lPack=!cPack!"
)

if defined debugMode echo chikenReborn=!cpack!

goto:EOF