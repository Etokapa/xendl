Write-Host "Xendl v1.4 by Etokapa" -ForegroundColor Yellow #Improvements welcome.
""
""
""
""
""
""
Write-Host "Downloading Latest Master Build..."; curl "https://github.com/xenia-project/release-builds-windows/releases/latest/download/xenia_master.zip" -O xenia_master.zip
Write-Host -NoNewLine "Extracting..."
Expand-Archive xenia_master.zip
Move-Item -Force ".\xenia_master\xenia.exe" ".\xenia.exe"
Write-Host -NoNewLine " Cleaning up..."
Remove-Item -Recurse xenia_master
Remove-Item xenia_master.zip
Write-Host -NoNewLine " Done!"
""
""
"Downloading Latest Canary EX Build..."; curl "https://github.com/xenia-canary/xenia-canary/releases/latest/download/xenia_canary.zip" -O xenia_canary_EX.zip
Write-Host -NoNewLine "Extracting..."
Expand-Archive xenia_canary_EX.zip
Move-Item -Force ".\xenia_canary_EX\xenia_canary.exe" ".\xenia_canary_EX.exe"
Write-Host -NoNewLine " Cleaning up..."
Remove-Item -Recurse xenia_canary_EX
Remove-Item xenia_canary_EX.zip
Write-Host -NoNewLine " Done!"
""
""
Write-Host "Removing old patches..."
Remove-Item -Recurse .\patches
Write-Host "Downloading Canary Patches..."; curl "https://github.com/xenia-canary/game-patches/archive/main.zip" -O main.zip
Write-Host -NoNewLine "Extracting..."
Expand-Archive main.zip
Move-Item -Force ".\main\game-patches-main\patches" ".\"
Write-Host -NoNewLine " Cleaning up..."
Remove-Item main.zip
Remove-Item -Recurse main
Write-Host -NoNewLine " Done!"