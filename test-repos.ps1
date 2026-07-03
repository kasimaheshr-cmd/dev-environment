# Repo verification script
# Run from anywhere: .\test-repos.ps1

$repos = @(
    "game-of-life-api",
    "parcel-platform",
    "lpl-rag-system",
    "react-agent"
)

$results = @{}

foreach ($repo in $repos) {
    $path = "C:\Projects\$repo"
    Write-Host ""
    Write-Host "=======================================" -ForegroundColor Cyan
    Write-Host " Testing: $repo" -ForegroundColor Cyan
    Write-Host "=======================================" -ForegroundColor Cyan

    if (-not (Test-Path $path)) {
        Write-Host "SKIPPED - folder not found: $path" -ForegroundColor Yellow
        $results[$repo] = "SKIPPED (not found)"
        continue
    }

    Set-Location $path

    Write-Host "--- dotnet restore ---" -ForegroundColor DarkGray
    dotnet restore
    if ($LASTEXITCODE -ne 0) {
        Write-Host "RESTORE FAILED for $repo" -ForegroundColor Red
        $results[$repo] = "RESTORE FAILED"
        continue
    }

    Write-Host "--- dotnet build ---" -ForegroundColor DarkGray
    dotnet build --no-restore
    if ($LASTEXITCODE -ne 0) {
        Write-Host "BUILD FAILED for $repo" -ForegroundColor Red
        $results[$repo] = "BUILD FAILED"
        continue
    }

    Write-Host "--- dotnet test ---" -ForegroundColor DarkGray
    dotnet test --no-build
    if ($LASTEXITCODE -ne 0) {
        Write-Host "TESTS FAILED for $repo" -ForegroundColor Red
        $results[$repo] = "BUILD OK / TESTS FAILED"
        continue
    }

    Write-Host "SUCCESS: $repo restored, built, and tested cleanly" -ForegroundColor Green
    $results[$repo] = "SUCCESS"
}

Write-Host ""
Write-Host "=======================================" -ForegroundColor Cyan
Write-Host " SUMMARY" -ForegroundColor Cyan
Write-Host "=======================================" -ForegroundColor Cyan
foreach ($repo in $repos) {
    $status = $results[$repo]
    $color = switch -Wildcard ($status) {
        "SUCCESS" { "Green" }
        "SKIPPED*" { "Yellow" }
        default { "Red" }
    }
    Write-Host ("{0,-20} {1}" -f $repo, $status) -ForegroundColor $color
}

Set-Location C:\Projects
