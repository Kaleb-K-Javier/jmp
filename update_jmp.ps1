# Post the latest JMP draft to https://kaleb-k-javier.github.io/jmp/Javier_JMP.pdf
# Usage: powershell -ExecutionPolicy Bypass -File C:\Users\kaleb\Documents\jmp\update_jmp.ps1 [-Source path\to\file.pdf]
param(
    [string]$Source = "C:\Users\kaleb\Documents\ust_ins_move_to_github\Reports\Paper\04_JMP_Paper.pdf"
)
$ErrorActionPreference = "Stop"
$repo = $PSScriptRoot
$dest = Join-Path $repo "Javier_JMP.pdf"
$url  = "https://kaleb-k-javier.github.io/jmp/Javier_JMP.pdf"

if (-not (Test-Path $Source)) { throw "Source PDF not found: $Source" }
$src = Get-Item $Source
Write-Host "Source: $($src.FullName)"
Write-Host "        last written $($src.LastWriteTime), $([math]::Round($src.Length / 1MB, 2)) MB"

git -C $repo pull --quiet --ff-only
if ($LASTEXITCODE -ne 0) { throw "git pull failed" }

Copy-Item $src.FullName $dest -Force
git -C $repo add Javier_JMP.pdf
git -C $repo diff --cached --quiet
if ($LASTEXITCODE -eq 0) {
    Write-Host "No change: the posted PDF is already this file."
    Write-Host $url
    exit 0
}

$stamp = $src.LastWriteTime.ToString("yyyy-MM-dd HH:mm")
git -C $repo commit --quiet -m "Update JMP draft (rendered $stamp)"
if ($LASTEXITCODE -ne 0) { throw "git commit failed" }
git -C $repo push --quiet
if ($LASTEXITCODE -ne 0) { throw "git push failed" }

Write-Host "Pushed. GitHub Pages serves the new draft within a few minutes at:"
Write-Host $url
