@echo off
echo Xendl v2.0 by Etokapa

echo Downloading Latest Master, Canary, Netplay, ^& STFS-Writer Builds...

powershell -Command "& {$Tasks = @(); (New-Object System.Net.WebClient).DownloadFileTaskAsync('https://github.com/xenia-project/release-builds-windows/releases/latest/download/xenia_master.zip', 'xenia_master.zip'); $Tasks += (New-Object System.Net.WebClient).DownloadFileTaskAsync('https://github.com/epozzobon/xenia/releases/latest/download/xenia_stfs-writer.zip', 'xenia_stfs-writer.zip'); $Tasks += (New-Object System.Net.WebClient).DownloadFileTaskAsync('https://github.com/xenia-canary/xenia-canary/releases/download/experimental/xenia_canary.zip', 'xenia_canary.zip'); $Tasks += (New-Object System.Net.WebClient).DownloadFileTaskAsync('https://github.com/AdrianCassar/xenia-canary/releases/latest/download/xenia_canary_netplay.zip', 'xenia_canary_netplay.zip'); While(-not [System.Threading.Tasks.Task]::WaitAll($Tasks, 200)){}; $Tasks.ForEach({$_.GetAwaiter().GetResult()})}"

echo Extracting...
powershell -Command "Expand-Archive xenia_master.zip; Expand-Archive xenia_canary.zip; Expand-Archive xenia_stfs-writer.zip; Expand-Archive xenia_canary_netplay.zip;"

move /Y ".\xenia_master\xenia.exe" ".\xenia.exe"
move /Y ".\xenia_canary\xenia_canary.exe" ".\xenia_canary.exe"
move /Y ".\xenia_stfs-writer\xenia.exe" ".\xenia_STFS-Writer.exe"
move /Y ".\xenia_canary_netplay\xenia_canary_netplay.exe" ".\xenia_canary_netplay.exe"

echo Cleaning up...
del /Q /F xenia_master
del /Q /F xenia_master.zip
del /Q /F xenia_canary
del /Q /F xenia_canary.zip
del /Q /F xenia_stfs-writer
del /Q /F xenia_stfs-writer.zip
del /Q /F xenia_canary_netplay
del /Q /F xenia_canary_netplay.zip

for /d %%i in (xenia_master xenia_canary xenia_stfs-writer xenia_canary_netplay) do if exist "%%i" rd /s /q "%%i"

echo Done!
echo.

if exist ".\portable.txt" (
    goto skip_portable
) else (
    echo Setting Portable Mode...
    echo. > portable.txt
    echo Done!
    echo.
)

:skip_portable

echo Removing old patches...
rmdir /Q /S .\patches
echo Downloading Canary Patches...
powershell -Command "Invoke-WebRequest 'https://github.com/xenia-canary/game-patches/archive/main.zip' -O 'main.zip'"
echo Extracting...
powershell -Command "Expand-Archive main.zip"
move /Y ".\main\game-patches-main\patches" ".\"
echo Cleaning up...
del /Q /F main.zip
rmdir /Q /S main
@echo off
echo Done! 
timeout /t 2 >nul
