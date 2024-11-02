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

echo PPATH for copying bins=!packPath!
echo cd=%cd%
echo hasSubRP???=!hasSubpack!
pause



copy "!packPath!\renderer\materials\*.bin" "%cd%\MATERIALS\"
if "!hasSubpack!" equ "true" copy "!packPath!\subpacks\!subpackName!\renderer\materials\*.bin" "%cd%\MATERIALS"

set SRCLIST=
set REPLACELIST=
set BINS=
set SRCCOUNT=

echo TWICE -^> srccount=!SRCCOUNT!, srclist=!SRCLIST!, replacelist=!REPLACELIST!, bins=!BINS!
pause 

if not exist "MATERIALS" echo mkdir MATERIALS -,- && mkdir MATERIALS

for %%f in (MATERIALS\*) do (
    set SRCLIST=!SRCLIST!,"%cd%\%%f"
    set "BINS=!BINS!"%%~nxf" "
    set REPLACELIST=!REPLACELIST!,"%MCLOCATION%\data\renderer\%%f"
    set /a SRCCOUNT+=1
)

set "SRCLIST=%SRCLIST:~1%"
set "REPLACELIST=%REPLACELIST:~1%"

echo SRCLIST=!SRCLIST!
echo REPLACELIST=!REPLACELIST!
pause

goto:EOF