if not exist "!packPath!\renderer\" (
    if exist ".settings\.bins.log" (
        echo !RED![^^!] Not a shader, restoring default...!RST!
        call "modules\restoreMaterials"
        goto:EOF
    )
    echo !RED![^^!] Not a shader, skipping...!RST!
    goto:EOF
)

copy "!packPath!\renderer\materials\*.bin" "%cd%\MATERIALS\"
if !hasSubpack! equ true copy "!packPath!\subpacks\!subpackName!\renderer\materials\*.bin" "%cd%\MATERIALS"

set SRCLIST=
set REPLACELIST=
set BINS=
set SRCCOUNT=
for %%f in (MATERIALS\*) do (
    set SRCLIST=!SRCLIST!,"%cd%\%%f"
    set "BINS=!BINS!"%%~nxf" "
    set REPLACELIST=!REPLACELIST!,"%MCLOCATION%\data\renderer\%%f"
    set /a SRCCOUNT+=1
)

set "SRCLIST=%SRCLIST:~1%"
set "REPLACELIST=%REPLACELIST:~1%"

call "modules\injectMaterials"