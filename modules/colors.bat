@echo off
if not defined murgi echo [41;97mYou can't open me directly[0m :P & cmd /k

set "GRY=[90m"
set "RED=[91m"
set "GRN=[92m"
set "YLW=[93m"
set "BLU=[94m"
set "CYN=[96m"
set "WHT=[97m"
set "RST=[0m"
set "ERR=[41;97m"

if defined debugMode echo Loaded colors
if defined debugMode pause