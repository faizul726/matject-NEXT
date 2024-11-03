@echo off
if not defined murgi echo [41;97mYou can't open me directly[0m :P & cmd /k

if defined debugMode echo listing materials
if defined debugMode pause

:list

if defined debugMode echo srccount=!SRCCOUNT!, srclist=!SRCLIST!, replacelist=!REPLACELIST!, bins=!BINS!, replacelist3=!REPLACELIST3!

set SRCCOUNT=
set SRCLIST=
set REPLACELIST=
set REPLACELIST3=
set BINS=
set MTBIN=

if defined debugMode echo PPATH for copying bins=!packPath!
if defined debugMode echo cd=%cd%
if defined debugMode echo hasSubRP???=!hasSubpack!
if defined debugMode pause


if not exist "MATERIALS" echo mkdir MATERIALS -,- && mkdir MATERIALS
copy "!packPath!\renderer\materials\*.bin" "%cd%\MATERIALS\"

if "!hasSubpack!" equ "true" copy "!packPath!\subpacks\!subpackName!\renderer\materials\*.bin" "%cd%\MATERIALS"

set SRCLIST=
set REPLACELIST=
set REPLACELIST3=
set BINS=
set SRCCOUNT=

if defined debugMode echo TWICE -^> srccount=!SRCCOUNT!, srclist=!SRCLIST!, replacelist=!REPLACELIST!, bins=!BINS!
if defined debugMode pause 

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

if defined debugMode echo SRCLIST=!SRCLIST!
if defined debugMode echo REPLACELIST=!REPLACELIST!
if defined debugMode echo REPLACELIST=!REPLACELIST3!
if defined debugMode pause

goto:EOF