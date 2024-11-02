@echo off
if not defined murgi echo [41;97mYou can't open me directly[0m :P & cmd /k

echo listing materials
pause

:list

echo srccount=!SRCCOUNT!, srclist=!SRCLIST!, replacelist=!REPLACELIST!, bins=!BINS!

set SRCCOUNT=
set SRCLIST=
set REPLACELIST=
set BINS=
set MTBIN=

echo PPATH for copying bins=!packPath!
echo cd=%cd%
echo hasSubRP???=!hasSubpack!
pause


if not exist "MATERIALS" echo mkdir MATERIALS -,- && mkdir MATERIALS
copy "!packPath!\renderer\materials\*.bin" "%cd%\MATERIALS\"

if "!hasSubpack!" equ "true" copy "!packPath!\subpacks\!subpackName!\renderer\materials\*.bin" "%cd%\MATERIALS"

set SRCLIST=
set REPLACELIST=
set BINS=
set SRCCOUNT=

echo TWICE -^> srccount=!SRCCOUNT!, srclist=!SRCLIST!, replacelist=!REPLACELIST!, bins=!BINS!
pause 

for %%f in (MATERIALS\*) do (
    set SRCLIST=!SRCLIST!,"%cd%\%%f"
    set "BINS=!BINS!"%%~nxf" "
    set "MTBIN=%%~nf"
    set "MTBIN=!MTBIN:~0,-9!"
    set "REPLACELIST=!REPLACELIST!,"_!MTBIN!-""
    set "REPLACELIST3=!REPLACELIST3!,"_!MTBIN!-""
    set /a SRCCOUNT+=1
)

set "SRCLIST=%SRCLIST:~1%"
set "REPLACELIST=%REPLACELIST:~1%"
set "REPLACELIST3=%REPLACELIST3:~1%"

set REPLACELIST=!REPLACELIST:_=%MCLOCATION%\data\renderer\materials\!
set REPLACELIST=!REPLACELIST:-=.material.bin!

echo SRCLIST=!SRCLIST!
echo REPLACELIST=!REPLACELIST!
pause

goto:EOF