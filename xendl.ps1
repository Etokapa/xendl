Write-Host "Xendl v1.7 by Etokapa" -ForegroundColor Yellow #Improvements welcome.
""
""
""
""
""
""

Write-Host "Downloading Latest Master, Canary EX, & STFS-Writer Builds..."

[void][Reflection.Assembly]::LoadWithPartialName("System.Threading")
function Wait-Task {
    param([Parameter(Mandatory, ValueFromPipeline)][System.Threading.Tasks.Task[]]$Task)
    Begin {$Tasks = @()}
    Process {$Tasks += $Task}
    End {While(-not [System.Threading.Tasks.Task]::WaitAll($Tasks, 200)){};$Tasks.ForEach({$_.GetAwaiter().GetResult()})}
}
Set-Alias -Name await -Value Wait-Task -Force
@(
    (New-Object System.Net.WebClient).DownloadFileTaskAsync("https://github.com/xenia-project/release-builds-windows/releases/latest/download/xenia_master.zip","xenia_master.zip")
    (New-Object System.Net.WebClient).DownloadFileTaskAsync("https://github.com/epozzobon/xenia/releases/latest/download/xenia_stfs-writer.zip","xenia_stfs-writer.zip")
    (New-Object System.Net.WebClient).DownloadFileTaskAsync("https://github.com/xenia-canary/xenia-canary/releases/download/experimental/xenia_canary.zip","xenia_canary_EX.zip")
) | await

Write-Host -NoNewLine "Extracting..."
Expand-Archive xenia_master.zip; Expand-Archive xenia_canary_EX.zip; Expand-Archive xenia_stfs-writer.zip
Move-Item -Force ".\xenia_master\xenia.exe" ".\xenia.exe"; Move-Item -Force ".\xenia_canary_EX\xenia_canary.exe" ".\xenia_canary_EX.exe"; Move-Item -Force ".\xenia_stfs-writer\xenia.exe" ".\xenia_STFS-Writer.exe"
""
""
Write-Host -NoNewLine " Cleaning up..."
Remove-Item -Recurse xenia_master; Remove-Item xenia_master.zip; Remove-Item -Recurse xenia_canary_EX; Remove-Item xenia_canary_EX.zip; Remove-Item -Recurse xenia_stfs-writer; Remove-Item xenia_stfs-writer.zip
""
""
Write-Host -NoNewLine " Done!"
""
""
Write-Host "Removing old patches..."
Remove-Item -Recurse .\patches
Write-Host "Downloading Canary Patches..."; Invoke-WebRequest "https://github.com/xenia-canary/game-patches/archive/main.zip" -O main.zip
Write-Host -NoNewLine "Extracting..."
Expand-Archive main.zip
Move-Item -Force ".\main\game-patches-main\patches" ".\"
Write-Host -NoNewLine " Cleaning up..."
Remove-Item main.zip
Remove-Item -Recurse main
Write-Host -NoNewLine " Done!"
