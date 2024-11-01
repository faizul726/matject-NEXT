@echo off
if not defined murgi echo [41;97mYou can't open me directly[0m :P & cmd /k

:list
set SRCCOUNT=
set SRCLIST=
set REPLACELIST=
set BINS=

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

goto:EOF