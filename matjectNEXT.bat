
@echo off
setlocal enabledelayedexpansion
cls



:: VARIABLES
cd %~dp0
set "title=matjectNEXT v0.3.2"
title %title%

set "murgi=khayDhan"

set "gameLocation=%localappdata%\Packages\Microsoft.MinecraftUWP_8wekyb3d8bbwe\LocalState\games\com.mojang"
set ranOnce=".settings\ranOnce.txt"
set lastPack=".settings\lastPack.txt"
set synced=".settings\synced.txt"

set disableModuleVerification=".settings\disableModuleVerification"
set thanksMcbegamerxx954=".settings\thanksMcbegamerxx954"
set disableInjectionPrompt=".settings\disableInjectionPrompt"
set disableInterruptionCheck=".settings\disableInterruptionCheck"
set useAutoAlways=".settings\useAutoAlways"
set useManualAlways=".settings\useManualAlways"
set customMinecraftPath=".settings\customMinecraftPath.txt"



:: MODULE VERIFICATION
set "hash=9909ECFBCA81E2F26905E9D3B68D7F0C0A1926C4705F288EE16C32F3C318DAD7D680C932B8F4C9C196573207C549DC357F95CE3E294F0AD4EE845BD4FB091147651C8D5C85D0874C536684405FA1225ED3C11A356798FDF4199FF3A4976471D20AC61EACE9CB0FFB5247A159CC6B9E3176057288BC6E78CD288E898BE9596B77A7DE1C33F88530F1A5518B652696F9EA27A67BFCDC7C3C6491EB4EEA727C83CD49696FB278D79A5193C01E8383ECBAB26F9B540ECC8F10F9B7D244B5587F6B66E3B0C44298FC1C149AFBF4C8996FB92427AE41E4649B934CA495991B7852B8557A86F4E7403CCE0162B68015A44472A3FF01C7C95DEAEB1C6E9B95706925A509F267EFC30FA794D690A3BE8464B4EE33102241D086A3F8AD5E6DCCD9D01B93307AD79F8A70774978BD3C0D95D471DA24D73C80311EE5E14908A8FDA313D2B42B13552B0E9AA75E1015E8D9A76F9C904D316B7C6682113E8BB1BD2A7A7A268CB1D8FAB30F15A90E87E466646802C0C553A4BAB164AE979E0A4C598A908D0669E7D3017E3BED1BAA56EC3C0E70A3B65EEE67F0BDEC684583C8A241EDA8467AF9637AB4B05E1E0D9BA4B637A9A1B5783B67A5D5EA03579ABFBE5EFF6A7399AED3517181995FFF7402F170DD361CC6960CE0E7FDA06CBC507A85BD2900835ACE9AE79AC44003629BF83629BF5C1D213A71135352C485EB69AFE7E59AED7DA66FAEA7"

if exist %disableModuleVerification% (
    echo [93m[*] Verifying modules...[0m
    echo.

    pushd "modules"
    for /f "delims=" %%g in ('powershell -Command "(Get-FileHash -Path 'about.bat','backupMaterials.bat','cachePacks.bat','colors.bat','getMaterialUpdater.bat','getMinecraftLocation.bat','help.bat','injectMaterials.bat','listMaterials.bat','parsePackVersion.bat','parsePackWithCache.bat','parseSubpack.bat','restoreMaterials.bat','settings.bat','syncMaterials.bat','updateMaterials.bat' | Select-Object -ExpandProperty Hash) -join ''"') do set "SHA256=%%g"
    popd
    if !SHA256! neq %hash% (
        echo [41;97m[^^!] One or more modules has been modified or missing, matjectNEXT won't work without original modules^^!!RST![0m
        echo.

        set /p "noCheck= Type [91mNOCHECK[0m to disable module check IF YOU KNOW WHAT YOU'RE DOING: [91m"    
        echo.

        if "!noCheck!" neq "NOCHECK" (
            echo [41;97m[^^!] WRONG INPUT[0m
            echo.

            echo Press any key to exit... && pause > NUL && exit
        ) else (
            echo. > %disableModuleVerification%
            echo [93m[^^!] Module check disabled.[0m
        )
    ) else (
        echo [92m[*] Modules OK[0m
    )
    echo.
)

if exist ".settings\debugMode.txt" set "debugMode=1"

:: LOAD COLORS MODULE
call "modules\colors"



:: FIRST RUN

if not exist ".settings" mkdir .settings

if exist %ranOnce% goto loadModules

echo !WHT!Welcome to %title%^^!!RST! ^(for the very first time^)
echo.
echo.

echo !ERR!=== ATTENTION ===!RST!!YLW!
echo.

echo * This is still an experimental project, bugs are expected.
echo * It assumes you HAVE NOT made any changes to materials, because it needs a copy of original materials to work properly.
echo * It is still missing some features of Matject. But works though...
echo * Make sure the shader you are using SUPPORTS Windows ^(or says merged^)
echo * These scripts do not play nice with antivirus, encryption or any other similar restrictions.
echo * The worst thing that can happen with is material corruption. In that case you can reinstall Minecraft or restore materials.!RST!
echo.
echo.

set /p "firstRun= Type !GRN!yes!RST! to confirm:!GRN! "
echo.

if "!firstRun!" neq "yes" (
    echo !ERR![^^!] WRONG INPUT!RST!
    echo.

    echo Press any key to exit... && pause > NUL && exit
) else (
    echo !GRN![*] Confirmed.!RST!
    echo.

    echo First ran on: %date% - %time% > !ranOnce!

    timeout 2 > NUL
)



:: LOAD OTHER MODULES
:loadModules

if not exist "jq.exe" (
    cls
    call "modules\getJQ"
)

if not exist "%ProgramFiles(x86)%\IObit\IObit Unlocker\IObitUnlocker.exe" (
    cls
    echo !RED![^^!] You don't have IObit Unlocker installed. Get it from: !CYN!www.iobit.com/en/iobit-unlocker.php!RST!
    echo Press any key to exit... && pause > NUL && exit
)



if exist %customMinecraftPath% (
    set /p MCLOCATION=<%customMinecraftPath%
    echo !YLW![*] Using custom Minecraft path: "!MCLOCATION!"
    echo.
    if not exist "!MCLOCATION!\AppxManifest.xml" (
        echo !ERR![^^!] Custom Minecraft path doesn't exist.!RST!
        echo.

        call "modules\getMinecraftLocation"
        echo.

        echo !GRN!TIP: You may disable custom Minecraft path in settings to remove this error.!RST!
        echo.
    )
) else (
    call "modules\getMinecraftLocation"
)

if not exist "materials.bak\" (
    call "modules\backupMaterials"
)
call "modules\cachePacks"

timeout 2 > NUL

cls

if not exist %disableInterruptionCheck% (
    if exist ".settings\taskOngoing.txt" (
        echo !ERR![^^!] It seems like last injection didn't complete successfully.!RST!
        echo.

        echo !YLW![?] Do you want to perform a full restore? [Y/N]!RST!
        echo.

        choice /c yn /n
        if !errorlevel! equ 1 (set "RESTORETYPE=full" && call "modules\restoreMaterials") else echo Press any key to exit... && pause > NUL && exit
    )
)

if not exist "%gameLocation%\minecraftpe\global_resource_packs.json" (
    echo !ERR![^^!] global_resource_packs.json not found.!RST!
    echo [] > "%gameLocation%\minecraftpe\global_resource_packs.json"
)

if defined debugMode echo calling syncMaterials
if defined debugMode pause
call "modules\syncMaterials"
if defined debugMode echo end syncMaterials
if defined debugMode pause

if exist %useAutoAlways% (
    set mode=1
    set "userMode=Auto mode"
    goto userMode
) else (
    if exist %useManualAlways% (
        set mode=2
        set "userMode=Manual mode"
        goto userMode
    ) else (
        goto start
    )
)



:: CHECK USER SELECTED MODE
:userMode
echo !YLW![*] Opening !userMode! in 5 seconds...!RST!
echo !YLW!    Press [S] to open settings directly...!RST!
echo.

choice /c s0 /t 5 /d 0 /n > NUL

if !errorlevel! equ 1 goto option-4
goto option-!mode!



:: HOMEPAGE
:start
if defined debugMode echo LABEL START 
if defined debugMode pause
cls
echo !WHT!Welcome to %title%^^!!RST!
echo.

echo !YLW![?] Which mode would you like to use?
echo.

echo !GRN![1] Auto!RST!
echo Looks for changes in global resource packs, if any change is detected proceeds to injection with the top most pack.
echo.

echo !BLU![2] Manual (one time)!RST!
echo Injects the top most pack and closes.
echo.
echo.

echo !WHT![H] Help ^(WIP^)    [S] Settings    [A] About    [B] Exit!RST!
echo.

choice /c 12hsab /n

if defined debugMode echo going option-!errorlevel!
goto option-!errorlevel!



:: EXIT
:option-6
if defined debugMode echo pause
if defined debugMode pause
exit



:: ABOUT
:option-5
if defined debugMode echo calling about
if defined debugMode pause
call "modules\about"
if defined debugMode echo end about
if defined debugMode pause
goto start



:: SETTINGS
:option-4
if defined debugMode echo calling settings
if defined debugMode pause
call "modules\settings"
if defined debugMode echo end settings
if defined debugMode pause
title %title%
goto start



:: HELP
:option-3
if defined debugMode echo calling help
if defined debugMode pause
call "modules\help"
goto start



:: MANUAL MODE
:option-2
cls
echo !YLW!BOO^^! This is still work in progress!RST!
echo.

echo !YLW!Press any key to go back...!RST!
pause > NUL
goto start



:: AUTO MODE
:option-1
cls

title %title% (Watcher mode)



:: MONITOR RESOURCE PACKS
:monitorStart
echo !YLW![*] Monitoring resource packs...!RST! (cooldown 5s)
echo.

for /f "delims=" %%i in ('jq -r ".[0].pack_id" "%gamelocation%\minecraftpe\global_resource_packs.json"') do set "packUuid=%%i"

if defined debugMode echo PACKUUID !packUuid!

if "!packUuid!" equ "null" (
    if defined debugMode echo uuid NULL
    set "lPack=rwxrw-r--"
    goto monitor
)

if defined debugMode echo lPack=!lPack!

for /f "delims=" %%a in ('jq -cr ".[0].version | join(\"\")" "%gamelocation%\minecraftpe\global_resource_packs.json"') do set packVer=%%a

if defined debugMode echo PACKVER=!packVer!

for /f "delims=" %%j in ('jq ".[0] | has(\"subpack\")" "%gamelocation%\minecraftpe\global_resource_packs.json"') do set "hasSubpack=%%j"

if defined debugMode echo hasSubpack=!hasSubpack!
if "!hasSubpack!" equ "true" (for /f "delims=" %%i in ('jq -r ".[0].subpack" "%gamelocation%\minecraftpe\global_resource_packs.json"') do set "subpackName=%%i") else (set "subpackName=")

if defined debugMode echo SUBPACKNAME=!subpackName!

if "!hasSubpack!" equ "true" (
    if defined debugMode echo IF
    set "lPack=!packName!_!packVer!_!subpackName!"
) else (
    if defined debugMode echo ELSE
    set "lPack=!packName!_!packVer!"
)

if defined debugMode echo LPACK=!lpack!

set "lPack=%lPack: =%"

if defined debugMode echo LPACK trimmed=!lPack!

:monitor
if defined debugMode echo LABEL MONITOR started
for /f %%z in ('forfiles /p "%gameLocation%\minecraftpe" /m global_resource_packs.json /c "cmd /c echo @fdate__@ftime"') do set "modifytime=%%z"
if defined modtime (
    if !modtime! neq !modifytime! (
        set monitoring=
        echo.

        echo !YLW!^> Resource packs changed ^(!modifytime!^)!RST!
        set "modtime=!modifytime!"
        if defined debugMode echo calling parsePackWithCache from NEXT
        if defined debugMode pause
        call "modules\parsePackWithCache"
        if defined debugMode echo ended parsePack from NEXT

        if defined debugMode echo PACKUUID=!packUuid!

        if !packUuid! equ null (
            echo.
            echo !RED![^^!] No pack is enabled, restoring to default...!RST!
            if exist ".settings\lastPack.txt" (del /q /s ".settings\lastPack.txt" > NUL)
            if defined debugMode echo calling restoreMaterials from next
            if defined debugMode pause
            call "modules\restoreMaterials"
            if defined debugMode echo end restore from next
            goto monitor
        ) else (
            if defined debugMode echo in ELSE of NULL
            if defined debugMode echo PACKPATH=!packPath!
            if not exist "!packPath!\renderer\" (
                echo !RED![^^!] Not a shader, restoring to default...!RST!
                if exist ".settings\lastPack.txt" (del /q /s ".settings\lastPack.txt" > NUL)
                if defined debugMode echo CPACK=!cPack!
                set cPack=
                if defined debugMode echo calling restore from else of null
                if defined debugMode pause
                call "modules\restoreMaterials"
                if defined debugMode echo end restore from else of null
                ) else (
                    if defined debugMode echo in else of else
                    if defined debugMode echo ISSAME=!isSame!
                    if defined debugMode pause
                    if "!isSame!" equ "true" goto monitor

                    if defined debugMode echo calling list from else of else 
                    if defined debugMode pause
                    call "modules\listMaterials"
                    if defined debugMode echo end list from else of else 
                    if defined debugMode echo calling inject from else of else 
                    if defined debugMode pause
                    call "modules\injectMaterials"
                    if defined debugMode echo end inject from else of else 
                    goto monitor
                    )
                )
            )
    timeout 5 > NUL
    goto monitor
) else (
    if defined debugMode echo set modtime for the first time
    set "modtime=!modifytime!"
    goto monitor
)