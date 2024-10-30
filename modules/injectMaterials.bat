echo !GRN![*] Found !SRCCOUNT! material(s) in the "MATERIALS" folder.!RST!
echo.

msg * /w Resource packs changed... please confirm...

echo !YLW![Injecting !packName! + !subpackName!]!RST!

pause

if exist ".settings\.bins.log" call "modules\restoreMaterials"

echo !YLW![*] Deleting materials to replace...!RST!
"%ProgramFiles(x86)%\IObit\IObit Unlocker\IObitUnlocker" /advanced /delete !REPLACELIST!

echo.

echo !YLW![*] Replacing materials...!RST!
"%ProgramFiles(x86)%\IObit\IObit Unlocker\IObitUnlocker" /advanced /move !SRCLIST! "!MCLOCATION!\data\renderer\materials"

echo !GRN![*] Succeed.!RST!


echo !REPLACELIST! > ".settings\.replaceList.log" && echo !BINS! > ".settings\.bins.log"