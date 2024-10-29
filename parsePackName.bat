for /f "delims=" %%i in ('jq -r ".[0].pack_id" "%gamelocation%\minecraftpe\global_resource_packs.json"') do set "uuid=%%i"
for /d %%D in ("%gamelocation%\resource_packs\*") do (
    if exist "%%D\manifest.json" (
        for /f "delims=" %%i in ('jq -r ".header.name" "%%D\manifest.json"') do (
            set "packName=%%i"
            for /f "delims=" %%j in ('jq -r ".header.uuid" "%%D\manifest.json"') do (
                set "packuuid=%%j"
                if !packuuid! equ %uuid% (
                    echo [97m^> First activated pack: [92m!packName![0m
                    for /f "delims=" %%i in ('jq ".[0] | has(\"subpack\")" "%gamelocation%\minecraftpe\global_resource_packs.json"') do (
                        set "hasSubpack=%%i"
                        echo [97m^> hasSubpack: [92m!hasSubpack![0m
                        if !hasSubpack! equ true (call parseSubpack) else (goto:EOF)
                    )
                )
            )
        )
    )
)
if !jqoutput! equ true call parseSubpack