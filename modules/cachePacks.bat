echo !YLW![*] Caching resource packs...!RST!
echo.
for /d %%D in ("%localappdata%\Packages\Microsoft.MinecraftUWP_8wekyb3d8bbwe\LocalState\games\com.mojang\resource_packs\*") do (
    if exist "%%D\manifest.json" (
        for /f "delims=" %%i in ('jq -r ".header.name" "%%D\manifest.json"') do (
            for /f "delims=" %%j in ('jq -r ".header.uuid" "%%D\manifest.json"') do (
                for /f "delims=" %%k in ('jq -cr ".header.version | join(\"\")" "%%D\manifest.json"') do (
                    set "packName=%%i"
                    set /a counter+=1
                    set "%%j_%%k=%%D"
                    echo !counter!. !packName!
                )
            )
        )
    )
)
echo.
echo !YLW![*] Caching OK!RST!
echo.
echo.