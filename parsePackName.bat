for /f "delims=" %%i in ('jq -r ".[0].pack_id" "%gamelocation%\minecraftpe\global_resource_packs.json"') do set "uuid=%%i"
for /d %%D in ("%gamelocation%\resource_packs\*") do (
    if exist "%%D\manifest.json" (
        for /f "delims=" %%i in ('jq -r ".header.name" "%%D\manifest.json"') do (
            set "packName=%%i"
            for /f "delims=" %%j in ('jq -r ".header.uuid" "%%D\manifest.json"') do (
                set "packuuid=%%j"
                if !packuuid! equ %uuid% (
                    echo [97m^> Newly activated first pack is:  [92m!packName![0m
                    goto:EOF
                )
            )
        )
    )
)